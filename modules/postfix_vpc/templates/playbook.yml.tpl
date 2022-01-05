- hosts: localhost
  vars:
    - postfix_inet_interfaces: "all"
    - cyrus_sasl_user:
        ${sasl_user}:
          domain: "${domain_name}"
          password: "{{lookup('aws_ssm', '${remote_password}', region='eu-west-2')}}"
          appname: argus
          state: present
      cyrus_sasl_config:
        myapp:
          pwcheck_method: saslauthd
        argus:
          pwcheck_method: auxprop
          auxprop_plugin: sasldb
          mech_list: DIGEST-MD5
      cyrus_sasl_sasldb_group: "nobody"
      cyrus_sasl_sasldb_file_permission: "0640"
    - node_exporter_web_listen_address: '0.0.0.0:9101'
    - postfix_hosts:
        "${postfix_ip_1}": mail1
        "${postfix_ip_2}": mail2
        "${postfix_ip_3}": mail3
    - postfix_fqdn: "{{postfix_hosts[ansible_default_ipv4.address]}}.${fqdn}"
  connection: local
  become: true
  pre_tasks:
    - name: Stop nginx service
      service:
        name: nginx
        state: stopped
    - name: Configure our hostname
      ansible.builtin.command:
        cmd: hostnamectl set-hostname "{{postfix_fqdn}}"
    - name: Create self signed certificate directory
      ansible.builtin.file:
        path: "/certs"
        state: directory
        mode: 0775
        owner: root
        group: root
    - name: Retrieve our SSM parameters and create the files
      ansible.builtin.copy:
        content: "{{lookup('aws_ssm', certificate.param, region='eu-west-2' )}}"
        dest: "{{certificate.path}}"
      loop:
        - { param: ${root_certificate}, path: /etc/pki/ca-trust/source/anchors/cjsm_root_cert.pem }
        - { param: ${client_certificate}, path: "/etc/pki/tls/certs/{{postfix_fqdn}}.crt" }
        - { param: ${client_key}, path: "/etc/pki/tls/private/{{postfix_fqdn}}.pem" }
        - { param: ${self_signed_cert}, path: "/certs/server.crt" }
        - { param: ${self_signed_cert_key}, path: "/certs/server.key" }
        - { param: ${ssm_cloudwatch_config}, path: "/opt/aws/amazon-cloudwatch-agent/etc/amazon-cloudwatch-agent.json" }
      loop_control:
        loop_var: certificate
      register: certificate_files
    - name: Update CA Certificate trust
      ansible.builtin.command:
        cmd: update-ca-trust
      when: certificate_files is changed
  roles:
    - geerlingguy.postfix
    - reallyenglish.cyrus-sasl
    - cloudalchemy.node_exporter
  post_tasks:
    - name: Update postfix main.cf
      ansible.builtin.lineinfile:
        path: /etc/postfix/main.cf
        regexp: "^{{item.search}}"
        line: "{{item.replace}}"
        insertafter: "{{item.insert | default(omit)}}"
      loop:
        - { search: "#myhostname = host.domain.tld", replace: "myhostname = {{postfix_fqdn}}" }
        - { search: "#mydomain = domain.tld", replace: "mydomain = ${domain_name}" }
        - { search: "mydestination = $myhostname, localhost.$mydomain, localhost", replace: "mydestination = $myhostname localhost.$mydomain localhost eu-west-2.compute.internal" }
        - { search: "#mynetworks = 168.100.189.0/28, 127.0.0.0/8", replace: "mynetworks = ${allowed_cidr} ${postfix_cidr} 127.0.0.0/8" }
        - { search: "#relay_domains = $mydestination", replace: "relay_domains = $mydestination" }
        - { search: "#relayhost = $$mydomain", replace: "relayhost = ${cjse_mail_host}:4545", insert: "EOF" } # Relay to CJSE
      register: postfix_config
    - name: Update postfix master.cf to enable tls
      ansible.builtin.lineinfile:
        path: /etc/postfix/master.cf
        regexp: "^#smtps     inet  n       -       n       -       -       smtpd"
        line: "smtps     inet  n       -       n       -       -       smtpd"
      register: postfix_smtps_config
    - name: Lookup some vars
      ansible.builtin.set_fact:
        postfix_relay_user: "{{lookup('aws_ssm', '${relay_user}', region='eu-west-2')}}"
        postfix_relay_password: "{{lookup('aws_ssm', '${relay_password}', region='eu-west-2')}}"
        postfix_remote_user: "{{lookup('aws_ssm', '${remote_user}', region='eu-west-2')}}"
        postfix_remote_password: "{{lookup('aws_ssm', '${remote_password}', region='eu-west-2')}}"
    - name: Create sasl passwd block
      ansible.builtin.blockinfile:
        path: /etc/postfix/sasl_passwd
        create: yes
        block: |
          [${cjse_mail_host}]:4545 {{postfix_relay_user}}:{{postfix_relay_password}}
    - name: Update the password db
      ansible.builtin.command:
        cmd: postmap /etc/postfix/sasl_passwd
    - name: Set our file permissions
      ansible.builtin.file:
        path: "{{file}}"
        owner: root
        group: root
        mode: '0600'
      loop:
        - /etc/postfix/sasl_passwd
        - /etc/postfix/sasl_passwd.db
      loop_control:
        loop_var: file
    - name: Add postfix tls_config
      ansible.builtin.blockinfile:
        path: /etc/postfix/main.cf
        block: |
          tls_random_source = dev:/dev/urandom
          smtp_tls_key_file = /etc/pki/tls/private/{{postfix_fqdn}}.pem
          smtp_tls_cert_file = /etc/pki/tls/certs/{{postfix_fqdn}}.crt
          smtp_tls_CAfile = /etc/pki/ca-trust/source/anchors/cjsm_root_cert.pem
          smtp_tls_security_level = may
          smtp_tls_note_starttls_offer = yes
          smtp_tls_mandatory_protocols=!SSLv2,!SSLv3
          smtp_tls_protocols=!SSLv2,!SSLv3
          smtp_tls_loglevel = 1
          smtp_tls_session_cache_database = btree:/var/lib/postfix/smtp_tls_session_cache
          smtp_sasl_auth_enable = yes
          smtp_sasl_security_options = noanonymous
          smtp_sasl_password_maps = hash:/etc/postfix/sasl_passwd
          smtp_use_tls = yes
          smtpd_sasl_path = smtpd
          smtpd_relay_restrictions = permit_mynetworks, reject
    - name: restart postfix
      service:
        name: postfix.service
        state: restarted
      when: postfix_config is changed or postfix_smtps_config is changed
    - name: Get the postfix_exporter source code
      git:
        repo: https://github.com/kumina/postfix_exporter.git
        dest: /opt/postfix_exporter
    - name: Build the postfix exporter
      command:
        cmd: |
          go build --tags nosystemd
        creates: /opt/postfix_exporter/postfix_exporter
        chdir: /opt/postfix_exporter
      environment:
        HOME: "{{ansible_user_dir}}"
        GOCACHE: "{{ansible_user_dir}}/.cache/go-build"
    - name: Create a systemd unit for the postfix exporter
      ansible.builtin.copy:
        dest: /etc/systemd/system/postfix_exporter.service
        remote_src: yes
        content: |
          [Unit]
          Description=Prometheus Postfix Exporter
          After=network-online.target
          [Service]
          Type=simple
          ExecStart=/opt/postfix_exporter/postfix_exporter \
              --postfix.logfile_path=/var/log/maillog \
              --web.listen-address=0.0.0.0:9155 \
              --web.telemetry-path=/metrics
          SyslogIdentifier=postfix_exporter
          Restart=always
          RestartSec=1
          StartLimitInterval=0
          ProtectHome=yes
          NoNewPrivileges=yes
          ProtectSystem=full
          [Install]
          WantedBy=multi-user.target
    - name: Create our nginx config file
      ansible.builtin.copy:
        dest: /etc/nginx/nginx.conf
        remote_src: yes
        force: yes
        content: |
          user nginx;
          worker_processes auto;
          pid /run/nginx.pid;
          include /etc/nginx/modules-enabled/*.conf;
          events {
            worker_connections 768;
          }
          http {
            sendfile                  on;
            tcp_nopush                on;
            tcp_nodelay               on;
            keepalive_timeout         65;
            types_hash_max_size       2048;
            include                   /etc/nginx/mime.types;
            default_type              application/octet-stream;
            ssl_protocols             TLSv1.2; # Dropping SSLv3, ref: POODLE
            ssl_prefer_server_ciphers on;
            access_log                /var/log/nginx/access.log combined;
            error_log                 /var/log/nginx/error.log;
            gzip                      on;
            include                   /etc/nginx/conf.d/*.conf;
            include                   /etc/nginx/sites-enabled/*;
            server_tokens             off;
            log_format json escape=json '{'
              '"@timestamp": "$time_iso8601", '
              '"message": "$remote_addr - $remote_user [$time_local] \\\"$request\\\" $status $body_bytes_sent \\\"$http_referer\\\" \\\"$http_user_agent\\\"", '
              '"tags": ["nginx_access"], '
              '"realip": ""$remote_addr", '
              '"proxyip": "$http_x_forwarded_for", '
              '"remote_user": "$remote_user", '
              '"contenttype": "$sent_http_content_type", '
              '"bytes": $body_bytes_sent, '
              '"duration": "$request_time", '
              '"status": "$status", '
              '"request": "$request", '
              '"method": "$request_method", '
              '"referrer": "$http_referer", '
              '"useragent": "$http_user_agent"'
            '}';
            server {
              listen                9100   ssl;
              ssl_certificate       /certs/server.crt;
              ssl_certificate_key   /certs/server.key;
              ssl_protocols         TLSv1.2;
              ssl_ciphers           HIGH:!aNULL:!MD5;
              add_header            Strict-Transport-Security "max-age=31536000; includeSubDomains" always;
              access_log            /var/log/nginx/access.log json;
              location / {
                proxy_pass            http://localhost:9101;
              }
            }
            server {
              listen                9154   ssl;
              ssl_certificate       /certs/server.crt;
              ssl_certificate_key   /certs/server.key;
              ssl_protocols         TLSv1.2;
              ssl_ciphers           HIGH:!aNULL:!MD5;
              add_header            Strict-Transport-Security "max-age=31536000; includeSubDomains" always;
              access_log            /var/log/nginx/access.log json;
              location / {
                proxy_pass            http://localhost:9155;
              }
            }
          }
    - name: Ensure the nginx user can write logs
      ansible.posix.acl:
        path: /var/log/nginx/
        entity: nginx
        etype: "{{item}}"
        permissions: rw
        state: present
      loop:
        - user
        - group
    - name: Enable and start the postfix exporter service
      systemd:
        name: postfix_exporter.service
        enabled: true
        state: started
    - blockinfile:
      path: "/etc/logrotate.d/maillog"
        block: |
          /var/log/maillog {
            daily
            rotate 3
            size 10M
            compress
            missingok
          }
        create: true
        loop:
          - maillog
    - name: Start nginx
      ansible.builtin.systemd:
        name: nginx
        state: started
...

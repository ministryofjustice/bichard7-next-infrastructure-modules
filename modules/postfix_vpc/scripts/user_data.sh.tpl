#!/usr/bin/env bash

set -ev

yum update -y
yum upgrade -y
amazon-linux-extras install -y epel ansible2
yum install -y deltarpm s-nail golang nginx python2-botocore python2-boto3 python2-pip
yum install -y https://s3.amazonaws.com/amazoncloudwatch-agent/amazon_linux/amd64/latest/amazon-cloudwatch-agent.rpm || true

pip install boto3 botocore awscli pyOpenSSL
ansible-galaxy install geerlingguy.postfix reallyenglish.cyrus-sasl cloudalchemy.node_exporter hadrienpatte.self_signed_certificate
ansible-galaxy collection install amazon.aws ansible.posix

cat << 'EOF' > /tmp/playbook.yml
${base64decode(ansible_playbook)}
EOF

ansible-playbook /tmp/playbook.yml

/opt/aws/amazon-cloudwatch-agent/bin/amazon-cloudwatch-agent-ctl \
  -a fetch-config \
  -m ec2 \
  -c file:/opt/aws/amazon-cloudwatch-agent/etc/amazon-cloudwatch-agent.json \
  -s

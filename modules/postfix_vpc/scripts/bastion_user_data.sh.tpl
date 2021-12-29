#!/usr/bin/env bash

yum update -y

sed -i 's/#AllowAgentForwarding yes/AllowAgentForwarding yes/g' /etc/ssh/sshd_config
sed -i 's/#Port 22/Port 2222/g' /etc/ssh/sshd_config
systemctl restart sshd

# Get ssh key and write it to .ssh/id_rsa
aws ssm get-parameter \
  --name ${ssm_ssh_key_name} \
  --with-decryption --query "Parameter.Value" \
  --region eu-west-2 \
  --output text > /home/ec2-user/.ssh/id_rsa
chmod 600 /home/ec2-user/.ssh/id_rsa
# Add the ip of the postfix instance to the hosts file
echo "${postfix_ip_1}      postfix1" | sudo tee -a /etc/hosts
echo "${postfix_ip_2}      postfix2" | sudo tee -a /etc/hosts
echo "${postfix_ip_3}      postfix3" | sudo tee -a /etc/hosts

cat <<'EOF'>/home/ec2-user/.ssh/config
Host *
  StrictHostKeyChecking no
  UserKnownHostsFile /dev/null
EOF
chmod 400 /home/ec2-user/.ssh/config

chown ec2-user:ec2-user /home/ec2-user/.ssh/*

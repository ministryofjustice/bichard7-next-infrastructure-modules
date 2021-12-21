client
dev tun
proto udp
remote ${endpoint_url} 443
remote-random-hostname
resolv-retry infinite
nobind
persist-key
persist-tun
remote-cert-tls server
cipher AES-256-GCM
verb 3
<ca>
${ca_cert}
</ca>

reneg-sec 0

cert ${user_cert_path}
key ${user_key_path}

${subnet_routes}

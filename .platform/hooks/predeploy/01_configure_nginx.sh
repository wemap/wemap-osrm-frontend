#!/bin/bash

export HEALTH_CHECK=$(/opt/elasticbeanstalk/bin/get-config environment | jq -r ."HEALTH_CHECK")

if [ "$HEALTH_CHECK" == "null" ] || [ -z "${HEALTH_CHECK}" ]; then
    echo "HEALTH_CHECK has not being defined in terraform settings"
fi


cat << EOT >> /etc/nginx/default.d/healthcheck.conf
location /health {
    return 200 'Ok from nginx';
    add_header Content-Type text/plain;
}
EOT

cat << EOT >> /etc/nginx/default.d/proxy.conf
location / {
    proxy_pass http://127.0.0.1:9966;
    proxy_set_header X-Forwarded-Proto https;
    proxy_set_header Host \$http_host;
}
EOT

service nginx start

FROM nginx:1.21

COPY nginx.conf /etc/nginx/nginx.conf
ADD https://raw.githubusercontent.com/certbot/certbot/master/certbot-nginx/certbot_nginx/_internal/tls_configs/options-ssl-nginx.conf /etc/nginx/options-ssl-nginx.conf

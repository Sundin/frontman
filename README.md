# nginx-reverse-proxy

    docker build -t reverse-proxy .
    docker run -p 8081:80 --add-host host.docker.internal:host-gateway reverse-proxy

Forward to other applications running on localhost with `host.docker.internal` according to [this answer](https://stackoverflow.com/a/24326540/948942).

## Set up on EC2

Launch a new Ubuntu image and set up security groups etc.

Install Docker: https://docs.docker.com/engine/install/ubuntu/

    sudo usermod -a -G docker ubuntu

Install Docker Compose.

Log out and log back in again.

    cd reverse-proxy
    docker-compose up --build -d

## HTTPS
In order to encrypt your services using HTTPS, you need to generate a certificate using LetsEncrypt.

### Pre-requisites

Install Certbot.

Put the contents from [this file](https://raw.githubusercontent.com/certbot/certbot/master/certbot-nginx/certbot_nginx/_internal/tls_configs/options-ssl-nginx.conf) into `/etc/letsencrypt/options-ssl-nginx.conf`.

### Generate certificates

Stop the reverse proxy: `docker-compose stop`

Generate certificate for your domain (replace domain name): `sudo certbot certonly -d ctd.zapto.org`
- Choose option 1: Spin up a temporary webserver (standalone).

Restart the reverse proxy.

The contents from `/etc/letsencrypt/` will be mounted into the Docker container.

You need to repeat this process every 90 days.

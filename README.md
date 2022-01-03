# Frontman

Frontman is an NGINX reverse proxy that redirects traffic to one of many locally running Docker containers based on the base URL of the incoming requests.

This way you can host many services on the same server.

## Preconditions
You need to have a domain name for each service you wish to host. You can obtain a free domain name pointing to your server using for example [DuckDNS](https://www.duckdns.org/) or [no-ip](https://www.noip.com/).

You also need to have Docker, Docker Compose, Make and Python 3 installed.

## Getting started
### Configuration

Create a file called `servers.json`. 

It should contain an array with json objects, each containing the following keys:

- `server_name`: The domain name for requests that should be redirected to a certain port.
- `upstream_port`: The port to redirect traffic to. This is the port you should host your Docker service on.
- `https`: Should be set to `true` or `false`.

Example content:

```
[
    {
        "server_name": "domain1.org",
        "upstream_port": "8080",
        "https": true
    },
    {
        "server_name": "another-domain.org",
        "upstream_port": "8665",
        "https": false
    }
]
```

### Start the reverse proxy

Start frontman with the following command:

    make start

This will generate a `nginx.conf` file for you and start the reverse proxy. 
### Stopping the reverse proxy

    make stop

### Start/Stop on remote host

To start or stop frontman on a remote host using [docker context](https://docs.docker.com/engine/context/working-with-contexts/), you can provide the optional parameter `context`:

    docker context create my-server --docker "host=ssh://user@$my-server-ip"
    make context=my-server start
    make context=my-server stop

## Getting started on AWS EC2

Launch a new Ubuntu image and set up security groups etc.

Assign a elastic (=static) IP to your instance.

Install Docker: https://docs.docker.com/engine/install/ubuntu/

    sudo usermod -a -G docker ubuntu

Install Docker Compose:

    sudo apt install docker-compose

Log out and log back in again.

    cd reverse-proxy
    docker-compose up --build -d

## HTTPS
In order to encrypt your services using HTTPS, you need to generate a certificate using LetsEncrypt.

### Pre-requisites

Install [Certbot](https://certbot.eff.org/lets-encrypt/ubuntufocal-nginx).

Put the contents from [this file](https://raw.githubusercontent.com/certbot/certbot/master/certbot-nginx/certbot_nginx/_internal/tls_configs/options-ssl-nginx.conf) into `/etc/letsencrypt/options-ssl-nginx.conf`.

### Generate certificates

Stop the reverse proxy: `make stop`

Generate certificate for your domain (replace domain name): `sudo certbot certonly -d domain1.org`
- Choose option 1: Spin up a temporary webserver (standalone).

Restart the reverse proxy.

The contents from `/etc/letsencrypt/` will be mounted into the Docker container.

You need to repeat this process every 90 days unless you set up a cronjob to do it for you.

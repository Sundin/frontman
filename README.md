# nginx-reverse-proxy

    docker build -t reverse-proxy .
    docker run -p 8081:80 --add-host host.docker.internal:host-gateway reverse-proxy

Forward to other applications running on localhost with `host.docker.internal` according to [this answer](https://stackoverflow.com/a/24326540/948942).

## Set up on EC2

Launch a new Ubuntu image and set up security groups etc.

Install Docker: https://docs.docker.com/engine/install/ubuntu/

    sudo usermod -a -G docker ubuntu

Log out and log back in again.

    cd reverse-proxy
    docker run -d -p 80:80 --add-host host.docker.internal:host-gateway reverse-proxy

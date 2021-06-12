# nginx-reverse-proxy

    docker build -t reverse-proxy .
    docker run -p 8081:80 --add-host host.docker.internal:host-gateway reverse-proxy

Forward to other applications running on localhost with `host.docker.internal` according to [this answer](https://stackoverflow.com/a/24326540/948942).

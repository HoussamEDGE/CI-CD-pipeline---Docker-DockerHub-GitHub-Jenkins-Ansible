FROM ubuntu:latest

ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
    apt-get install -y apache2 curl && \
    rm -rf /var/lib/apt/lists/*

COPY index.html /var/www/html/index.html

WORKDIR /var/www/html

ENTRYPOINT ["/usr/sbin/apache2ctl"]
CMD ["-D", "FOREGROUND"]

EXPOSE 80

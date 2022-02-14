FROM ubuntu:20.04

MAINTAINER richard.huelsberg@twt.de
LABEL org.opencontainers.image.authors="richard.huelsberg@twt.de"
ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get -qy update
RUN apt-get -qy install ffmpeg
RUN apt-get -qy install nginx nginx-extras libnginx-mod-rtmp curl supervisor bash net-tools vim ngrep

# Node & NPM
#RUN curl -sL https://deb.nodesource.com/setup_16.x | bash -
#RUN apt-get -y install nodejs
#RUN npm install -g npm

# User & Group
RUN groupadd -g 1000 docker
RUN useradd -m -d /data -u 1000 -g docker -s /bin/bash docker

# Copy system configs
COPY rootfs/ /
RUN cat /etc/nginx/ssl/root-ca.crt >> /etc/ssl/cert.pem

WORKDIR /data

ENTRYPOINT ["/usr/bin/supervisord","-c","/etc/supervisor/supervisord.conf"]
SHELL ["/bin/bash", "--login", "-c"]

FROM ubuntu:16.04
MAINTAINER krutpong "krutpong@gmail.com"

ENV DEBIAN_FRONTEND noninteractive
ENV INITRD No
ENV LANG en_US.UTF-8

#add Thailand repo
RUN echo "deb http://th.archive.ubuntu.com/ubuntu/ xenial main restricted" > /etc/apt/sources.list && \
    echo "deb http://th.archive.ubuntu.com/ubuntu/ xenial-updates main restricted" >> /etc/apt/sources.list && \
    echo "deb http://th.archive.ubuntu.com/ubuntu/ xenial universe" >> /etc/apt/sources.list && \
    echo "deb http://th.archive.ubuntu.com/ubuntu/ xenial-updates universe" >> /etc/apt/sources.list && \
    echo "deb http://th.archive.ubuntu.com/ubuntu/ xenial multiverse" >> /etc/apt/sources.list && \
    echo "deb http://th.archive.ubuntu.com/ubuntu/ xenial-updates multiverse" >> /etc/apt/sources.list && \
    echo "deb http://th.archive.ubuntu.com/ubuntu/ xenial-backports main restricted universe multiverse" >> /etc/apt/sources.list && \
    echo "deb http://th.archive.ubuntu.com/ubuntu/ xenial-security main restricted" >> /etc/apt/sources.list && \
    echo "deb http://th.archive.ubuntu.com/ubuntu/ xenial-security universe" >> /etc/apt/sources.list && \
    echo "deb http://th.archive.ubuntu.com/ubuntu/ xenial-security multiverse" >> /etc/apt/sources.list && \
    apt-get update

RUN apt-get install --no-install-recommends -y redis-server && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* && \
    update-rc.d -f redis-server disable
ADD redis.conf /etc/redis/redis.conf

VOLUME ["/var/lib/redis"]

EXPOSE 6379

CMD ["/usr/bin/redis-server", "/etc/redis/redis.conf"]
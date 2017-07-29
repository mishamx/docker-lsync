FROM debian:jessie

RUN apt-get update && \
        DEBIAN_FRONTEND=noninteractive && \
        apt-get install -y supervisor ssh lsyncd rsync \
        && rm -rf /var/lib/apt/lists/*


ADD ./supervisord.conf /etc/supervisor/supervisord.conf
ADD ./lsyncd.conf /etc/lsyncd.conf
ADD ./sshd.conf /etc/ssh/sshd_config

RUN mkdir /data /syncd /var/run/sshd \
   && chmod a+rw /data /syncd

WORKDIR /syncd

ENV SYNC_USERNAME root

USER root

CMD ["/usr/bin/supervisord"]
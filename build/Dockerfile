FROM ghcr.io/void-linux/void-linux:latest-thin-x86_64

COPY setup.sh /setup.sh

RUN xbps-install -Syu \
  && xbps-install docker docker-compose curl git gnupg tini bash openssl libstdc++ icu icu-libs \
  && xbps-remove -ROo \
  && mkdir /root/runner \
  && chmod +x /setup.sh

ENTRYPOINT ["/usr/sbin/tini", "/setup.sh"]

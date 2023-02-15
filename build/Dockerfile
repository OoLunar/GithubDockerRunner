FROM ghcr.io/void-linux/void-linux:latest-thin-x86_64

COPY setup.sh /setup.sh

RUN xbps-install -Syu \
  && xbps-install -y tar docker docker-compose curl git gnupg tini bash openssl libstdc++ icu icu-libs \
  && xbps-remove -ROo \
  && ln -s /etc/{docker,containerd} /var/service \
  && mkdir /root/runner \
  && chmod +x /setup.sh

ENTRYPOINT ["/usr/sbin/tini", "/setup.sh"]

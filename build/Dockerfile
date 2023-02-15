FROM ghcr.io/void-linux/void-linux:latest-full-x86_64

COPY setup.sh /setup.sh

RUN xbps-install -Syu \
  && xbps-install -y bash binutils curl docker docker-compose git gnupg gzip icu icu-libs libstdc++ openssl tar tini wget xbps xz \
  && xbps-remove -ROo \
  && ln -s /etc/{docker,containerd} /var/service \
  && mkdir /root/runner \
  && chmod +x /setup.sh

ENTRYPOINT ["usr/sbin/tini", "/setup.sh"]

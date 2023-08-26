FROM void-linux

COPY setup.sh /setup.sh

RUN xbps-install -Syu \
  && xbps-install -y bash binutils curl clang docker docker-compose docker-buildx git gnupg gzip icu icu-libs libstdc++ openssl tar tini wget xbps xz \
  # https://github.com/void-linux/void-packages/issues/45780
  && xbps-rindex -a /var/cache/xbps/docker-buildx-0.10.3_2.x86_64.xbps && xbps-install -R /var/cache/xbps/ -f docker-buildx-0.10.3_2 && xbps-pkgdb -m hold docker-buildx
  && xbps-remove -ROo \
  && mkdir /root/runner \
  && chmod +x /setup.sh

ENTRYPOINT ["/setup.sh"]

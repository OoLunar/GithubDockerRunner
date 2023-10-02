FROM void-linux

COPY setup.sh /setup.sh
COPY update-dotnet.sh /update-dotnet.sh

RUN xbps-install -Syu \
  && xbps-install -y bash binutils curl clang docker docker-compose docker-buildx jq git gnupg gzip icu icu-libs libstdc++ openssl tar tini wget xbps xz \
  && xbps-remove -ROo \
  && mkdir /root/runner \
  && chmod +x /setup.sh

ENTRYPOINT ["/setup.sh"]

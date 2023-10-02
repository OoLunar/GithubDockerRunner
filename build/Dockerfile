FROM void-linux

COPY setup.sh /setup.sh
COPY update-dotnet.sh /update-dotnet.sh

RUN xbps-install -yu xbps \
  && xbps-install -Syu \
  && xbps-install -y bash binutils clang curl docker docker-buildx docker-compose git gnupg gzip icu icu icu-libs icu-libs jq libstdc++ lttng-ust mit-krb5 mit-krb5-libs openssl tar tini wget xbps xz zlib \
  && xbps-remove -yROo \
  && mkdir /root/runner \
  && chmod +x /setup.sh

ENTRYPOINT ["/setup.sh"]

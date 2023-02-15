FROM alpine:latest

COPY setup.sh /setup.sh

RUN apk upgrade --update-cache --available \
  && apk add docker docker-compose curl git gnupg tini bash openssl libstdc++ icu-libs icu \
  && rm -rf /var/cache/apk/* \
  && mkdir /root/runner \
  && chmod +x /setup.sh

ENTRYPOINT ["/sbin/tini", "/setup.sh"]

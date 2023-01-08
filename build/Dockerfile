FROM mcr.microsoft.com/dotnet/runtime:7.0
ENV DOTNET_CLI_TELEMETRY_OPTOUT=1
ENV DOTNET_NOLOGO=1

COPY setup.sh /setup.sh
RUN chmod +x /setup.sh

ENTRYPOINT ["/bin/bash", "/setup.sh"]

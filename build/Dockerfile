FROM mcr.microsoft.com/dotnet/sdk:latest
ENV DOTNET_CLI_TELEMETRY_OPTOUT=1
ENV DOTNET_NOLOGO=1

COPY setup.sh /setup.sh
RUN apt-get update \
  # Install curl
  && apt-get install -y curl tini git \
  # Clear apt cache
  && rm -rf /var/lib/apt/lists/* \
  # Add a runner user
  && useradd -rM runner \
  # Create the home directory for the runner user
  && mkdir /home/runner \
  # Set permissions on the runner user's home directory
  && chmod -R 700 /home/runner \
  && chown -R runner:runner /home/runner \
  && chmod +x /setup.sh

ENTRYPOINT ["/usr/bin/tini", "/setup.sh"]

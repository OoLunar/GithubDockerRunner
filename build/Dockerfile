FROM mcr.microsoft.com/dotnet/runtime:latest
ENV DOTNET_CLI_TELEMETRY_OPTOUT=1
ENV DOTNET_NOLOGO=1

COPY setup.sh /setup.sh
RUN apt-get update \
  # Install curl
  && apt-get install -y curl \
  # Clear apt cache
  && rm -rf /var/lib/apt/lists/* \
  # Download the Actions Runner package
  && curl -o actions-runner-linux-x64-2.299.1.tar.gz -L https://github.com/actions/runner/releases/download/v2.299.1/actions-runner-linux-x64-2.299.1.tar.gz \
  # Check the SHA256 checksum of the package
  && echo "147c14700c6cb997421b9a239c012197f11ea9854cd901ee88ead6fe73a72c74  ./actions-runner-linux-x64-2.299.1.tar.gz" | sha256sum -c \
  # Extract the package
  && tar xzf ./actions-runner-linux-x64-2.299.1.tar.gz \
  # Remove the package file
  && rm ./actions-runner-linux-x64-2.299.1.tar.gz \
  # Add a runner user
  && useradd -r runner \
  # Set permissions on the runner user's home directory
  && chmod -R 700 . \
  && chown -R runner:runner . \
  && chmod +x /setup.sh

ENTRYPOINT ["/bin/bash", "/setup.sh"]

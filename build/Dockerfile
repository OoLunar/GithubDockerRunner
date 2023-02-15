FROM mcr.microsoft.com/dotnet/sdk:latest

COPY setup.sh /setup.sh
RUN apt-get update \
  # Install curl and Docker deps
  && apt-get install -y curl tini git ca-certificates gnupg lsb-release \
  # Add Docker's official GPG key
  && mkdir -m 0755 -p /etc/apt/keyrings \
  && curl -fsSL https://download.docker.com/linux/debian/gpg | gpg --dearmor -o /etc/apt/keyrings/docker.gpg \
  # Setup the repository
  && echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/debian \
  $(lsb_release -cs) stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null \
  # Install Docker
  && apt-get update \
  && apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin \
  # Clear apt cache
  && rm -rf /var/lib/apt/lists/* \
  && mkdir /root/runner/ \
  && chmod +x /setup.sh

ENTRYPOINT ["/bin/bash", "/setup.sh"]

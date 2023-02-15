#!/bin/bash

### Environment Variables ###
export DOTNET_ROOT=/usr/share/dotnet
export DOTNET_CLI_TELEMETRY_OPTOUT=1
export DOTNET_NOLOGO=1
export PATH="$PATH:/home/lunar/.dotnet/tools"
export RUNNER_ALLOW_RUNASROOT=1

### Functions ###

# Define the setup function
setup() {
    # Determine the CPU architecture
  case "$(uname -m)" in
    x86_64)
      arch=x64
      sha256=15230bb2cf6af00e14ff294f85d2b6f07d6e856d229a1695cbe6290a16109995
      ;;
    armv7l)
      arch=arm
      sha256=8f70778a11ff9540886d97601c18a95a7ed388159af49c2c1c6f88eff4a00794
      ;;
    aarch64)
      arch=arm64
      sha256=885f02222f6e54682020dbb8beedf8226b039ec706ce3f3ea4b4ee626de014c3
      ;;
  esac

  # Download the Actions Runner package
  curl --silent -o github-runner.tar.gz -L "https://github.com/actions/runner/releases/download/v2.302.1/actions-runner-linux-${arch}-2.302.1.tar.gz"

  # Check the SHA256 checksum of the package
  echo "${sha256}  ./github-runner.tar.gz" | sha256sum -c

  # Extract the package
  tar xzf ./github-runner.tar.gz

  # Remove the package file
  rm ./github-runner.tar.gz

  # Run the setup script
  ./config.sh --url "$GITHUB_REPOSITORY" --token "$GITHUB_TOKEN" --unattended --replace
}

### Logic ###

# Change to the /home/runner directory
cd /root/runner

# Check if the .runner file does not exist
if [ ! -f ".runner" ]; then
  # If the file does not exist, run the setup function
  setup
fi

# Run the run.sh script
./run.sh
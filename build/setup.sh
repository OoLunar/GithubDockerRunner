#!/bin/bash

### Environment Variables ###
export DOTNET_ROOT=/usr/share/dotnet
export DOTNET_CLI_TELEMETRY_OPTOUT=1
export DOTNET_NOLOGO=1
export PATH="$PATH:/root/.dotnet/tools"
export RUNNER_ALLOW_RUNASROOT=1
export RUNNER_MANUALLY_TRAP_SIG=1

### Functions ###

# Define the setup function
setup() {
  # Determine the CPU architecture
  case "$(uname -m)" in
    x86_64)
      arch=x64
      sha256=2974243bab2a282349ac833475d241d5273605d3628f0685bd07fb5530f9bb1a
      ;;
    armv7l)
      arch=arm
      sha256=97d3c06c8e2b33fcab4c5afd0237e596c52cc4450465382bcbd49a4b23b978a9
      ;;
    aarch64)
      arch=arm64
      sha256=b172da68eef96d552534294e4fb0a3ff524e945fc5d955666bab24eccc6ed149
      ;;
  esac

  # Download the Actions Runner package
  curl --silent -o github-runner.tar.gz -L "https://github.com/actions/runner/releases/download/v2.309.0/actions-runner-linux-${arch}-2.309.0.tar.gz"

  # Check the SHA256 checksum of the package
  echo "${sha256}  github-runner.tar.gz" | sha256sum -c > /dev/null

  if [ $? -ne 0 ]; then
    echo "The SHA256 checksum of the package does not match!"
    exit 1
  fi

  # Extract the package
  tar xzf ./github-runner.tar.gz

  # Remove the package file
  rm ./github-runner.tar.gz

  # Install .NET
  bash /update-dotnet.sh

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
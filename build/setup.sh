#!/bin/bash

### Environment Variables ###
export DOTNET_ROOT=/usr/share/dotnet
export DOTNET_CLI_TELEMETRY_OPTOUT=1
export DOTNET_NOLOGO=1
export PATH="$PATH:/root/.dotnet/tools"
export RUNNER_ALLOW_RUNASROOT=1

### Functions ###

# Define the setup function
setup() {
  # Determine the CPU architecture
  case "$(uname -m)" in
    x86_64)
      arch=x64
      sha256=3d357d4da3449a3b2c644dee1cc245436c09b6e5ece3e26a05bb3025010ea14d
      ;;
    armv7l)
      arch=arm
      sha256=cb9992e3853d95116ff73f9353b45d5134e315eb3c03b13fb6adb8651346411d
      ;;
    aarch64)
      arch=arm64
      sha256=cac05dc325a3fd86e0253bd5bda1831e1d550805c47d6e3cc6d248570ceb3b74
      ;;
  esac

  # Download the Actions Runner package
  curl --silent -o github-runner.tar.gz -L "https://github.com/actions/runner/releases/download/v2.302.1/actions-runner-linux-${arch}-2.302.1.tar.gz"

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
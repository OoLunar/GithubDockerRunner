#!/bin/bash

### Functions ###

# Define the setup function
setup() {
    # Determine the CPU architecture
  case "$(uname -m)" in
    x86_64)
      arch=x64
      sha256=ed5bf2799c1ef7b2dd607df66e6b676dff8c44fb359c6fedc9ebf7db53339f0c
      ;;
    armv7l)
      arch=arm
      sha256=e3b35299483009fedfa55e2b27c371e14a113f40da32df886d846591f14b7873
      ;;
    aarch64)
      arch=arm64
      sha256=804693a178db3265eb43e09c3b4e67ef28f6d64133778b38d66dcffd2f21057d
      ;;
  esac

  # Download the Actions Runner package
  curl -o github-runner.tar.gz -L "https://github.com/actions/runner/releases/download/v2.300.2/actions-runner-linux-${arch}-2.300.2.tar.gz"

  # Check the SHA256 checksum of the package
  echo "${sha256}  ./github-runner.tar.gz" | sha256sum -c

  # Extract the package
  tar xzf ./github-runner.tar.gz

  # Remove the package file
  rm ./github-runner.tar.gz

  # Run the setup script
  su runner -c "./config.sh --url $GITHUB_REPOSITORY --token $GITHUB_TOKEN --unattended --replace"
}

### Logic ###

# Change to the /home/runner directory
cd /home/runner

# Check if the .runner file does not exist
if [ ! -f ".runner" ]; then
  # If the file does not exist, run the setup function
  setup
fi

# Load env vars and run the run.sh script
su runner -c "/bin/bash -c 'source /home/runner/.env && ./run.sh'"
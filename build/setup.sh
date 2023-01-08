#!/bin/bash

### Functions ###

# Define the setup function
setup() {
  # Download the Actions Runner package
  curl -o actions-runner-linux-x64-2.299.1.tar.gz -L https://github.com/actions/runner/releases/download/v2.299.1/actions-runner-linux-x64-2.299.1.tar.gz

  # Check the SHA256 checksum of the package
  echo "147c14700c6cb997421b9a239c012197f11ea9854cd901ee88ead6fe73a72c74  ./actions-runner-linux-x64-2.299.1.tar.gz" | sha256sum -c

  # Extract the package
  tar xzf ./actions-runner-linux-x64-2.299.1.tar.gz

  # Remove the package file
  rm ./actions-runner-linux-x64-2.299.1.tar.gz

  # Run the setup script
  su runner -c "./config.sh --url $GITHUB_REPOSITORY --token $GITHUB_TOKEN --unattended --replace --disableupdate"
}

### Logic ###

# Set a signal handler for the SIGINT signal (Ctrl+C)
trap "cat /home/runner/.pid | kill" INT

# Change to the /home/runner directory
cd /home/runner

# Check if the .runner file does not exist
if [ ! -f ".runner" ]; then
  # If the file does not exist, run the setup function
  setup
fi

# Run the run.sh script
su runner -c "./run.sh &; echo $! > /home/runner/.pid"

# Idle
wait $(cat /home/runner/.pid)
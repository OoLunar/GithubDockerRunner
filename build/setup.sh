#!/bin/bash

# Set a signal handler for the SIGINT signal (Ctrl+C)
trap "cat /home/runner/.pid | kill; exit" INT

# Change to the /home/runner directory
cd /home/runner

# Check if the .runner file does not exist
if [ ! -f ".runner" ]; then
  # Run the setup script
  su runner -c "./config.sh --url $GITHUB_REPOSITORY --token $GITHUB_TOKEN --unattended --replace --disableupdate"
fi

# Run the run.sh script
su runner -c "./run.sh; echo $! > /home/runner/.pid"

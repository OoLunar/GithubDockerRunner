#!/bin/bash
set -ex

TEMP_DIR="$(mktemp -d)"
DOTNET_VERSION="$(wget -q -O - https://raw.githubusercontent.com/dotnet/core/main/release-notes/releases-index.json | jq -r '.["releases-index"] | sort_by(.["channel-version"]) | reverse | .[0]["latest-sdk"]')"

# Download dotnet-install
wget -q -O "$TEMP_DIR/dotnet-install.sh" http://dotnet-install.sh/

# Define the installation directory
INSTALL_DIR="/usr/share/dotnet/"
if [ ! -d "$INSTALL_DIR/$DOTNET_VERSION" ]; then
    # Install the specified .NET SDK version
    rm -rf "$INSTALL_DIR"
    bash "$TEMP_DIR/dotnet-install.sh" --channel LTS --install-dir "$INSTALL_DIR"
    bash "$TEMP_DIR/dotnet-install.sh" --channel STS --install-dir "$INSTALL_DIR"
    bash "$TEMP_DIR/dotnet-install.sh" --version "$DOTNET_VERSION" --install-dir "$INSTALL_DIR"
fi

rm -rf "$TEMP_DIR"
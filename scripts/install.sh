#!/bin/bash

# Ensure everything is executable
chmod +x install-packages.sh
chmod +x create-symlinks.sh
chmod +x install-nvidia.sh

# Run all scripts
./install-packages.sh
./install-nvidia.sh
./create-symlinks.sh
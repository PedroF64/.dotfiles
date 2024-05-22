#!/bin/bash

# Function to install NVIDIA drivers
install_nvidia() {
    echo "Installing NVIDIA drivers..."
    sudo pacman -S --noconfirm nvidia-dkms nvidia-utils nvidia-settings nvidia-prime lib32-nvidia-utils 
    echo "NVIDIA drivers installed successfully!"
}

# Function to prompt user for NVIDIA driver installation
prompt_nvidia_installation() {
    read -p "Do you want to install NVIDIA drivers? (yes/no): " response
    case "$response" in
        [Yy][Ee][Ss]|[Yy])
            install_nvidia
            ;;
        [Nn][Oo]|[Nn])
            echo "Skipping NVIDIA driver installation."
            ;;
        *)
            echo "Invalid response. Please answer yes or no."
            prompt_nvidia_installation
            ;;
    esac
}

# Main script execution
prompt_nvidia_installation
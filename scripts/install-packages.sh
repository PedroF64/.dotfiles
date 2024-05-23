#!/bin/bash

# Load package arrays from the general-packages.sh file
source general-packages.sh

# Function to install packages using pacman
install_pacman_packages() {
    echo "Installing pacman packages..."
    for package in "${packagesPacman[@]}"; do
        sudo pacman -S --noconfirm --needed "$package"
    done
}

# Function to install packages using paru
install_paru_packages() {
    echo "Installing paru packages..."
    for package in "${packagesParu[@]}"; do
        paru -S --noconfirm --needed "$package"
    done
}

# Function to install paru if it's not installed
install_paru() {
    if ! command -v paru &> /dev/null; then
        echo "paru is not installed. Installing paru..."
        sudo pacman -S --needed base-devel
        git clone https://aur.archlinux.org/paru.git
        cd paru
        makepkg -si
        cd ..
        rm -rf paru
    fi
}

# Main script execution
install_paru

# Install pacman and paru packages
install_pacman_packages
install_paru_packages

echo "All packages installed successfully!"

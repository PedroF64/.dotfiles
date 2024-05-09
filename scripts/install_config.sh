#!/bin/bash

# Define the dotfile repository directory
DOTFILES_DIR="$HOME/.dotfiles"

# Path to the global links.prop file
GLOBAL_LINKS_FILE="$DOTFILES_DIR/scripts/links.prop"

# Function to create symlinks
create_symlinks() {
    # Check if global links.prop file exists
    if [ ! -f "$GLOBAL_LINKS_FILE" ]; then
        echo "Error: Global links.prop file not found."
        exit 1
    fi
    
    # Read each line in the global links.prop file
    while IFS='=' read -r src dest || [[ -n "$src" ]]; do
        echo "Reading line: $src=$dest"
        # Skip comments and empty lines
        if [[ $src == \#* ]] || [[ -z $src ]]; then
            continue
        fi

        # Create directory for destination file if it doesn't exist
        dest_dir=$(dirname "$dest")
        mkdir -p "$HOME/$dest_dir"
        
        # Create symlink
        echo "Creating symlink for $src to $HOME/$dest"
        ln -sf "$DOTFILES_DIR/$src" "$HOME/$dest"
        if [ $? -ne 0 ]; then
            echo "Error: Failed to create symlink for $src to $HOME/$dest"
        else
            echo "Symlink created successfully"
        fi
    done < "$GLOBAL_LINKS_FILE"

}

# Main script
create_symlinks
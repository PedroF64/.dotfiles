#!/bin/bash

# Define the source directory where your dotfiles are located
DOTFILES_DIR="$HOME/.dotfiles"

# Define the list of files and directories to symlink
declare -A FILES_TO_SYMLINK=(
    ["$DOTFILES_DIR/btop"]="$HOME/.config/btop"
    ["$DOTFILES_DIR/fastfetch"]="$HOME/.config/fastfetch"
    ["$DOTFILES_DIR/fish"]="$HOME/.config/fish"
    ["$DOTFILES_DIR/gtk/gtk-3.0"]="$HOME/.config/gtk-3.0"
    ["$DOTFILES_DIR/gtk/gtk-4.0"]="$HOME/.config/gtk-4.0"
    ["$DOTFILES_DIR/gtk/xsettingsd"]="$HOME/.config/xsettingsd"
    ["$DOTFILES_DIR/gtk/.gtkrc-2.0"]="$HOME/.gtkrc-2.0"
    ["$DOTFILES_DIR/gtk/.Xresources"]="$HOME/.Xresources"
    ["$DOTFILES_DIR/hypr"]="$HOME/.config/hypr"
    ["$DOTFILES_DIR/kitty"]="$HOME/.config/kitty"
    ["$DOTFILES_DIR/mako"]="$HOME/.config/mako"
    ["$DOTFILES_DIR/wofi"]="$HOME/.config/wofi"
    ["$DOTFILES_DIR/starship/starship.toml"]="$HOME/.config/starship.toml"
    ["$DOTFILES_DIR/waybar"]="$HOME/.config/waybar"
    ["$DOTFILES_DIR/wlogout"]="$HOME/.config/wlogout"
)

# Function to create symlinks
create_symlinks() {
    for source in "${!FILES_TO_SYMLINK[@]}"; do
        target=${FILES_TO_SYMLINK[$source]}
        # Rename existing file or directory if it exists
        if [ -e "$target" ]; then
            echo "Renaming existing file or directory: $target to $target.bak"
            mv "$target" "$target.bak"
        fi
        # Create the symlink
        echo "Creating symlink: $source -> $target"
        ln -s "$source" "$target"
    done
}

# Execute the function to create symlinks
create_symlinks

echo "All symlinks created successfully!"

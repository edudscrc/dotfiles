#!/bin/bash

DOTFILES_DIR=~/dotfiles
CONFIG_DIR=~/.config

declare -A DOTFILES
DOTFILES=(
    ["hypr"]="$CONFIG_DIR/hypr"
    ["waybar"]="$CONFIG_DIR/waybar"
    ["rofi"]="$CONFIG_DIR/rofi"
    ["kitty"]="$CONFIG_DIR/kitty"
    ["dunst"]="$CONFIG_DIR/dunst"
    ["zathura"]="$CONFIG_DIR/zathura"
)

declare -A HOME_FILES
HOME_FILES=(
    [".bashrc"]="$HOME/.bashrc"
)

echo "Setting up dotfiles..."

for folder in "${!DOTFILES[@]}"; do
    TARGET="${DOTFILES[$folder]}"
    SOURCE="$DOTFILES_DIR/$folder"

    rm -rf "$TARGET"

    ln -sfn "$SOURCE" "$TARGET"
    echo "Linked $SOURCE -> $TARGET"
done

for file in "${!HOME_FILES[@]}"; do
    SOURCE="$DOTFILES_DIR/$file"

    rm "$HOME/$file"
    ln -sf "$SOURCE" "$HOME"
    echo "Copied $SOURCE -> $HOME"
done

hyprctl reload

echo "Dotfiles setup complete!"

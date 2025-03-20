#!/bin/bash


echo "\n<<< Starting Setup >>>\n"

export ZDOTDIR="${HOME}"
export XDG_CONFIG_HOME="${HOME}/.config"
mkdir -p "$XDG_CONFIG_HOME"


# Create symlinks
ln -sf "$PWD/.zshrc" "$XDG_CONFIG_HOME"/.zshrc
ln -sf "$PWD/.zshrc" "$XDG_CONFIG_HOME"/.zprofile


echo "Setup completed!"
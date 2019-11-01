#!/usr/bin/env bash

set -ex

cp "$HOME/Library/Application Support/Code/User/settings.json" ~/dev/dotfiles/vscode
cp "$HOME/Library/Application Support/Code/User/keybindings.json" ~/dev/dotfiles/vscode

code --list-extensions >~/dev/dotfiles/vscode/extensions

echo "Successfully sync'ed VS Code settings"

cp "$HOME/.rstudio-desktop/monitored/user-settings/user-settings" ~/dev/dotfiles/r

echo "Successfully sync'ed RStudio settings"

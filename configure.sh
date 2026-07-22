#!/usr/bin/env bash

for file in {.path,.bash_prompt,.exports,.aliases,.extra,.bash_profile}; do
  source_file="$HOME/dev/dotfiles/$file"
  target_file="$HOME/$file"

  # The order is important for only one case, .extra must come after .bash_prompt since it needs
  # to modify the prompt command.
  if [ ! -r "$source_file" ]; then
    echo "user does not have read permissions for source file: $source_file, skipping..."
    continue
  fi

  if [ -e "$target_file" ]; then
    echo "$target_file already exists, skipping..."
    continue
  fi

  echo "$target_file"

  if ! ln -s "$source_file" "$target_file"; then
    echo "failed to create symbolic from $source_file to $target_file, exiting..."
    exit 1
  fi
done

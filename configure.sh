#!/usr/bin/env bash

for file in {.path,.bash_prompt,.exports,.aliases,.functions,.extra,.vim,.vimrc,.bash_profile,envrc}; do
  source_file="$HOME/dev/dotfiles/$file"
  target_file="$HOME/$file"

  case "$source_file" in
  # We name envrc instead of .envrc in this repository so that direnv doesn't think it's a real
  # .envrc file. We need to add the leading dot when we create the symbolic link though.
  envrc)
    target_file="$HOME/.$file"
    ;;
  esac

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

  if ! ln -s "$source_file" "$target_file"; then
    echo "failed to create symbolic from $target_file to $source_file"
    exit 1
  fi
done

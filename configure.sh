#!/usr/bin/env bash

function get_target() {
  local file="$1"

  case "$file" in
  # We name envrc instead of .envrc in this repository so that direnv doesn't think it's a real
  # .envrc file. We need to add the leading dot when we create the symbolic link though.
  envrc)
    echo "$HOME/.$file"
    ;;
  gpg-agent.conf)
    # Ensure the gnupg directory exists in case we run the configure script before we install gpg.
    mkdir -p "$HOME/.gnupg"
    echo "$HOME/.gnupg/$file"
    ;;
  *)
    echo "$HOME/$file"
    ;;
  esac
}

for file in {.path,.bash_prompt,.exports,.aliases,.functions,.extra,.vim,.vimrc,.bash_profile,envrc,gpg-agent.conf}; do
  source_file="$HOME/dev/dotfiles/$file"
  target_file=$(get_target $file)

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

#!/usr/bin/env bash

for file in .{path,bash_prompt,exports,aliases,functions,extra,envrc,vim,vimrc,bash_profile}; do
  source_file="$HOME/dev/dotfiles/$file"
  target_file="$HOME/$file"

  # Ensure that we have read permissions for the file and the target file does
  # not already exist. Order is important for one case, .extra must come after
  # .bash_prompt since it needs to modify the prompt command.
  #
  # TODO: Exit with helpful error if file exists already.
  [ -r "$source_file" ] && [ ! -e "$target_file" ] && ln -s "$source_file" "$target_file"
done

#!/usr/bin/env bash

for file in .{path,bash_prompt,exports,aliases,functions,extra,vim,vimrc}; do
    source_file="$HOME/dev/dotfiles/$file"
    target_file="$HOME/$file"
    
    # Ensure that we have read permissions for the file.
    [ -r "$source_file" ] && ln -s $source_file $target_file ;
done;


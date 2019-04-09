#!/usr/bin/env bash

# The order in which files are sourced is important for the `PROMPT_COMMAND` environment
# variable as `.bash_profile` sets `PROMPT_COMMAND` and other tools, such as autojump,
# direnv, and hstr, need to append to it. The setup for these tools is in `.extra` which
# comes after `.bash_profile`.
for file in ~/.{aliases,bash_prompt,exports,extra,functions,path}; do
  # shellcheck source=/dev/null
  [ -r "$file" ] && [ -f "$file" ] && source "$file"
done
unset file

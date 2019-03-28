#!/usr/bin/env bash

for file in ~/.{aliases,bash_prompt,exports,extra,functions,path}; do
    # The following comment configures shellcheck to not try to find $file in the line below.
    # shellcheck source=/dev/null
    [ -r "$file" ] && [ -f "$file" ] && source "$file";
done;
unset file;
[ -s "/Users/loaner/.scm_breeze/scm_breeze.sh" ] && source "/Users/loaner/.scm_breeze/scm_breeze.sh"

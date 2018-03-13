# dotfiles

This is my collection of dotfiles. It is organized into the following bash files:
* `.aliases` - Bash aliases.
* `.bash_prompt` - Bash prompt.
* `.exports` - Exported variables.
* `.extra` - Miscellaneous commands to run.
* `.path` - Additional directories added to my PATH.

And the following Vim files and directories:

* `.vim` - Vim plugin directory.
* `.vimrc` - Vim configuration.

The script `configure` assumes the above files are in the directory `$HOME/dev/dotfile`
and will create a soft link to them from one's home directory (`$HOME`).

To configure one's `.bash_profile` then only the following needs to be added:

```
for file in ~/.{path,bash_prompt,exports,aliases,functions,extra}; do
    [ -r "$file" ] && [ -f "$file" ] && source "$file";
done;
unset file;
```

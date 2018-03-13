# dotfiles

This is my collection of dotfiles. It is organized into the following bash files:
* `.aliases` - Bash aliases.
* `.bash_prompt` - Bash prompt.
* `.exports` - Exported variables.
* `.extra` - Miscellaneous commands to run.
* `.functions` - Bash functions.
* `.path` - Additional directories added to my PATH.

And the following Vim files and directories:

* `.vim` - Vim plugin directory.
* `.vimrc` - Vim configuration.

The script `configure.sh` assumes the above files are in the directory `$HOME/dev/dotfile`
and will create a soft link to them from one's home directory (`$HOME`).

To configure one's `.bash_profile` then only the following needs to be added:

```
for file in ~/.{aliases,bash_prompt,exports,extra,functions,path}; do
    [ -r "$file" ] && [ -f "$file" ] && source "$file";
done;
unset file;
```

## Details

When configuring one's environment one can edit either `.bash_profile` or `.bashrc`.
The difference between the two is that `.bash_profile` is executed for login shells
whereas `.bashrc` is executed for interactive non-login shells. So when you login
to a machine, either via a console at the machine or remotely via ssh, then
`.bash_profile` is executed. If you open a new terminal window or start a new bash
shell with `/bin/bash` then `.bashrc` is run.

Mac’s Terminal (and iTerm by default though this can be configured) is an exception
to the above rules and runs a login shell by default for each new terminal window,
calling `.bash_profile` instead of `.bashrc.`

#### Resources
* [.bash_profile vs .bashrc](http://www.joshstaiger.org/archives/2005/07/bash_profile_vs.html)
* [Difference between ~/.profile and ~/.bash_profile](https://unix.stackexchange.com/questions/45684/difference-between-profile-and-bash-profile)
* [Bash: about .bashrc, .bash_profile, .profile, /etc/profile, etc/bash.bashrc and others](http://stefaanlippens.net/bashrc_and_others/)

## TODO

- [ ] Make dotfiles OS-agnostic.
    - Currently, this README recommends configuring one's `.bash_profile`. This works on Mac
    terminals which create a new login shell for each new terminal. On most Linux systems,
    however, it seems the preference is to open a login shell only when the user actually
    logins. This means that when a new terminal is opened `.bashrc` is searched but not
    `.bash_profile`. Consequently, I should look into make the dotfile OS-agnostic by setting
    my dotfiles in `.bashrc` and sourcing `.bashrc` from `.bash_profile`. Will need to test
    on a Linux box to test.
- [ ] Add a script to install tools.
    - I should add a script which installs all of the tools I use, for example Go, Rust, etc.

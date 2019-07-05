# dotfiles

This repo contains the configuration and applicatin settings I use on my laptop. It started off
with just my dotfiles but has expanded to include the different applications I use (managed via
Homebrew) and their respective settings and configurations as well. The steps required to configure
a new machine are listed in the `install.md` file.

## Shell

The dotfiles I use to configure my shell are organized into the following bash files:

* `.aliases` - Bash aliases.
* `.bash_profile` - Bash profile.
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

### bash_profile vs. bashrc

When configuring one's environment one can edit either `.bash_profile` or `.bashrc`.
The difference between the two is that `.bash_profile` is executed for login shells
whereas `.bashrc` is executed for interactive non-login shells. So when you login
to a machine, either via a console at the machine or remotely via ssh, then
`.bash_profile` is executed. If you open a new terminal window or start a new bash
shell with `/bin/bash` then `.bashrc` is run.

Mac’s Terminal (and iTerm by default though this can be configured) is an exception
to the above rules and runs a login shell by default for each new terminal window,
calling `.bash_profile` instead of `.bashrc.`

Currently, this README recommends configuring one's `.bash_profile`. This works on Mac
terminals which create a new login shell for each new terminal. On most Linux systems,
however, it seems the preference is to open a login shell only when the user actually
logins. This means that when a new terminal is opened `.bashrc` is sourced but not
`.bash_profile`. I intend to look into make the dotfile OS-agnostic by setting my dotfiles
in `.bashrc` and sourcing `.bashrc` from `.bash_profile`. Will need to test on a Linux box
to test.

#### Resources

* [.bash_profile vs .bashrc]
* [Difference between ~/.profile and ~/.bash_profile]
* [Bash: about .bashrc, .bash_profile, .profile, /etc/profile, etc/bash.bashrc and others]

## Homebrew

Included in this directory is also a `Brewfile` listing Homebrew packages that should be
installed. To install the packages run `brew bundle` in the root of this directory. The blog
post [Restore, Clone or Backup your Homebrew Setup] provides a great overview of how to create
a Brewfile and restore from one. I also found the command `brew leaves` to be helpful since,
as [this StackExchange answer] notes, it will display all top-level packages. Another answer
to the same question also notes that `brew list` and `brew cask list` can be used to display
all Homebrew packages and casks respectively.

### brew vs. cask

The Stack question [What is the difference between brew install XXX and brew cask install XXX]
details the difference between `brew` and `brew cask`. `brew` is the core command of the Homebrew
project and is primarliy used to install command line software. Cask is an extension to Homebrew
which allows for the management of graphical applications.

## iTerm2

After following the steps in `install.md` iTerm2 will be configured to save its profiles to
the `iterm` directory. Any time a change is made to iTerm2 the changes should be synced to
the directory by hitting the "Save Current Settings to Folder" button on the General page.
See the Stack question [How to export iTerm2 Profiles] for more information on saving iTerm2
profiles.

I like to set a few extra keybindings for iTerm to make it feel more like other Mac applications.
The StackOverflow post [iTerm 2: How to set keyboard shortcuts to jump to beginning/end of line?]
covers a lot of the most common keybindings.

## Visual Studio Code

I like to save my VS Code settings, keybindings, and extensions. The settings and keybindings
are stored in JSON files so we can sync them by copying the files into the `vscode` directory:

```bash
cp "$HOME/Library/Application Support/Code/User/settings.json" ~/dev/dotfiles/vscode
cp "$HOME/Library/Application Support/Code/User/keybindings.json" ~/dev/dotfiles/vscode
```

VS Code also provides a helpful command for getting the list of extensions which are currently
installed:

```bash
code --list-extensions > ~/dev/dotfiles/vscode/extensions
```

Conversely, to install the list of extensions in a file we can run:

```bash
cat ~/dev/dotfiles/vscode/extensions | xargs -I {} code --install-extension {}
```

The script `sync.sh` in this directory will run the aforementioned commands to sync the current
VS Code configuration to the `vscode` directory.

[.bash_profile vs .bashrc]: http://www.joshstaiger.org/archives/2005/07/bash_profile_vs.html
[Difference between ~/.profile and ~/.bash_profile]:
https://unix.stackexchange.com/questions/45684/difference-between-profile-and-bash-profile
[Bash: about .bashrc, .bash_profile, .profile, /etc/profile, etc/bash.bashrc and others]:
http://stefaanlippens.net/bashrc_and_others/
[Restore, Clone or Backup your Homebrew Setup]: https://tomlankhorst.nl/brew-bundle-restore-backup/
[this StackExchange answer]:
https://apple.stackexchange.com/questions/101090/list-of-all-packages-installed-using-homebrew
[What is the difference between brew install XXX and brew cask install XXX]:
https://stackoverflow.com/questions/46403937/what-is-the-difference-between-brew-install-xxx-and-brew-cask-install-xxx
[How to export iTerm2 Profiles]:
https://stackoverflow.com/questions/22943676/how-to-export-iterm2-profiles
[iTerm 2: How to set keyboard shortcuts to jump to beginning/end of line?]:
https://stackoverflow.com/questions/6205157/iterm-2-how-to-set-keyboard-shortcuts-to-jump-to-beginning-end-of-line

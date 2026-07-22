# Laptop Recovery

## 1. Clone Dotfiles from Github

My first step in configuring a new machine is to grab my dotfiles repo from Github since it
contains all the scripts and configuration I need to setup a machine. My dotfiles repo
is public so I don't need to retrieve my Github private key to access it (I do this in a later
step). The only requirement for this step is that `git` and `bash` are installed on the machine (a
pretty safe assumption):

```bash
mkdir -p ~/dev && cd ~/dev

# Since I haven't installed the SSH key I used for Github yet I need to clone the repo via HTTPS.
# This will be changed to SSH automatically later when we update our git configuration.
# Alternatively, if one has already logged into Github then one can just use the SSH download from
# the start.
git clone https://github.com/jeromefroe/dotfiles.git

cd dotfiles
./configure.sh
```

It's worth noting that in some setups, most notably my work environment, the developer tooling
will often make changes to `.bash_profile`. In these cases, it's better to not link `.bash_profile`
but rather to add the contents of `.bash_profile` in this repo to the end of the file. This
isn't a big problem in practice because the repo is set up such that `.bash_profile` should
be pretty simple and need only source the other files which are stored in this repo.

## 2. Install Homebrew

Install Homebrew with the following command:

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"

# Follow the directions given to add Homebrew to your PATH. Note that
# until we make Bash the default shell Homebrew may show instructions
# for zsh. The following command is also run, indirectly, via our
# `bash_profile` file but it is only run when `brew` has been installed
# already.
eval "$(/opt/homebrew/bin/brew shellenv)"
```

## 3. Install Homebrew packages

The next step is to use Homebrew to install our packages. Note that Xcode can take a long time
so I'd recommend commenting out on the first run so that subsequent steps aren't stuck waiting
for it to install.

```bash
cd ~/dev/dotfiles
brew bundle
```

## 4. Configure some stuff

1. Bash

   By default, Mac ships with an old version of `bash`. The `Brewfile` will install a newer
   version (which supports command completion), but there are two additional steps we need
   to complete to make the newer version of `bash` the default shell. First, we need to add
   the path to the newer version of `bash` which Homebrew installs to the whitelist of shells
   that can be used as login shells in `/etc/shells`. Once that step is complete we can actually
   go ahead and make the newer `bash` the default for login shells. The steps come from the
   blog post [Upgrading Bash on macOS] which dives into more detail on them.

   ```bash
   echo '/opt/homebrew/bin/bash' | sudo tee -a /etc/shells
   chsh -s /opt/homebrew/bin/bash
   ```

1. Alfred
   - Alfred requires a license to enable its Powerpack features. I store mine in LastPass so we
     can retrieve it from via the CLI:

     ```bash
     lpass show Alfred --json | jq '.[].note' -r | jq '.powerpack_licenses.v5' -r | pbcopy
     ```

   - Once the license has been copied to our clipboard we can add it to Alfred by navigating to
     Alfred Preferences > Powerpack.
   - I also had to explicitly enable Clipboard history in Alfred by navigating to
     "Preferences > Features > Clipboard" and selecting "Keep Plain Text". The Alfred Help page
     [Why isn't my Clipboard History working?] contains further details.

1) VS Code

   Run the following command to install extensions:

   ```bash
   cat ~/dev/dotfiles/vscode/extensions | xargs -I {} code --install-extension {}
   ```

   Run the following command to sync user settings:

   ```bash
   cp ~/dev/dotfiles/vscode/settings.json \
     "$HOME/Library/Application Support/Code/User/settings.json"
   ```

   Run the following command to sync keybindings:

   ```bash
   cp ~/dev/dotfiles/vscode/keybindings.json \
     "$HOME/Library/Application Support/Code/User/keybindings.json"
   ```

1) Git

   Run the following commands to set global Git configuration options. The first two commands
   set the default email and name for commits respectively, the third command ensures that when
   one runs `git push`, `git` will assume that the user is pushing the current branch. The fourth
   command ensures that git will always attempt to use SSH for authenticating to Github (the step
   to install my personal SSH key is below). Without this step you may run into errors cloning
   private repositories since I tend to just use my SSH key for authentication ([this is often a
   problem for Go dependencies for example]). Note that I expect subdirectories to use `direnv`
   to [set the `GIT_AUTHOR_EMAIL` and `GIT_COMMITTER_EMAIL` environment variables] to override the
   author and committer emails as necessary. The blog post [Multiple Personalities in Git] contains
   further details on how one can use `direnv` to manage Git accounts.

   ```bash
   git config --global user.email "jeromefroelich@hotmail.com"
   git config --global user.name "Jerome Froelich"
   git config --global push.default current
   git config --global --add url."git@github.com:".insteadOf "https://github.com/"
   ```

1) Window Tiling Shortcuts

   Go to System Settings > Keyboard > Keyboard Shortcuts > Windows. I like to use
   Control + Option + Up/Down/Left/Right to move a window to the corresponding location on the
   screen and Control + Option + Enter to fill the screen (these were the shortcuts I got used
   to from the Magnet app before Mac supported window tiling shortcuts).

## 5. Get SSH and GPG Key From LastPass

I store my personal SSH and GPG keys in LastPass, so to download them I use the LastPass CLI tool.
The first step is to login, the following command will take you through the two-factor
authentication workflow:

```bash
lpass login "jeromefroelich@hotmail.com"
```

Once we've logged into LastPass we can install the keys locally, starting first with the SSH key:

```bash
# Steps to install my SSH key.
mkdir ~/.ssh
lpass show 'Personal SSH Key' --json | jq -r '.[].note' | jq -r '.public' | base64 -D > ~/.ssh/personal.pub
lpass show 'Personal SSH Key' --json | jq -r '.[].note' | jq -r '.private' | base64 -D > ~/.ssh/personal

# Finally, we need to set the correct permissions the files and can add our private key to
# SSH agent.
chmod 400 ~/.ssh/personal
chmod 400 ~/.ssh/personal.pub
ssh-add ~/.ssh/personal

# Update the URL of the dotfiles repo so we can use our SSH key to authenticate to Github.
# This should actually be unnecessary because it's taken care of when we update the git
# configuration.
# cd ~/dev/dotfiles/
# git remote set-url origin git@github.com:jeromefroe/dotfiles.git

# Steps to install my GPG key.
cd ~
lpass show 'Personal GPG Key' --json | jq -r '.[].note' | jq -r '.private' | base64 -D > personal.asc
gpg --import personal.asc
rm personal.asc
```

## 6. Install non-Homebrew tools

There are some tools I use that do not have Homebrew packages (or have a package that I'm unable
to use in the case of `kube-ps1`). Fortunately, the number is small and still managable. To install
them, run the following:

```bash
# Install scm_breeze
git clone git@github.com:scmbreeze/scm_breeze.git ~/.scm_breeze
source "$HOME/.scm_breeze/lib/scm_breeze.sh"
_create_or_patch_scmbrc

# Install kube-ps1
git clone git@github.com:jonmosco/kube-ps1.git ~/.kube-ps1
```

[upgrading bash on macos]: https://itnext.io/upgrading-bash-on-macos-7138bd1066ba
[this is often a problem for go dependencies for example]: http://albertech.blogspot.com/2016/11/fix-git-error-could-not-read-username.html
[why isn't my clipboard history working?]: https://www.alfredapp.com/help/troubleshooting/clipboard-history/
[set the `git_author_email` and `git_committer_email` environment variables]: https://git-scm.com/docs/git-config#Documentation/git-config.txt-committeremail
[multiple personalities in git]: https://collectiveidea.com/blog/archives/2016/04/04/multiple-personalities-in-git

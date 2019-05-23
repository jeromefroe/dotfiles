# Laptop Recovery

## 0. Update System UX Settings

* If scroll feels unnatural, update it by navigating to System Preferences > Trackpad > "Scroll
Direction: Natural".
* If applications icons continue to stay in the dock after quitting navigate to System
Preferences > Dock > "Show recent applications in Dock".
* To sync your iCloud account to your Mac navigate to System Preferences > iCloud and add
your Apple account. Note that the passcode for your phone is the one you enter on the lock
screen.

## 1. Setup Chrome

The first step was to install Chrome and add my user. Navigate to People > Add Person. All one
needs to sign in is password + Google Authenticator code.

## 2. Install LastPass

Once your account is added to Chrome it will install one’s Chrome extensions, this includes
LastPass for me. To sign into LastPass I just need my password. The next step is to install the
Binary component of LastPass by navigating to Go to your: LastPass Icon > More Options > "About
LastPass". It should say: "Binary Component: true". If it says "false: Install the binary version
by clicking the button 'Enable Native Messaging'" or 'Enable Binary', next to it to download and
run the installer.

TODO: Find a better solution than this.

## 3. Get SSH Key from LastPass

Make a directory for private keys:

```bash
mkdir ~/.ssh
```

Navigate to Auth > SSH Keys and Credentials and save `github.key` and `github.pub` to ~/.ssh (you
may need to right-click on them to save them). I saved `github.key` as just `github`.

Once the keys have been put into the ssh directory, ensure they have the proper permission and
then add them to ssh-agent:

```bash
chmod 400 ~/.ssh/github
chmod 400 ~/.ssh/github.pub
ssh-add ~/.ssh/github
```

See LastPass for the passphrase.

## 4. Clone Dotfiles from Github

```bash
mkdir -p ~/dev && cd ~/dev
git clone git@github.com:jeromefroe/dotfiles.git
cd dotfiles
./configure.sh
```

It's worth noting that in some setups, most notably my work environment, the developer tooling
will often make changes to `.bash_profile`. In these cases, it's better to not link `.bash_profile`
but rather to add the contents of `.bash_profile` in this repo to the end of the file. This
isn't a big problem in practice because the repo is set up such that `.bash_profile` should
be pretty simple and need only source the other files which are stored in this repo.

## 5. Install Homebrew

Install Homebrew with the following command:

```bash
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
```

## 6. Sign into Mac App Store

Before we use Homebrew to install our packages we need to sign into the Mac App Store
as we use Homebrew to manage our Mac applications as well (for example, Alfred and Magnet).

## 7. Install Homebrew package

The next step is to use Homebrew to install our packages. Note that Xcode can take a long time
so I'd recommend commenting out on the first run so that subsequent steps aren't stuck waiting
for it to install.

```bash
cd ~/dev/dotfiles
brew bundle
```

## 8. Install non-Homebrew tools

There are some tools I use that do not have Homebrew packages. Fortunately, the number is small
and still managable. To install them, run the following:

```bash
# Install scm_breeze
git clone git://github.com/scmbreeze/scm_breeze.git ~/.scm_breeze

# Install mssh
curl https://gist.githubusercontent.com/dgromov/350c6d80f65ba2bedf63ac168bcd788f/raw/d5f139a1cfeeb7a747aa5d09942ec31fdb79a757/mssh.py \
 -o ~/dev/mssh.py
chmod +x ~/dev/mssh.py

# Install Delve
go get -u github.com/go-delve/delve/cmd/dl
```

## 9. Sign into applications

  1. Dropbox
  2. Alfred
     * First add the Powerpack license by navigating to Alfred Preferences > Powerpack. My license
      is stored in LastPass.
     * Enable syncing of preferences with Dropbox by navigating to Advanced > Set preferences
       folder > `Dropbox/Sync/Alfred`.
     * Enable storing Clipboard History by navigating to Features > Clipboard and set "Keep Plain
       Text" to 3 months.
  3. Spotify
  4. Evernote
  5. Slack
  6. Messages

## 10. Configure some stuff

  1. Bash

     By default, Mac ships with an old version of `bash`. The `Brewfile` will install a newer
     version (which supports command completion), but there are two additional steps we need
     to complete to make the newer version of `bash` the default shell. First, we need to add
     the path to the newer version of `bash` which Homebrew installs to the whitelist of shells
     that can be used as login shells in `/etc/shells`. Once that step is complete we can actually
     go ahead and make the newer `bash` the default for login shells. The steps come from the
     blog post [Upgrading Bash on macOS] which dives into more detail on them.

     ```bash
     echo '/usr/local/bin/bash' | sudo tee -a /etc/shells
     sudo chsh -s /usr/local/bin/bash
     ```

  2. Dash

     Download Go, Rust, and Python 3 docs.

  3. Magnet

     Open application and follow instructions to authorize.

  4. iTerm2

     To load our stored preferences, navigate to General > "Preferences and check Load Preferences
     from a Custom folder or URL" and then select `~/dev/dotfiles/iterm`.

  5. VS Code

     Run the following command to install extensions:

         `cat ~/dev/dotfiles/vscode/extensions | xargs -I {} code --install-extension {}`

     Run the following command to sync user settings:

         `cp ~/dev/dotfiles/vscode/settings.json "$HOME/Library/Application Support/Code/User/settings.json"`

     Run the following command to sync keybindings:

         `cp ~/dev/dotfiles/vscode/keybindings.json "$HOME/Library/Application Support/Code/User/keybindings.json"`

  6. Rust

     Run the following command to initialize `rustup`: `rustup-init`. During initialization I
     chose not to modify my `.bash_profile` to add Cargo's `bin` directory to my path since I've
     aready done that.

  7. Google Cloud SDK

     Run the following command initialize the Google Cloud SDK: `gcloud init`.

  8. AWS CLI

     The first step to configuring the AWS CLI is to download my credentials from LastPass. They
     are stored in Auth > SSH Keys and Credentials as aws_credentials.txt. We need to move them
     to `~/.aws/credentials` and then we can configure the client:

     ```bash
     mkdir -p ~/.aws
     mv aws_credentials.txt ~/.aws/credentials
     aws configure
     ```

  9. Git

      Run the following commands to set global Git configuration options. The first two commands
      set the default email and name for commits respectively, the third command ensures that when
      one runs `git push`, `git` will assume that the user is pushing the current branch, and the
      fourth command configures the [`git-secrets`] plugin to check all commit for AWS credentials
      which may have been added accidentally.

      ```bash
      git config --global user.email "email@example.com"
      git config --global user.name "John Doe"
      git config --global push.default current
      git secrets --register-aws --global
      ```

  10. Docker

      As discussed in [this Stack answer], one needs to open the Docker application after it is
      installed by Homebrew since its needs sudo privileges. In addition, Homebrew doesn't
      automatically include Docker's bash completion script so we need to grab it manually:

     ```bash
     curl -o /usr/local/etc/bash_completion.d/docker https://raw.githubusercontent.com/docker/cli/master/contrib/completion/bash/docker
     ```

[Upgrading Bash on macOS]: https://itnext.io/upgrading-bash-on-macos-7138bd1066ba
[this Stack answer]: https://stackoverflow.com/questions/40523307/brew-install-docker-does-not-include-docker-engine#answer-43365425
[`git-secrets`]: https://github.com/awslabs/git-secrets

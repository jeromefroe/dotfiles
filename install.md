# Laptop Recovery

## 0. Update Scroll Settings

If scroll feels unnatural, update it by navigating to System Preferences > Trackpad > "Scroll
Direction: Natural".

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

## 5. Install Homebrew

Install Homebrew with the following command:

```bash
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
```

## 6 Sign into Mac App Store

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

# Install Delve
go get -u github.com/go-delve/delve/cmd/dl
```

## 9. Sign into applications

  1. Dropbox
  2. Alfred
     - First add the Powerpack license by navigating to Alfred Preferences > Powerpack. My license
      is stored in LastPass.
     - Enable syncing of preferences with Dropbox by navigating to Advanced > Set preferences
       folder > `Dropbox/Sync/Alfred`.
     - Enable storing Clipboard History by navigating to Features > Clipboard and set "Keep Plain
       Text" to 3 months.
  3. Spotify
  4. Evernote
  5. Slack
  6. Messages

## 10. Configure some stuff

  1. Dash

     Download Go, Rust, and Python 3 docs.

  2. Magnet

     Open application and follow instructions to authorize.

  3. iTerm2

     To load our stored preferences, navigate to General > "Preferences and check Load Preferences
     from a Custom folder or URL" and then select `~/dev/dotfiles/iterm`.

  4. VS Code

     Run the following command to install extensions:

         `cat ~/dev/dotfiles/vscode/extensions | xargs -I {} code --install-extension {}`

     Run the following command to sync user settings:

         `cp ~/dev/dotfiles/vscode/settings.json "$HOME/Library/Application Support/Code/User/settings.json"`

     Run the following command to sync keybindings:

         `cp ~/dev/dotfiles/vscode/keybindings.json "$HOME/Library/Application Support/Code/User/keybindings.json"`

  5. Rust

     Run the following command to initialize `rustup`: `rustup-init`. During initialization I
     chose not to modify my `.bash_profile` to add Cargo's `bin` directory to my path since I've
     aready done that.

  6. Google Cloud SDK

     Run the following command initialize the Google Cloud SDK: `gcloud init`.

  7. AWS CLI

     The first step to configuring the AWS CLI is to download my credentials from LastPass. They
     are stored in Auth > SSH Keys and Credentials as aws_credentials.txt. We need to move them
     to `~/.aws/credentials` and then we can configure the client:

     ```bash
     mkdir -p ~/.aws
     mv aws_credentials.txt ~/.aws/credentials
     aws configure
     ```

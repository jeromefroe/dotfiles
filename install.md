# Laptop Recovery

## 0. Update System UX Settings

- Make sure [FileVault is enabled] to ensure your hard drive is encrypted. Apple encourages
  enabling it during setup but its worth double-checking by navigating to System Preferences >
  Security & Privacy > FileVault. With FileVault, you'll need your login password in order to
  decrypt data on your hard drive or, in the event that you forgot your password, the recovery code
  you are given during setup. The recovery code should be securely backed up since if you lose both
  your password and your recovery code you will be unable to decrypt your hard drive.
- If scroll feels unnatural, update it by navigating to System Preferences > Trackpad > "Scroll
  Direction: Natural".
- If applications icons continue to stay in the dock after quitting navigate to System
  Preferences > Dock > "Show recent applications in Dock".
- To sync your iCloud account to your Mac navigate to System Preferences > iCloud and add
  your Apple account. Note that the passcode for your phone is the one you enter on the lock
  screen.
- To ensure the Dock stays hidden except when you scroll over it go to System Preferences >
  Dock > "Automatically hide and show the Dock".

## 1. Clone Dotfiles from Github

My first step in configuring a new machine is to grab my dotfiles repo from Github since it
contains all the scripts and configuration I need to setup a machine. My dotfiles repo
is public so I don't need to retrieve my Github private key to access it (I do this in a later
step). The only requirement for this step is that `git` and `bash` are installed on the machine (a
pretty safe assumption):

```bash
mkdir -p ~/dev && cd ~/dev

# Since I haven't installed the SSH key I used for Github yet I need to clone the repo via HTTPS.
# We'll change this later once we have downloaded our SSH key. Alternatively, if one has already
# logged into Github then one can just use the SSH download from the start.
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
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
```

## 3. Sign into Mac App Store

Before we use Homebrew to install our packages we need to sign into the Mac App Store
as we use Homebrew to manage our Mac applications as well (for example, Alfred and Magnet).

## 4. Install Homebrew packages

The next step is to use Homebrew to install our packages. Note that Xcode can take a long time
so I'd recommend commenting out on the first run so that subsequent steps aren't stuck waiting
for it to install.

```bash
cd ~/dev/dotfiles
/opt/homebrew/bin/brew bundle
```

## 5. Install non-Homebrew tools

There are some tools I use that do not have Homebrew packages. Fortunately, the number is small
and still managable. To install them, run the following:

```bash
# Install scm_breeze
git clone git://github.com/scmbreeze/scm_breeze.git ~/.scm_breeze
source "$HOME/.scm_breeze/lib/scm_breeze.sh"
_create_or_patch_scmbrc
```

## 6. Sign into applications

Some of the applications that we installed require us to login in to them first. Fortunately,
LastPass makes the process pretty easy. One can use the LastPass CLI to get the username and
password for each application or, alternatively, one can use the LastPass Chrome extension after
signing into Chrome and LastPass respectively. If using the CLI to get one's credentials, one
need only sign into LastPass first and then use the following commands to get the username and
credentials for a given application:

```bash
lpass login "jeromefroelich@hotmail.com"

lpass show --name <APPLICATION> --clip --username
lpass show --name <APPLICATION> --clip --password
```

For each of the applications below I've added the name of the LastPass entity that the credentials
are stored in.

1. Firefox (LastPass: 'Mozilla')
1. Dropbox (LastPass: 'Dropbox')
1. Spotify (LastPass: 'Spotify')
1. Messages (LastPass: 'Apple')

## 7. Configure some stuff

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

1. direnv

   The `configure.sh` script installs a `.envrc` in my home directory which contains some sane
   defaults for various tools that I expect may be overridden in subdirectories as necessary. `direnv`
   requires that the user first allows a `.envrc` in a given directory so we do that below:

   ```bash
   cd ~
   direnv allow .
   ```

1. iTerm2

   To load our stored preferences, navigate to General > "Preferences and check Load Preferences
   from a Custom folder or URL" and then select `~/dev/dotfiles/iterm`.

1. Alfred

   - Alfred requires a license to enable its Powerpack features. I store mine in LastPass so we
     can retrieve it from via the CLI:

     ```bash
     lpass show Alfred --json | jq '.[].note' -r | jq '.powerpack_licenses.v4' -r | pbcopy
     ```

   - Once the license has been copied to our clipboard we can add it to Alfred by navigating to
     Alfred Preferences > Powerpack.
   - The last step required to finish configuring Alfred is to set the folder where our Alfred
     preferences are stored. I sync my Alfred preferences to `~/dev/dotfiles/alfred`, so we want
     to navigate to Advanced > Set preferences and set the folder to the aforementioned directory.
     Alfred also supports syncing to Dropbox, but that seems more applicable to people who use
     multiple laptops regularly so keeping my Alfred preferences in my dotfiles repo has been
     sufficient for me so far. It's worth noting also that [Alfred doesn't sync all settings],
     they reason that some settings, such as one's Clipboard history, is specific to each
     machine.
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

1) Magnet

   Open application and follow instructions to authorize.

1) Rust

   Run the following command to initialize `rustup`: `rustup-init`. During initialization I
   chose not to modify my `.bash_profile` to add Cargo's `bin` directory to my path since I've
   aready done that.

1) Google Cloud SDK

   Run the following command initialize the Google Cloud SDK: `gcloud init`.

1) AWS CLI

   The first step to configuring the AWS CLI is to download my credentials from LastPass into
   the location expected by the AWS CLI. Once that's done we can run the `configure` command to
   configure the CLI:

   ```bash
   mkdir -p ~/.aws
   lpass show 'AWS - Personal' --json | jq -r '.[].note' > ~/.aws/credentials
   aws configure
   ```

1) Spotify

   I have a program to take backups of my Spotify playlists and it uses a client which has been
   registed with Spotify to get access tokens to my account. The program assumes the credentials
   for the Spotify client are stored at `~/.creds/spotify.json` so we need to grab them LastPass
   and store them in that file.

   ```bash
   mkdir -p ~/.creds
   lpass show Spotify --json | jq '.[].note' -r | jq . -r > ~/.creds/spotify.json
   ```

1) Git

   Run the following commands to set global Git configuration options. The first two commands
   set the default email and name for commits respectively, the third command ensures that when
   one runs `git push`, `git` will assume that the user is pushing the current branch. The fourth
   command ensures that git will always attempt to use SSH for authenticating to Github (the step
   to install my personal SSH key is below). Without this step you may run into errors cloning
   private repositories since I tend to just use my SSH key for authentication ([this is often a
   problem for Go dependencies for example]). The last command configures the [`git-secrets`]
   plugin to check all commit for AWS credentials which may have been added accidentally. Note that
   I expect subdirectories to use `direnv` to [set the `GIT_AUTHOR_EMAIL` and `GIT_COMMITTER_EMAIL`
   environment variables] to override the the author and committer emails as necessary. The blog
   post [Multiple Personalities in Git] contains further details on how one can use `direnv` to
   manage Git accounts.

   ```bash
   git config --global user.email "jeromefroelich@hotmail.com"
   git config --global user.name "Jerome Froelich"
   git config --global push.default current
   git config --global --add url."git@github.com:".insteadOf "https://github.com/"
   git secrets --register-aws --global
   ```

1) Docker

   As discussed in [this Stack answer], one needs to open the Docker application after it is
   installed by Homebrew since its needs sudo privileges. In addition, Homebrew doesn't
   automatically include Docker's bash completion script so we need to grab it manually:

   ```bash
   curl -o /usr/local/etc/bash_completion.d/docker \
     https://raw.githubusercontent.com/docker/cli/master/contrib/completion/bash/docker
   ```

1) Dash

   Download Go and Rust docs.

## 9. Get SSH and GPG Key From LastPass

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
cd ~/dev/dotfiles/
git remote set-url origin git@github.com:jeromefroe/dotfiles.git

# Steps to install my GPG key.
cd ~
lpass show 'Personal GPG Key' --json | jq -r '.[].note' | jq -r '.private' | base64 -D > personal.asc
gpg --import personal.asc
rm personal.asc
```

## 10. Clean up old laptop

Some applications that I use are specific to a given device. For these applications it makes sense
to revoke my old device once my new machine is setup:

- Dropbox
- iCloud
- Keybase

[filevault is enabled]: https://macpaw.com/how-to/use-filevault-disk-encryption
[upgrading bash on macos]: https://itnext.io/upgrading-bash-on-macos-7138bd1066ba
[alfred doesn't sync all settings]: https://www.alfredapp.com/help/advanced/sync/
[this stack answer]: https://stackoverflow.com/questions/40523307/brew-install-docker-does-not-include-docker-engine#answer-43365425
[this is often a problem for go dependencies for example]: http://albertech.blogspot.com/2016/11/fix-git-error-could-not-read-username.html
[`git-secrets`]: https://github.com/awslabs/git-secrets
[why isn't my clipboard history working?]: https://www.alfredapp.com/help/troubleshooting/clipboard-history/
[set the `git_author_email` and `git_committer_email` environment variables]: https://git-scm.com/docs/git-config#Documentation/git-config.txt-committeremail
[multiple personalities in git]: https://collectiveidea.com/blog/archives/2016/04/04/multiple-personalities-in-git

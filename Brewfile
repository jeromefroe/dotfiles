# Taps
# ----
tap "caskroom/versions"
tap "homebrew/bundle"
tap "homebrew/cask"
tap "homebrew/core"
tap "go-swagger/go-swagger"
tap "golangci/tap"

# Go Tools
# --------
brew "go"
brew "dep"
brew "glide"
brew "go-swagger"
brew "golangci-lint"
brew "golang-migrate"
brew "goreleaser"

# Rust Tools
# ----------
brew "rustup"

# Javascript Tools
# ----------------
brew "node"
brew "typescript"
brew "yarn"

# Bash Tools
# ----------
brew "bash"
brew "bash-completion@2"
brew "shellcheck"
brew "shfmt"

# Kubernetes Tools
# ----------------
brew "kubernetes-cli"
brew "kustomize"
brew "krew"
brew "kubectx"
brew "jsonnet"
brew "kube-ps1", args: ["HEAD"] # Install from HEAD for now to pick up PR #84 to fix PROMPT_COMMAND.

# Terraform Tools
# ---------------
brew "tfenv"
brew "tflint"

# Protobuf Tools
# --------------
brew "protobuf"
brew "protoc-gen-go"
brew "prototool"

# Cloud Provider Tools
# --------------------
brew "awscli"
brew "azure-cli"
cask "google-cloud-sdk"

# Databases
# ---------
brew "mysql"
brew "postgresql"

# Data Analysis Tools
# -------------------
brew "r"
cask "rstudio"

# Miscellaneous Tools
# -------------------
brew "autojump"
brew "aws-iam-authenticator"
brew "buildifier"
brew "direnv"
brew "fzf"
brew "git-secrets"
brew "gnupg"
brew "graphviz"
brew "grpcurl"
brew "h3"
brew "hh"
brew "htop"
brew "jq"
brew "lastpass-cli"
brew "llvm"
brew "ngrep"
brew "packer"
brew "prettier"
brew "tig"
brew "tree"
brew "watch"
brew "youtube-dl"
cask "aws-vault"

# Enhanced alternatives to common CLI tools written in Rust.
#
# The blog post https://www.wezm.net/technical/2019/10/useful-command-line-tools/ contains a handy
# list of useful CLI tools, many of which are "enhanced" versions of old tools written in Rust.
brew "bat"     # `cat`
brew "fd"      # `find`
brew "ripgrep" # `grep`
brew "rga"     # `ripgrep` with support for non-text files (e.g. PDF and Word documents).

# Dependencies for ripgrep-all.
brew "pandoc"
brew "poppler"
brew "tesseract"
brew "ffmpeg"

# Applications
# ------------
cask "1password"
cask "1password-cli"
cask "alfred"
cask "dash"
cask "docker"
cask "dropbox"
cask "firefox"
cask "flux"
cask "iterm2"
cask "monodraw"
cask "sequel-pro"
cask "slack"
cask "spotify"
cask "visual-studio-code"
cask "vlc"

# App Store
# ---------

# mas is the Mac App Store CLI, it is required to install the Mac Store
# applications listed below.
brew "mas"

mas "Amphetamine", id: 937984704
mas "Magnet", id: 441258766

# Xcode takes a long time to install, when bringing up a new machine I would
# recommend commenting the line below to skip installing initially so one could
# set up the more important tools first.
mas "Xcode", id: 497799835

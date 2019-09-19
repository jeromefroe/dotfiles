# Taps
# ----
tap "caskroom/versions"
tap "homebrew/bundle"
tap "homebrew/cask"
tap "homebrew/core"

# Go Tools
# --------
brew "go"
brew "dep"
brew "glide"

# Rust Tools
# ----------
brew "rustup"

# Javascript Tools
# ----------
brew "node"
brew "typescript"

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
brew "kubectx"
brew "jsonnet"
brew "kube-ps1", args: ["HEAD"] # Install from HEAD for now to pick up PR #84 to fix PROMPT_COMMAND.

# Terraform Tools
# ----------------
brew "tfenv"
brew "tflint"

# Cloud Provider Tools
# ----------------
brew "awscli"
brew "azure-cli"
cask "google-cloud-sdk"

# Miscellaneous Tools
# --------
brew "autojump"
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
brew "packer"
brew "protobuf"
brew "tig"
brew "tree"
brew "youtube-dl"

# Dependencies for ripgrep-all, once a package exists for ripgrep-all itself I need to add
# it here as well (it"s being tracked in https://github.com/phiresky/ripgrep-all/issues/9).
brew "ripgrep"
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
cask "iterm2"
cask "keybase"
cask "monodraw"
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

# -------- homebrew --------
# gotta be first. it adds everything homebrew installed to path, but subsequent tools need to
# prepend their paths before homebrew's. for example, homebrew will add node, and we need asdf
# to add it's shim stuffs on top.
eval "$(/opt/homebrew/bin/brew shellenv)"

# -------- android --------
# ref: https://reactnative.dev/docs/environment-setup?platform=android
export ANDROID_HOME=$HOME/Library/Android/sdk
export PATH=$PATH:$ANDROID_HOME/build-tools/34.0.0
export PATH=$PATH:$ANDROID_HOME/cmdline-tools/latest/bin
export PATH=$PATH:$ANDROID_HOME/emulator
export PATH=$PATH:$ANDROID_HOME/platform-tools

# -------- asdf ---------
source $HOME/.asdf/asdf.sh
export ASDF_NODEJS_LEGACY_FILE_DYNAMIC_STRATEGY=latest_installed

# -------- chruby --------
# source /opt/homebrew/opt/chruby/share/chruby/chruby.sh
# source /opt/homebrew/opt/chruby/share/chruby/auto.sh
# chruby 3.2.2 # set a default to avoid system ruby
# cd && cd ~-  # go home && come back to make chruby init itself form any .ruby-version files

# -------- java (asdf-java) --------
# ref: https://github.com/halcyon/asdf-java
if [ -n "$ZSH_VERSION" ]; then
  source ~/.asdf/plugins/java/set-java-home.zsh
fi

# -------- python --------
# eval "$(pyenv init --path)"
# eval "$(pyenv init - --no-rehash)"
# eval "$(pyenv virtualenv-init -)"
# export PATH="$PATH:/Users/graykemmey/.local/bin"
# export PIP_REQUIRE_VIRTUALENV=true

# -------- rbenv --------
eval "$(rbenv init - zsh)"

# -------- rust --------
source $HOME/.cargo/env

# -------- yarn --------
export PATH="$PATH:$(yarn global bin)"

# -------- pco --------
eval "$($HOME/Code/pco/bin/pco init -)"
source $HOME/pco-box/env.sh
export PCO_BOX_LEAVE_DOCKER_RUNNING=true

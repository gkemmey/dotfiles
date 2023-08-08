# -------- homebrew --------
# gotta be first. it adds everything homebrew installed to path, but subsequent tools need to
# prepend their paths before homebrew's. for example, homebrew will add node, and we need asdf
# to add it's shim stuffs on top.
eval "$(/opt/homebrew/bin/brew shellenv)"

# -------- asdf ---------
source /opt/homebrew/opt/asdf/libexec/asdf.sh

# -------- chruby --------
source /opt/homebrew/opt/chruby/share/chruby/chruby.sh
source /opt/homebrew/opt/chruby/share/chruby/auto.sh
chruby 3.2.2 # set a default to avoid system ruby
cd && cd ~-  # go home && come back to make chruby init itself form any .ruby-version files

# -------- java (asdf-java) --------
# ref: https://github.com/halcyon/asdf-java
if [ -n "$ZSH_VERSION" ]; then
  source ~/.asdf/plugins/java/set-java-home.zsh
fi

# -------- python --------
eval "$(pyenv init --path)"
eval "$(pyenv init - --no-rehash)"
eval "$(pyenv virtualenv-init -)"
export PATH="$PATH:/Users/graykemmey/.local/bin"
export PIP_REQUIRE_VIRTUALENV=true

# -------- rust --------
source ~/.cargo/env

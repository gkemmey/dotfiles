# -------- homebrew --------
# gotta be first. it adds everything homebrew installed to path, but subsequent tools need to
# prepend their paths before homebrew's. for example, homebrew will add node, and we need asdf
# to add it's shim stuffs on top.
eval "$(/opt/homebrew/bin/brew shellenv)"

# -------- asdf ---------
source /opt/homebrew/opt/asdf/asdf.sh

# -------- chruby --------
source /opt/homebrew/opt/chruby/share/chruby/chruby.sh
source /opt/homebrew/opt/chruby/share/chruby/auto.sh
chruby 3.0.0 # set a default to avoid system ruby
cd && cd ~-  # go home && come back to make chruby init itself form any .ruby-version files

# -------- python --------
eval "$(pyenv init - --no-rehash)"
eval "$(pyenv virtualenv-init -)"
export PATH="$PATH:/Users/graykemmey/.local/bin"
export PIP_REQUIRE_VIRTUALENV=true

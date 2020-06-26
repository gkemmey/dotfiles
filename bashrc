# -------- CHRUBY --------
source /usr/local/opt/chruby/share/chruby/chruby.sh
source /usr/local/opt/chruby/share/chruby/auto.sh
chruby ruby-2.7.0

# go home && go back && verify ruby-version auto selected
alias chset='cd && cd ~- && chruby'

# -------- BASH COMPLETION --------
if [ -f /usr/local/etc/bash_completion ]; then
  source /usr/local/etc/bash_completion
fi

# -------- GIT --------
if [ -f /usr/local/Cellar/git/2.4.3/etc/bash_completion.d/git-completion.bash ]; then
  source /usr/local/Cellar/git/2.4.3/etc/bash_completion.d/git-completion.bash
fi

# -------- DOCKER --------
if [ -f /Applications/Docker.app/Contents/Resources/etc/docker.bash-completion ]; then
  source /Applications/Docker.app/Contents/Resources/etc/docker.bash-completion
fi

if [ -f /Applications/Docker.app/Contents/Resources/etc/docker-machine.bash-completion ]; then
  source /Applications/Docker.app/Contents/Resources/etc/docker-machine.bash-completion
fi

if [ -f /Applications/Docker.app/Contents/Resources/etc/docker-compose.bash-completion ]; then
  source /Applications/Docker.app/Contents/Resources/etc/docker-compose.bash-completion
fi

# -------- KUBECTL --------
if [ -f /usr/local/etc/bash_completion.d/kubectl ]; then
  source /usr/local/etc/bash_completion.d/kubectl
fi

# -------- HELM (KUBERNETES) --------
if [ -f /usr/local/etc/bash_completion.d/helm ]; then
  source /usr/local/etc/bash_completion.d/helm
fi

# -------- NPM --------
if [ -f /usr/local/etc/bash_completion.d/npm ]; then
  source /usr/local/etc/bash_completion.d/npm
fi

# -------- YARN --------
# i installed this with homebrew, and now i gotta add where it installs global packages to my path
#
if hash yarn 2>/dev/null; then # check if there's a yarn command to run
  export PATH="$PATH:$(yarn global bin)"

  # not sure what the fuck is going on, `yarn global bin` doesn't seem to output the path anymore
  # so i'll also just add it manualy.
  export PATH="$PATH:/Users/gray/.config/yarn/global/node_modules/.bin"
fi

# -------- DB2 --------
# this shit was added by DB2 install script, against my will: fuckers
# if [ -f /Users/gray/sqllib/db2profile ]; then
#     . /Users/gray/sqllib/db2profile
# fi

# -------- OPENVPN --------
# i've never seen this before, but it homebrew linked openvpn in /usr/local/sbin, i'm guessing
# because the executable lives under an sbin dir in the package. seems like an easy enough fix
# to just add the sbin dir to my path
#
export PATH="$PATH:/usr/local/sbin"

# -------- ASDF --------
source ~/.asdf/asdf.sh
# source ~/.asdf/completions/asdf.bash

# -------- GO --------
export PATH="$PATH:$(go env GOPATH)/bin:$(go env GOROOT)/bin"

# -------- secret bash profile (not committed to dotfiles repo) --------
if [ -f ~/.bash_secret_profile ]; then
  source ~/.bash_secret_profile
fi

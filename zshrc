# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="/Users/graykemmey/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="dracula"
DRACULA_ARROW_ICON=">>"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to automatically update without prompting.
# DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# Caution: this setting can cause issues with multiline prompts (zsh 5.7.1 and newer seem to work)
# See https://github.com/ohmyzsh/ohmyzsh/issues/5765
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git zsh-syntax-highlighting zsh-autosuggestions ruby bundler rails)

# load homebrew installed zsh completions
# ref: https://docs.brew.sh/Shell-Completion#configuring-completions-in-zsh
#
# without this flag, you'll get an error about unsafe folder permissions for autocomplete stuff.
# that seems unnecessary. opting to just disable the check as opposed to alter homebrew's file
# permissions.
# ref: https://github.com/ohmyzsh/ohmyzsh/issues/6835#issuecomment-390216875
# ref: https://github.com/ohmyzsh/ohmyzsh/issues/6835#issuecomment-390187157
ZSH_DISABLE_COMPFIX=true
if type brew &>/dev/null; then
  FPATH=/opt/homebrew/share/zsh/site-functions:$FPATH
fi

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# -------- ☝️ oh-my-zsh setups --------

# -------- apple --------
alias arm="env /usr/bin/arch -arm64 /bin/zsh --login"
alias intel="env /usr/bin/arch -x86_64 /bin/zsh --login"

# -------- asdf ---------
source /opt/homebrew/opt/asdf/asdf.sh

# -------- chruby --------
source /opt/homebrew/opt/chruby/share/chruby/chruby.sh
source /opt/homebrew/opt/chruby/share/chruby/auto.sh
chruby ruby-3.0.0

alias chset='cd && cd ~- && chruby' # go home && go back && verify ruby-version auto selected

# -------- gifs --------
# alias pr_gif="ffmpeg -i ~/Desktop/screen_cap.mov -vf scale=600:-1 -r 10 -f image2pipe -vcodec ppm - | convert -delay 5 -layers Optimize -loop 0 - ~/Desktop/screen_cap.gif"
function pr_gif {
  ffmpeg -i $1 -vf scale=600:-1 -r 10 -f image2pipe -vcodec ppm - | convert -delay 5 -layers Optimize -loop 0 - ~/Desktop/screen_cap.gif
}

# ref: https://engineering.giphy.com/how-to-make-gifs-with-ffmpeg/
function giphy_gif {
  ffmpeg -i ~/Desktop/screen_cap.mov -filter_complex "[0:v] fps=12,scale=1600:-1,split [a][b];[a] palettegen [p];[b][p] paletteuse" ~/Desktop/screen_cap.gif
}

# -------- git --------
# stolen from: http://stackoverflow.com/questions/13064613/how-to-prune-local-tracking-branches-that-do-not-exist-on-remote-anymore
function clean_branches {
  git branch -r | awk '{ print $1 }'| egrep -v -f /dev/fd/0 <(git branch -vv | grep origin) | awk '{ print $1 }' | xargs git branch -d
}

# -------- jekyll --------
alias js='bundle exec jekyll serve'

# -------- postgres ---------
alias pgs="postgres -D /opt/homebrew/var/postgres"

# -------- "org mode" --------
alias notes='code -n ~/Desktop/notes.md'
alias scratchpad='code -n ~/Desktop/scratchpad.md'
alias todo='code -n ~/Desktop/todo.md'

# -------- ruby / rails --------
alias beq='RUBYOPT="-W:no-deprecated -W:no-experimental" bundle exec'
alias chset='cd && cd ~- && chruby' # go home && go back && verify ruby-version auto selected
alias credentials='EDITOR="atom -n --wait" bundle exec rails credentials:edit'

# stolen from: https://stackoverflow.com/questions/9146012/how-do-i-list-all-versions-of-a-gem-available-at-a-remote-site
function gem_versions {
  gem search ^$1$ --pre --all | grep -o '\((.*)\)$' | tr -d '() ' | tr ',' "\n"
}

# stolen from: http://stackoverflow.com/questions/3108395/serve-current-directory-from-command-line
function ruby_server {
  port="${1:-4000}"
  ruby -run -e httpd . -p $port
}

function test_multiple {
  bundle exec ruby -I.:test -e "ARGV.each { |f| require f }" ${@:1}
}

# -------- utilities --------
alias check_dns='scutil --dns'
alias desktop_off='defaults write com.apple.finder CreateDesktop false; killall Finder'
alias desktop_on='defaults write com.apple.finder CreateDesktop true; killall Finder'
alias disk_space='sudo du -a | sort -n -r | head -n 25' # run in /, shows 25 largest files
alias docker_host_ip='ipconfig getifaddr en0'
alias folder_space='sudo du -sh *' # shows top-level folder and file sizes where run
alias ll="ls -lha"
alias php_permissions='sudo chmod -R a+w .'

# stolen from: https://stackoverflow.com/a/33844061/1947079
function capture {
  sudo dtrace -p "$1" -qn '
    syscall::write*:entry
    /pid == $target && arg0 == 1/ {
      printf("%s", copyinstr(arg1, arg2));
    }
  '
}

function forever {
  # $($1 ${@:2}) == use the first argument as a command and just pass along everything else
  # \033c == ansi escape code to clear the screen
  while true; do echo -e "\033c$($1 ${@:2})"; sleep 2; done;
}

# get pids from process search
# ps -ef | grep KEYWORD | grep -v grep | awk '{print $2}'
# and to delete them
# ps -ef | grep KEYWORD | grep -v grep | awk '{print $2}' | xargs kill -9
function grep_kill {
  ps -ef | grep "$1" | grep -v grep | awk '{print $2}' | xargs kill -9
}

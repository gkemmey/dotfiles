PS1=">> "
export CLICOLOR=1
export LSCOLORS=GxFxCxDxBxegedabagaced

# -------- utilities --------
alias php_permissions='sudo chmod -R a+w .'
alias disk_space='sudo du -a | sort -n -r | head -n 25' # run in /, shows 25 largest files
alias folder_space='sudo du -sh *' # shows top-level folder and file sizes where run
alias check_dns='scutil --dns'
alias docker_host_ip='ipconfig getifaddr en0'
alias desktop_off='defaults write com.apple.finder CreateDesktop false; killall Finder'
alias desktop_on='defaults write com.apple.finder CreateDesktop true; killall Finder'

alias hints='tmp_f() { URL_PARAM=$(echo "$@" | sed "s/ /-/g"); lynx -accept_all_cookies https://devhints.io/"$URL_PARAM"; unset -f tmp_f; }; tmp_f'
alias search='tmp_f() { URL_PARAM=$(echo "$@" | sed "s/ /+/g"); lynx -accept_all_cookies https://duckduckgo.com/lite/?q="$URL_PARAM"; unset -f tmp_f; }; tmp_f'
alias spell='search'

alias todo='atom -n ~/Desktop/notes.md'
alias notes='atom -n ~/Desktop/notes.md'
alias snippet='atom -n ~/Desktop/snippet.rb'
alias scratchpad='atom -n ~/Desktop/scratchpad.md'

alias afk="/System/Library/CoreServices/Menu\ Extras/User.menu/Contents/Resources/CGSession -suspend"

# get pids from process search
# ps -ef | grep KEYWORD | grep -v grep | awk '{print $2}'
# and to delete them
# ps -ef | grep KEYWORD | grep -v grep | awk '{print $2}' | xargs kill -9
function grep_kill {
  ps -ef | grep "$1" | grep -v grep | awk '{print $2}' | xargs kill -9
}

function forever {
  # $($1 ${@:2}) == use the first argument as a command and just pass along everything else
  # \033c == ansi escape code to clear the screen
  while true; do echo -e "\033c$($1 ${@:2})"; sleep 2; done;
}

# stolen from: https://stackoverflow.com/a/33844061/1947079
function capture {
  sudo dtrace -p "$1" -qn '
    syscall::write*:entry
    /pid == $target && arg0 == 1/ {
      printf("%s", copyinstr(arg1, arg2));
    }
  '
}

function slack_emoji {
  target="${2:-thinking_face}"
  spacer="${3:-white_square}" # saw examples with blank, that would be cooler, doesn't seem to work in slack

  figlet -f banner $1 | sed -e "s/#/:$target:/g" | sed -e "s/ /:$spacer:/g"
}

alias start_pushing_images_to_minikube='eval $(minikube docker-env)'
alias stop_pushing_images_to_minikube='eval $(minikube docker-env -u)'

# stolen from: https://gist.github.com/shageman/11185993
# alias lines_of_code='find . -iname "*.rb" -type f -exec cat {} \; | wc -l'
alias lines_of_code='find . \( -path ./node_modules -o -path ./tmp -o -iname "*_bundle.js" -o -iname "*schema.rb" \) -prune -o \( -iname "*.rb" -o -iname "*.js" -o -iname "*.jsx" \) -type f -exec cat {} \; | wc -l'

# stolen from: https://gist.github.com/shageman/11190909
# alias files_by_lines_of_code='find . -iname "*.rb" -type f -exec wc -l {} \; | sort -rn'
alias files_by_lines_of_code='find . \( -path ./node_modules -o -path ./tmp -o -iname "*_bundle.js" -o -iname "*schema.rb" \) -prune -o \( -iname "*.rb" -o -iname "*.js" -o -iname "*.jsx" \) -type f -exec wc -l {} \; | sort -rn'

alias be='bundle exec'
alias beq='RUBYOPT="-W:no-deprecated -W:no-experimental" bundle exec'
alias console='bundle exec rails console'
alias server='bundle exec rails server'
alias credentials='EDITOR="atom -n --wait" bundle exec rails credentials:edit'
alias test_multiple='bundle exec ruby -I.:test -e "ARGV.each { |f| require f }"'
function test_multiple {
  bundle exec ruby -I.:test -e "ARGV.each { |f| require f }" ${@:1}
}
alias jekyll='bundle exec jekyll serve'

# stolen from: http://stackoverflow.com/questions/3108395/serve-current-directory-from-command-line
function ruby_server {
  port="${1:-4000}"
  ruby -run -e httpd . -p $port
}

# alias pr_gif="ffmpeg -i ~/Desktop/screen_cap.mov -vf scale=600:-1 -r 10 -f image2pipe -vcodec ppm - | convert -delay 5 -layers Optimize -loop 0 - ~/Desktop/screen_cap.gif"
function pr_gif {
  ffmpeg -i $1 -vf scale=600:-1 -r 10 -f image2pipe -vcodec ppm - | convert -delay 5 -layers Optimize -loop 0 - ~/Desktop/screen_cap.gif
}

# stolen from: http://stackoverflow.com/questions/13064613/how-to-prune-local-tracking-branches-that-do-not-exist-on-remote-anymore
function clean_branches {
  git branch -r | awk '{ print $1 }'| egrep -v -f /dev/fd/0 <(git branch -vv | grep origin) | awk '{ print $1 }' | xargs git branch -d
}

# stolen from: https://stackoverflow.com/questions/9146012/how-do-i-list-all-versions-of-a-gem-available-at-a-remote-site
function gem_versions {
  gem search ^$1$ --pre --all | grep -o '\((.*)\)$' | tr -d '() ' | tr ',' "\n"
}

if [ -f ~/.bashrc ]; then
   source ~/.bashrc
fi

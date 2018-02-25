PS1=">> "
export CLICOLOR=1
export LSCOLORS=GxFxCxDxBxegedabagaced

# -------- utilities --------
alias php_permissions='sudo chmod -R a+w .'
alias disk_space='sudo du -a | sort -n -r | head -n 25' # run in /, shows 25 largest files
alias folder_space='sudo du -sh *' # shows top-level folder and file sizes where run
alias check_dns='scutil --dns'

alias hints='tmp_f() { URL_PARAM=$(echo "$@" | sed "s/ /-/g"); lynx -accept_all_cookies https://devhints.io/"$URL_PARAM"; unset -f tmp_f; }; tmp_f'
alias search='tmp_f() { URL_PARAM=$(echo "$@" | sed "s/ /+/g"); lynx -accept_all_cookies https://duckduckgo.com/lite/?q="$URL_PARAM"; unset -f tmp_f; }; tmp_f'
alias spell='search'

function forever {
  # $($1 ${@:2}) == use the first argument as a command and just pass along everything else
  # \033c == ansi escape code to clear the screen
  while true; do echo -e "\033c$($1 ${@:2})"; sleep 2; done;
}

alias start_pushing_images_to_minikube='eval $(minikube docker-env)'
alias stop_pushing_images_to_minikube='eval $(minikube docker-env -u)'

# stolen from: https://gist.github.com/shageman/11185993
# alias lines_of_code='find . -iname "*.rb" -type f -exec cat {} \; | wc -l'
alias lines_of_code='find . \( -path ./node_modules -o -path ./tmp -o -iname "*_bundle.js" -o -iname "*schema.rb" \) -prune -o \( -iname "*.rb" -o -iname "*.js" -o -iname "*.jsx" \) -type f -exec cat {} \; | wc -l'

# stolen from: https://gist.github.com/shageman/11190909
# alias files_by_lines_of_code='find . -iname "*.rb" -type f -exec wc -l {} \; | sort -rn'
alias files_by_lines_of_code='find . \( -path ./node_modules -o -path ./tmp -o -iname "*_bundle.js" -o -iname "*schema.rb" \) -prune -o \( -iname "*.rb" -o -iname "*.js" -o -iname "*.jsx" \) -type f -exec wc -l {} \; | sort -rn'

alias console='bundle exec rails console'
alias server='bundle exec rails server'
alias jekyll='bundle exec jekyll serve'

# stolen from: http://stackoverflow.com/questions/3108395/serve-current-directory-from-command-line
function ruby_server {
  port="${1:-4000}"
  ruby -run -e httpd . -p $port
}

alias pr_gif="ffmpeg -i ~/Desktop/screen_cap.mov -vf scale=600:-1 -r 10 -f image2pipe -vcodec ppm - | convert -delay 5 -layers Optimize -loop 0 - ~/Desktop/screen_cap.gif"

# stolen from: http://stackoverflow.com/questions/13064613/how-to-prune-local-tracking-branches-that-do-not-exist-on-remote-anymore
function clean_branches {
  git branch -r | awk '{ print $1 }'| egrep -v -f /dev/fd/0 <(git branch -vv | grep origin) | awk '{ print $1 }' | xargs git branch -d
}

if [ -f ~/.bashrc ]; then
   source ~/.bashrc
fi

## Installation

1. `git clone git@github.com:gkemmey/dotfiles.git ~/.dotfiles`
2. `cd ~/.dotfiles`
3. `rake install`

## VS Code

### Save installed extensions

`rake sync:code:extensions`

## TODO

- [ ] automatically download oh-my-zsh plugins into `~/.oh-my-zsh/custom` from a manifest file
- [ ] same for terminal themes to `.terminal`
- [ ] how to track homebrew setup? homebrew offers something for this, i think
- [ ] change ~/.vscode/argv.json `enable-crash-reporter` to false
- [ ] vscode: set ignored extensions
- [ ] link usr/local/bin to /usr/local/bin
- [ ] link `zed` folder to `~/config/zed`

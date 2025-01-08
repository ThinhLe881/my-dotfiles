# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"

source ~/.zshenv
source ~/zsh/zsh-autocomplete/zsh-autocomplete.plugin.zsh

zle -N menu-search
zle -N recent-paths

# Plugins

plugins=(git vscode tmux z zsh-autosuggestions zsh-history-substring-search zsh-syntax-highlighting)

source $ZSH/oh-my-zsh.sh

# User configuration

bindkey              '^I' menu-select
bindkey "$terminfo[kcbt]" menu-select
bindkey "$terminfo[kcuu1]" history-substring-search-up
bindkey "$terminfo[kcud1]" history-substring-search-down

HISTSIZE=5000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

eval "$(starship init zsh)"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

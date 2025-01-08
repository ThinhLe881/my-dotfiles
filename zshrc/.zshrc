# path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# config non-zsh plugins
source ~/.zshenv
source ~/zsh/zsh-autocomplete/zsh-autocomplete.plugin.zsh

# add this to solve warnings from zsh-syntax-highlighting plugin
zle -N menu-search
zle -N recent-paths

# config zsh plugins
plugins=(git vscode tmux z zsh-autosuggestions zsh-history-substring-search zsh-syntax-highlighting)
source $ZSH/oh-my-zsh.sh

# config key bindings
bindkey              '^I' menu-select
bindkey "$terminfo[kcbt]" menu-select
bindkey "$terminfo[kcuu1]" history-substring-search-up
bindkey "$terminfo[kcud1]" history-substring-search-down

# config zsh history
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

# config Starship
eval "$(starship init zsh)"

# config fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

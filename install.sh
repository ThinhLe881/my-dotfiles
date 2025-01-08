#!/bin/bash

cd ~

# check if zsh is installed
if command -v zsh >/dev/null 2>&1; then
	echo "Zsh is already installed."
else
	echo "Zsh is not installed. Installing now..."
	sudo apt install -y zsh
fi

# install zsh
if [ ! -d "$HOME/.oh-my-zsh" ]; then
	echo "Oh My Zsh is not installed. Installing now..."
	sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

# install starship
echo "Updating Starship..."
curl -sS https://starship.rs/install.sh | sh

# install autocomplete plugin
echo "Updating zsh-autocomplete..."
PLUGIN_DIR=~/zsh-autocomplete
if [ ! -d "$PLUGIN_DIR" ]; then
	git clone --depth 1 -- https://github.com/marlonrichert/zsh-autocomplete.git
else
	cd "$PLUGIN_DIR" && git pull && cd ~
fi

# install autosuggestions plugin
echo "Updating zsh-autosuggestions..."
PLUGIN_DIR="${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions"
if [ ! -d "$PLUGIN_DIR" ]; then
	git clone https://github.com/zsh-users/zsh-autosuggestions "$PLUGIN_DIR"
else
        cd "$PLUGIN_DIR" && git pull && cd ~ 
fi

# install zsh-syntax-highlighting
echo "Updating zsh-syntax-highlighting..."
PLUGIN_DIR="${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting"
if [ ! -d "$PLUGIN_DIR" ]; then
        git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "$PLUGIN_DIR"                                                 
else
        cd "$PLUGIN_DIR" && git pull && cd ~ 
fi

# Check if stow is installed
if command -v stow >/dev/null 2>&1; then
	echo "GNU Stow is already installed."
else
	echo "GNU Stow is not installed. Installing now..."
	sudo apt install -y stow
fi

# stow dotfiles
echo "Stow dotfiles..."
cd ~/my-dotfiles/
stow zshrc
stow starship

# restart zsh
echo "Restart zsh..."
source ~/.zshrc
exec zsh

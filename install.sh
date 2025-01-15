#!/bin/bash

# function to check if plugin exists and update
update_plugin() {
	local plugin_url="$1"
	local plugin_dir="$2"
	if [ ! -d "$plugin_dir" ]; then
        	git clone --depth 1 -- "$plugin_url" "$plugin_dir"                                                 
	else
		cd "$plugin_dir" && git pull && cd "$HOME"
	fi
}

# function to remove a file if it's a regular file and not a symlink
remove_file_if_exists() {
	local file="$1"
	if [ -f "$file" ] && [ ! -L "$file" ]; then
	  	echo "Removing $file..."
	  	rm "$file"
  	fi
}

cd "$HOME"

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

# install homebrew
if command -v brew >/dev/null 2>&1; then
	echo "Homebrew is already installed."
else
	echo "Homebrew is not installed. Installing now..."
	/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# install starship
echo "Updating Starship..."
curl -sS https://starship.rs/install.sh | sh

# install tmux
if command -v tmux &> /dev/null; then
	echo "Tmux is already installed."
else
	echo "Tmux is not installed. Installing now..."
	sudo apt-get install -y tmux
fi

# install tmux-plugins/tpm
echo "Updating tmux-plugins/tpm"
update_plugin git clone https://github.com/tmux-plugins/tpm "$HOME/.tmux/plugins/tpm"

# install autosuggestions plugin
echo "Updating zsh-autosuggestions..."
update_plugin https://github.com/zsh-users/zsh-autosuggestions.git "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-autosuggestions"

# install zsh-syntax-highlighting
echo "Updating zsh-syntax-highlighting..."
update_plugin https://github.com/zsh-users/zsh-syntax-highlighting.git "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting"

# install zsh-history-substring-search
echo "Updating zsh-history-substring-search"
update_plugin https://github.com/zsh-users/zsh-history-substring-search.git "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-history-substring-search"

# install fzf
if command -v fzf >/dev/null 2>&1; then
  	echo "fzf is already installed."
else
	echo "fzf is not installed. Installing now..."
	git clone --depth 1 -- https://github.com/junegunn/fzf.git "$HOME/.fzf"
	"$HOME/.fzf/install"
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
remove_file_if_exists "$HOME/.zshrc"
remove_file_if_exists "$HOME/.config/starship.toml"
cd "$HOME/my-dotfiles/"
stow zshrc
stow starship

# restart zsh
echo "Restart zsh..."
source "$HOME/.zshrc"
exec zsh

#!/bin/bash

command_exists () {
    type "$1" &> /dev/null ;
}

echo "Updating software"
softwareupdate --install --all

if ! xcode-select -p > /dev/null 2>&1
then
	echo "Installing Command Line Tools"
	touch /tmp/.com.apple.dt.CommandLineTools.installondemand.in-progress
	PROD=$(softwareupdate -l | grep "\*.*Command Line" | head -n 1 | awk -F"*" '{print $2}' | sed -e 's/^ *//' | tr -d '\n')
	softwareupdate -i "$PROD"
	rm /tmp/.com.apple.dt.CommandLineTools.installondemand.in-progress
else
	echo "Command Line Tools already installed"
fi

if ! command_exists brew
then
	echo "Installing Homebrew"
	/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
else
	echo "Homebrew already installed"
fi

echo "Updating Homebrew"
brew update
brew upgrade

if ! command_exists mate
then
	echo "Installing TextMate"
	brew cask install textmate
else
	echo "TextMate already installed"
fi

if [ ! -f ~/.ssh/id_rsa ]
then
	echo "Generating SSH key pair"
	ssh-keygen -N "" -f ~/.ssh/id_rsa
else
	echo "SSH key pair already exists"
fi

if ! brew cask list keypad-layout > /dev/null 2>&1
then
    echo "Installing Keypad Layout"
    brew cask install keypad-layout
else
	echo "Keypad Layout is already installed"
fi

if [ ! -f "/usr/local/share/antigen/antigen.zsh" ]
then
    echo "Installing antigen"
    brew install antigen
else
	echo "Antigen is already installed"
fi

if [ ! -f "$HOME/.zsh/pure/pure.zsh" ]
then
    echo "Installing pure prompt"
    mkdir -p "$HOME/.zsh"
    git clone https://github.com/sindresorhus/pure.git "$HOME/.zsh/pure"
else
    echo "Pure is already installed"
fi

if ! brew list vim > /dev/null 2>&1
then
    echo "Installing vim"
    brew install vim
else
    echo "Vim is already installed"
fi

echo "Cloning mac-setup"
git clone https://github.com/janten/mac-setup.git /tmp/mac-setup

echo "Setting preferences"
defaults import com.apple.Terminal /tmp/mac-setup/com.apple.Terminal.plist
cp /tmp/mac-setup/gitconfig ~/.gitconfig
cp /tmp/mac-setup/vimrc ~/.vimrc
cp /tmp/mac-setup/zshrc ~/.zshrc
cp /tmp/mac-setup/gitignore_global ~/.gitignore_global

echo "Changing shell to ZSH"
sudo chsh -s /bin/zsh janten

echo "Setting up ZSH"
zsh ~/.zshrc

echo "Cleaning up"
brew cleanup
rm -rf /tmp/mac-setup

echo "Installation complete. Restart your terminal."

#!/bin/bash

command_exists () {
    type "$1" &> /dev/null ;
}

echo "Setting time and date"
sudo ntpdate -u time.uni-muenster.de
sudo ntpdate -u 1.de.pool.ntp.org

echo "Updating software"
softwareupdate --install --all

if ! xcode-select -p &> /dev/null
then
	echo "Installing Command Line Tools"
	touch /tmp/.com.apple.dt.CommandLineTools.installondemand.in-progress
	PROD=$(softwareupdate -l | grep "\*.*Command Line" | head -n 1 | awk -F"*" '{print $2}' | sed -e 's/^ *//' | tr -d '\n')
	softwareupdate -i "$PROD"
else
	echo "Command Line Tools already installed"
fi

if ! command_exists brew
then
	echo "Installing Homebrew"
	ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
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

if ! command_exists wget
then
	echo "Installing wget"
	brew install wget
else
	echo "wget already installed"
fi

if [ ! -f ~/.ssh/authorized_keys ]
then
	echo "Installing SSH keys from GitHub"
	mkdir ~/.ssh
	curl "https://github.com/janten.keys" > ~/.ssh/authorized_keys
else
	echo "Some SSH keys already present"
fi

if ! command_exists antigen
then
    echo "Installing antigen"
    brew install antigen
    chsh -s /bin/fish
else
	echo "The fish shell is already installed"
fi

echo "Installing vim"
brew install vim --with-python3 --with-override-system-vi

echo "Cloning mac-setup"
git clone https://github.com/janten/mac-setup.git /tmp/mac-setup

echo "Setting preferences"
cp /tmp/mac-setup/gitconfig ~/.gitconfig
cp /tmp/mac-setup/vimrc ~/.vimrc
cp /tmp/mac-setup/zshrc ~/.zshrc
cp /tmp/mac-setup/gitignore_global ~/.gitignore_global
cp /tmp/mac-setup/com.apple.Terminal.plist ~/Library/Preferences/com.apple.Terminal.plist

echo "Cleaning up"
brew cleanup
brew cask cleanup
rm -rf /tmp/mac-setup

echo "Installation complete. You should restart your terminal."
zsh

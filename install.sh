#!/bin/bash

command_exists () {
    type "$1" &> /dev/null ;
}

if ! xcode-select -p &> /dev/null ; then
	touch /tmp/.com.apple.dt.CommandLineTools.installondemand.in-progress
	PROD=$(softwareupdate -l | grep "\*.*Command Line" | head -n 1 | awk -F"*" '{print $2}' | sed -e 's/^ *//' | tr -d '\n')
	softwareupdate -i "$PROD" -v
else
	echo "Command Line Tools already installed"
	return 0
fi

git clone https://github.com/janten/mac-setup.git /tmp/mac-setup
cd /tmp/mac-setup

cp zshrc ~/.zshrc
cp gitconfig ~/.gitconfig
cp gitignore_global ~/.gitignore_global
cp com.apple.Terminal.plist ~/Library/Preferences/com.apple.Terminal.plist
cp "Inconsolata for Powerline.otf" ~/Library/Fonts/

if ! command_exists brew ; then
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
else
	echo "Homebrew already installed"
fi

if ! command_exists brew-cask ; then
    brew install caskroom/cask/brew-cask
else
	echo "brew-cask already installed"
fi

if ! command_exists mate ; then
	brew cask install textmate
else
	echo "TextMate already installed"
fi

if ! command_exists wget ; then
    brew install wget
else
	echo "wget already installed"
fi

if ! command_exists upgrade_oh_my_zsh ; then
	sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
else
	upgrade_oh_my_zsh
fi

if ! brew list zsh-syntax-highlighting &> /dev/null ; then
	brew install zsh-syntax-highlighting
else
	echo "zsh completion already installed"
fi

brew cleanup
brew cask cleanup

echo "Installation complete. You should restart your terminal."
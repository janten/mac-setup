#!/bin/bash

command_exists () {
    type "$1" &> /dev/null ;
}

echo "Updating software"
softwareupdate --install --all

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
	brew install textmate --cask
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
    brew install keypad-layout --cask
else
	echo "Keypad Layout is already installed"
fi

if [ ! -f ~/.zplug ]
then
    echo "Installing zplug"
    curl -sL --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh | zsh
else
	echo "zplug is already installed"
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
git clone https://github.com/$USER/mac-setup.git /tmp/mac-setup

echo "Setting preferences"
defaults import com.apple.Terminal /tmp/mac-setup/com.apple.Terminal.plist
cp /tmp/mac-setup/gitconfig ~/.gitconfig
cp /tmp/mac-setup/vimrc ~/.vimrc
cp /tmp/mac-setup/zshrc ~/.zshrc
cp /tmp/mac-setup/gitignore_global ~/.gitignore_global

echo "Changing shell to ZSH"
sudo chsh -s /bin/zsh $USER

echo "Setting up ZSH"
zsh ~/.zshrc

echo "Cleaning up"
brew cleanup
rm -rf /tmp/mac-setup

echo "Installation complete. Restart your terminal."

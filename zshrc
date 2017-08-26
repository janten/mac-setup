source /usr/local/share/antigen/antigen.zsh

# Load the oh-my-zsh's library.
antigen use oh-my-zsh

# Bundles from the default repo (robbyrussell's oh-my-zsh).
antigen bundle docker
antigen bundle git
antigen bundle gitignore
antigen bundle heroku
antigen bundle httpie
antigen bundle osx
antigen bundle pip
antigen bundle pod
antigen bundle python
antigen bundle sudo

antigen bundle hlissner/zsh-autopair
antigen bundle zsh-users/zsh-autosuggestions
antigen bundle zsh-users/zsh-completions
antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle zsmizzle/fixnumpad-osx.plugin.zsh 

# Load the theme.
antigen bundle mafredri/zsh-async
antigen bundle sindresorhus/pure
 
# Tell Antigen that you're done.
antigen apply

# User configuration

# Compilation flags
# export ARCHFLAGS="-arch x86_64"
export HOMEBREW_MAKE_JOBS=32
export PATH="$PATH:$HOME/esp/xtensa-esp32-elf/bin"
export IDF_PATH="$HOME/esp/esp-idf"

source /opt/homebrew/share/antigen/antigen.zsh

PATH="$PATH:/opt/homebrew/opt/python@3.9/libexec/bin"
fpath+=$HOME/.zsh/pure

# Load the oh-my-zsh's library.
antigen use oh-my-zsh

# Bundles from the default repo (robbyrussell's oh-my-zsh).
antigen bundle docker
antigen bundle git
antigen bundle gitignore
antigen bundle heroku
antigen bundle httpie
antigen bundle macos
antigen bundle pip
antigen bundle pod
antigen bundle python
antigen bundle sudo

antigen bundle hlissner/zsh-autopair
antigen bundle zsh-users/zsh-autosuggestions
antigen bundle zsh-users/zsh-completions
antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle zsmizzle/fixnumpad-osx.plugin.zsh 
antigen bundle MichaelAquilina/zsh-autoswitch-virtualenv

# Load the theme.
antigen bundle mafredri/zsh-async
 
# Tell Antigen that you're done.
antigen apply

# User configuration
autoload -U promptinit; promptinit
prompt pure

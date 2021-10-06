#
# ~/.bashrc
#
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
EDITOR=nvim

[[ -f ~/.bash_aliases ]] && source ~/.bash_aliases
[[ -f ~/.bash_functions ]] && source ~/.bash_functions
[[ -f ~/.bash_custom ]] && source ~/.bash_functions
[[ -f ~/.profile ]] && source ~/.profile

[ -f ~/.fzf.bash ] && source ~/.fzf.bash

#GOODBYE CAPSLOCK
setxkbmap -option caps:escape
export PATH="$PATH:/usr/local/bin/ignition"
export JAVA_HOME="/usr/lib/jvm/java-8-openjdk-amd64"
export NVM_DIR="$HOME/.nvm"
export FLASK_ENV="development"
export PATH=$PATH:/usr/local/go/bin
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
ulimit -S -n 2048

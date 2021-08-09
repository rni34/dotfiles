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

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="/home/kenzie/.sdkman"
[[ -s "/home/kenzie/.sdkman/bin/sdkman-init.sh" ]] && source "/home/kenzie/.sdkman/bin/sdkman-init.sh"
export PATH="$PATH:/usr/local/bin/ignition"
alias ignition="/usr/local/bin/ignition/ignition.sh"
export JAVA_HOME="/usr/lib/jvm/java-8-openjdk-amd64"


export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

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

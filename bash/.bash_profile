# ~/.bash_profile
#

[[ -f ~/.bashrc ]] && . ~/.bashrc
[[ -f ~/.bash_custom ]] && source ~/.bash_custom

#[[ ! $DISPLAY && $XDG_VTNR -eq 1 && $(id --group) -ne 0 ]] && exec startx

export PATH="$HOME/.cargo/bin:$PATH"

# get current branch in git repo
function get_battery() {
    HOSTNAME=$(hostname)
    if [[ "$HOSTNAME" != "desktop" ]]
    then
        BATT=$(acpi | cut -d',' -f2 | xargs)
        echo "[Battery:${BATT}]"
    fi
}

function parse_git_branch() {
	BRANCH=`git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/'`
	if [ ! "${BRANCH}" == "" ]
	then
		STAT=`parse_git_dirty`
		echo "[${BRANCH}${STAT}]"
	else
		echo ""
	fi
}

# get current status of git repo
function parse_git_dirty {
	status=`git status 2>&1 | tee`
	dirty=`echo -n "${status}" 2> /dev/null | grep "modified:" &> /dev/null; echo "$?"`
	untracked=`echo -n "${status}" 2> /dev/null | grep "Untracked files" &> /dev/null; echo "$?"`
	ahead=`echo -n "${status}" 2> /dev/null | grep "Your branch is ahead of" &> /dev/null; echo "$?"`
	newfile=`echo -n "${status}" 2> /dev/null | grep "new file:" &> /dev/null; echo "$?"`
	renamed=`echo -n "${status}" 2> /dev/null | grep "renamed:" &> /dev/null; echo "$?"`
	deleted=`echo -n "${status}" 2> /dev/null | grep "deleted:" &> /dev/null; echo "$?"`
	bits=''
	if [ "${renamed}" == "0" ]; then
		bits=">${bits}"
	fi
	if [ "${ahead}" == "0" ]; then
		bits="*${bits}"
	fi
	if [ "${newfile}" == "0" ]; then
		bits="+${bits}"
	fi
	if [ "${untracked}" == "0" ]; then
		bits="?${bits}"
	fi
	if [ "${deleted}" == "0" ]; then
		bits="x${bits}"
	fi
	if [ "${dirty}" == "0" ]; then
		bits="!${bits}"
	fi
	if [ ! "${bits}" == "" ]; then
		echo " ${bits}"
	else
		echo ""
	fi
}
# Sample .profile for SuSE Linux
# rewritten by Christian Steinruecken <cstein@suse.de>
#
# This file is read each time a login shell is started.
# All other interactive shells will only read .bashrc; this is particularly
# important for language settings, see below.

test -z "$PROFILEREAD" && . /etc/profile || true

# Most applications support several languages for their output.
# To make use of this feature, simply uncomment one of the lines below or
# add your own one (see /usr/share/locale/locale.alias for more codes)
# This overwrites the system default set in /etc/sysconfig/language
# in the variable RC_LANG.
#
#export LANG=de_DE.UTF-8	# uncomment this line for German output
#export LANG=fr_FR.UTF-8	# uncomment this line for French output
#export LANG=es_ES.UTF-8	# uncomment this line for Spanish output


# Some people don't like fortune. If you uncomment the following lines,
# you will have a fortune each time you log in ;-)

#if [ -x /usr/bin/fortune ] ; then
#    echo
#    /usr/bin/fortune
#    echo
#fi

export PS1="Exit: [$?] \`get_battery\` \`parse_git_branch\` \w \n> "
export PATH="${HOME}/.local/bin:$PATH"
export PATH="$PATH:/usr/local/go/bin"
export GOPATH="$HOME/dev/go"
export GOBIN="$HOME/dev/go/bin"
export CGO_ENABLED=1
export PATH="$PATH:$(go env GOPATH)/bin"
# macOS cross compiler
export PATH="$PATH:/home/kenzie/dev/osxcross/target/bin"
export FZF_DEFAULT_COMMAND='fd --type f --follow --exclude .git -E "*.class" -E "*.hex"'

export PATH="$HOME/.cargo/bin:$PATH"
export PATH="$HOME/flutter/bin:$PATH"
export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"
export PATH=$PATH:$HOME/.gem/ruby/2.6.0/bin
# Fix for intellij IDEAVIM locking keyboard
export XMODIFIERS=""
export IBUS_ENABLE_SYNC_MODE=1
export MOZ_USE_XINPUT2=1
export JAVA_HOME=/usr/lib64/jvm/jre-1.8.0
#export PATH=$PATH:$HOME/node_modules/.bin
#export NODE_PATH="$(npm root)"
[[ -f ~/.bash_custom ]] && source ~/.bash_custom



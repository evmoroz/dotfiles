# ttyz bashrc
#
# Thu, Aug 20, 2015  9:33:56 AM
#
#

# bash options
shopt -s cdspell
shopt -s extglob
shopt -s dirspell
shopt -s nocaseglob
shopt -s autocd
shopt -s no_empty_cmd_completion
if [[ $(uname -s) =~ ^CYGWIN* ]] ; then
	shopt -s completion_strip_exe

	function explore {
		EXPLORE_PATH=${1:-.}
		explorer $(cygpath -w $EXPLORE_PATH)
	}
fi

# Aliases

# ls colored output
alias ls='ls --color'

# Use vim insted of vi
alias vi='vim'
alias nano='vim'

# set vim as the default editor
export VISUAL=vim
export EDITOR="$VISUAL"

export PS1="\n\[\033[38;5;11m\]\u@\h\]\[\033[38;5;15m\] \]\[\033[38;5;208m\][\w]:\]\[\033[38;5;15m\]\n\\$ \[\e[0m\]"

# Add composer bin to the path if present
COMPOSER_BIN=${HOME}/.composer/vendor/bin
if [ -d ${COMPOSER_BIN} ] ; then
	export PATH=${COMPOSER_BIN}:${PATH}
fi

if [ -d ${HOME}/bin ] ; then
	export PATH=${HOME}/bin:${PATH}
fi

# Better history
shopt -s histappend
shopt -s cmdhist
PROMPT_COMMAND='history -a'
HISTSIZE=500000
HISTFILESIZE=100000
HISTCONTROL="erasedups:ignoreboth"
export HISTIGNORE="&:[ ]*:exit:ls:bg:fg:history"
HISTTIMEFORMAT='%F %T '

function upgall {
	if [[ -x "${HOME}/upgrade.sh" ]]; then
		${HOME}/upgrade.sh
	fi

	composer global update
}

# Load local bashrc if there is one
if [ -f ${HOME}/.local.bashrc ] ; then
	source ${HOME}/.local.bashrc
fi


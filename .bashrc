# ttyz bashrc
#
# Thu, Aug 20, 2015  9:33:56 AM
#
#

# bash options
shopt -s cdspell
shopt -s extglob
shopt -s nocaseglob
shopt -s autocd
shopt -s no_empty_cmd_completion
if [[ $(uname -s) =~ ^CYGWIN* ]] ; then
	shopt -s completion_strip_exe
fi

# Aliases

# ls colored output
alias ls='ls --color'

# Use vim insted of vi
alias vi='vim'

# set vim as the default editor
export VISUAL=vim
export EDITOR="$VISUAL"

export PS1="\n\[\033[38;5;11m\]\u@\h\]\[\033[38;5;15m\] \]\[\033[38;5;208m\][\w]:\]\[\033[38;5;15m\]\n\\$ \[\e[0m\]"

# Load local bashrc if there is one
if [ -f ${HOME}/.local.bashrc ] ; then
	source ${HOME}/.local.bashrc
fi

# Add composer bin to the path if present
COMPOSER_BIN=${HOME}/.composer/vendor/bin
if [ -d ${COMPOSER_BIN} ] ; then
	export PATH=${COMPOSER_BIN}:${PATH}
fi

if [ -d ${HOME}/bin ] ; then
	export PATH=${HOME}/bin:${PATH}
fi

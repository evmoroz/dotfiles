# ttyz bashrc
#
# Thu, Aug 20, 2015  9:33:56 AM
#
#

# Aliases

# ls colored output
alias ls='ls --color'

# Use vim insted of vi
alias vi='vim'

# set vim as the default editor
export VISUAL=vim
export EDITOR="$VISUAL"

export PS1="\n\[\033[38;5;11m\]\u@\h\]\[\033[38;5;15m\] \]\[\033[38;5;208m\][\w]:\]\[\033[38;5;15m\]\n\\$ "

# Load local bashrc if there is one
if [ -f ${HOME}/.local.bashrc ] ; then
	source ${HOME}/.local.bashrc
fi


if [ -d ${HOME}/bin ] ; then
	export PATH=${HOME}/bin:${PATH}
fi

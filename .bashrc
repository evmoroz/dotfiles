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

# Load local bashrc if there is one
if [ -f ${HOME}/.local.bashrc ] ; then
	source ${HOME}/.local.bashrc
fi

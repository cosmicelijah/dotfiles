#
# ~/.bashrc "editconfig"
#

# If not running interactively, don't do anything
	 [[ $- != *i* ]] && return

# Adds bash header from the ~/.bash_header "header" file and pipes it through lolcat for the lolz

	cat ~/.bash_header | cowsay | lolcat

# Adds aliases from the ~/.bash_aliases "addalias" file

	if [ -f ~/.bash_aliases ]; then
        	. ~/.bash_aliases
	fi

# Changes PS scripts

PS1='\[\e[1;33m\]{\[\e[1;31m\]\u\[\e[1;32m\]@\[\e[1;34m\]\h\[\e[1;33m\]}-\[\e[1;33m\][\[\e[1;35m\]\w\[\e[1;33m\]]\[\e[1;37m\]\$\[\e[0;37m\] '
PS2='\[\e[1;35m\]>\[\e[0;37m\] '


	## Extra fun things


# Color (hopefully)

	export GREP_OPTIONS="--color=auto"

# Remove duplicate commands in bash history

	export HISTCONTROL=ignoredups

# Automatically cd into a directory without using cd command

	shopt -s autocd

# To the extent possible under law, the author(s) have dedicated all 
# copyright and related and neighboring rights to this software to the 
# public domain worldwide. This software is distributed without any warranty. 
# You should have received a copy of the CC0 Public Domain Dedication along 
# with this software. 
# If not, see <http://creativecommons.org/publicdomain/zero/1.0/>. 

# /etc/bash.bashrc: executed by bash(1) for interactive shells.

# System-wide bashrc file

# Check that we haven't already been sourced.
([[ -z ${CYG_SYS_BASHRC} ]] && CYG_SYS_BASHRC="1") || return

# If not running interactively, don't do anything
[[ "$-" != *i* ]] && return

# Set a default prompt of: user@host, MSYSTEM variable, and current_directory
#PS1='\[\e]0;\w\a\]\n\[\e[32m\]\u@\h \[\e[35m\]$MSYSTEM\[\e[0m\] \[\e[33m\]\w\[\e[0m\]\n\$ '

# Uncomment to use the terminal colours set in DIR_COLORS
eval "$(dircolors -b /etc/DIR_COLORS)"

#-------------------------------------------------------------
# The 'ls' family (this assumes you use a recent GNU ls).
#-------------------------------------------------------------
# Add colors for filetype and  human-readable sizes by default on 'ls':
alias ls='ls -h -F --color --show-control-chars'

alias more='less'
export PAGER=less
export LESSCHARSET='latin1'
export LESSOPEN='|/usr/bin/lesspipe.sh %s 2>&-'
                # Use this if lesspipe.sh exists.
export LESS='-i -N -w  -z-4 -g -e -M -X -F -R -P%t?f%f \
:stdin .?pb%pb\%:?lbLine %lb:?bbByte %bb:-...'

# LESS man page colors (makes Man pages more readable).
export LESS_TERMCAP_mb=$'\E[01;31m'
export LESS_TERMCAP_md=$'\E[01;31m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_so=$'\E[01;44;33m'
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_us=$'\E[01;32m'

#GIT_PS1_SHOWUPSTREAM_GLYPH: One of none|arrow|rlarrowhead|udarrowhead|rltri|udtri|custom
#GIT_PS1_SHOWUPSTREAM_GLYPH="none"
#GIT_PS1_SHOWUPSTREAM_CUSTOM_AHEAD_GLYPH=""
#GIT_PS1_SHOWUPSTREAM_CUSTOM_BEHIND_GLYPH=""
#GIT_PS1_SHOWUPSTRAM_CUSTOM_DIVERGED_GLYPH=""

#GIT_PS1_SHOWUPSTREAM_USE_SEPARATOR=0
#GIT_PS1_SHOWUPSTREAM_SEPARATOR_GLYPH=""

#GIT_PS1_DETACHED_HEAD_COLOR="$(tput setaf 9)"
#GIT_PS1_OK_BRANCH_COLOR="$(tput setaf 2)"
#GIT_PS1_INITIAL_COMMIT_GLYPH="#"
#GIT_PS1_INITIAL_COMMIT_GLYPH_COLOR="$(tput setaf 2)"
#GIT_PS1_STAGED_FILES_GLYPH="+"
#GIT_PS1_STAGED_FILES_GLYPH_COLOR="$(tput setaf 2)"
#GIT_PS1_UNTRACKED_FILES_GLYPH="%"
#GIT_PS1_UNTRACKED_FILES_GLYPH_COLOR="$(tput setaf 1)"
#GIT_PS1_UNSTAGED_FILES_GLYPH="*"
#GIT_PS1_UNSTAGED_FILES_GLYPH_COLOR="$(tput setaf 1)"
#GIT_PS1_STASHED_STATE_GLYPH="$"
#GIT_PS1_STASHED_STATE_GLYPH_COLOR="$(tput setaf 4)"

#GIT_PS1_SHOWDIRTYSTATE=
#GIT_PS1_SHOWSTASHSTATE=
#GIT_PS1_SHOWUNTRACKEDFILES=
#GIT_PS1_SHOWCOLORHINTS=
#GIT_PS1_SHOWUPSTREAM="auto git verbose"

# GIT_PS1_DESCRIBE_STYLE
#  -- contains  - Looks forward in the tree for a tag, so you know which tag you're behind.
#  -- branch    - Looks forward in the tree for a tag or a branch (whatever's nearest).
#  -- describe  - Looks backwards in the tree for a tag so you know which tag you're ahead of.
#  -- (default) - If you're exactly on a tag, display it. If the method you choose fails to find a
#                 tag/branch to display, you'll see the commit id instead. 
#GIT_PS1_DESCRIBE_STYLE=""

SH_PS1_DONT_COLORIZE_PROMPT=0

#SH_PS1_USERNAME_COLOR="$(tput setaf 2)"
#SH_PS1_HOSTNAME_COLOR="$(tput setaf 2)"
#SH_PS1_USER_HOST_SEPARATOR_COLOR="$(tput setaf 2)"
#SH_PS1_PWD_COLOR="$(tput setaf 3)"
#SH_PS1_PROMPT_COLOR="$(tput sgr0)"

#SH_PS1_USERNAME="\u"
#SH_PS1_HOSTNAME="\h"
#SH_PS1_USER_HOST_SEPARATOR="@"
#SH_PS1_PWD="\n$(tput setaf 15)PWD: $(tput sgr0)\w"

#SH_PS1_PROMPT="\n\\\$ "
#SH_PS1_FORMAT_STRING="%u%z%h%w%v"

# Fixup git-bash in non login env
if [[ -e ~/.bash-prompt.sh ]]; then
	shopt -q login_shell || . ~/.bash-prompt.sh
elif [[ -e ~/bash-prompt.sh ]]; then
	shopt -q login_shell || . ~/bash-prompt.sh
elif [[ -e ~/.git-prompt.sh ]]; then
	shopt -q login_shell || . ~/.git-prompt.sh
	PROMPT_COMMAND='__git_ps1 "$(tput setaf 2)\u@\h ${MSYSTEM+$(tput setaf 5)$MSYSTEM }$(tput setaf 3)\w$(tput sgr0)" "\n\\\$ " " (%s)"'
	return
elif [[ -e ~/git-prompt.sh ]]; then
	shopt -q login_shell || . ~/git-prompt.sh
	PROMPT_COMMAND='__git_ps1 "$(tput setaf 2)\u@\h ${MSYSTEM+$(tput setaf 5)$MSYSTEM }$(tput setaf 3)\w$(tput sgr0)" "\n\\\$ " " (%s)"'
	return
else
	shopt -q login_shell || . /etc/profile.d/git-prompt.sh
	PROMPT_COMMAND='__git_ps1 "$(tput setaf 2)\u@\h ${MSYSTEM+$(tput setaf 5)$MSYSTEM }$(tput setaf 3)\w$(tput sgr0)" "\n\\\$ " " (%s)"'
	return
fi

PROMPT_COMMAND='__bash_ps1 "${BASH_PS1_FORMAT_STRING-}" "\n$(tput setaf 15)GIT:$(tput sgr0) %s$(tput sgr0)"'

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
GIT_PS1_SHOWUPSTREAM_GLYPH="none"
GIT_PS1_SHOWUPSTREAM_CUSTOM_AHEAD_GLYPH=""
GIT_PS1_SHOWUPSTREAM_CUSTOM_BEHIND_GLYPH=""
GIT_PS1_SHOWUPSTRAM_CUSTOM_DIVERGED_GLYPH=""

GIT_PS1_SHOWUPSTREAM_USE_SEPARATOR=0
GIT_PS1_SHOWUPSTREAM_SEPARATOR_GLYPH=""

GIT_PS1_DETACHED_HEAD_COLOR="$(tput setaf 9)"
GIT_PS1_OK_BRANCH_COLOR="$(tput setaf 2)"
GIT_PS1_INITIAL_COMMIT_GLYPH="#"
GIT_PS1_INITIAL_COMMIT_GLYPH_COLOR="$(tput setaf 2)"
GIT_PS1_STAGED_FILES_GLYPH="+"
GIT_PS1_STAGED_FILES_GLYPH_COLOR="$(tput setaf 2)"
GIT_PS1_UNTRACKED_FILES_GLYPH="%"
GIT_PS1_UNTRACKED_FILES_GLYPH_COLOR="$(tput setaf 1)"
GIT_PS1_UNSTAGED_FILES_GLYPH="*"
GIT_PS1_UNSTAGED_FILES_GLYPH_COLOR="$(tput setaf 1)"
GIT_PS1_STASHED_STATE_GLYPH="$"
GIT_PS1_STASHED_STATE_GLYPH_COLOR="$(tput setaf 4)"

GIT_PS1_SHOWDIRTYSTATE=
GIT_PS1_SHOWSTASHSTATE=
GIT_PS1_SHOWUNTRACKEDFILES=
GIT_PS1_SHOWCOLORHINTS=
GIT_PS1_SHOWUPSTREAM="auto git verbose"

# GIT_PS1_DESCRIBE_STYLE
#  -- contains  - Looks forward in the tree for a tag, so you know which tag you're behind.
#  -- branch    - Looks forward in the tree for a tag or a branch (whatever's nearest).
#  -- describe  - Looks backwards in the tree for a tag so you know which tag you're ahead of.
#  -- (default) - If you're exactly on a tag, display it. If the method you choose fails to find a
#                 tag/branch to display, you'll see the commit id instead. 
#GIT_PS1_DESCRIBE_STYLE="branch"

BASH_PS1_SHOW_USERNAME=1
BASH_PS1_SHOW_HOSTNAME=1
BASH_PS1_SHOW_PWD=1
BASH_PS1_SHOW_GIT_PROMPT=1

BASH_PS1_USERNAME_COLOR="$(tput setaf 2)"
BASH_PS1_HOSTNAME_COLOR="$(tput setaf 2)"
BASH_PS1_USER_HOST_SEPARATOR_COLOR="$(tput setaf 2)"
BASH_PS1_PWD_COLOR="$(tput setaf 3)"
BASH_PS1_PROMPT_COLOR="$(tput sgr0)"

BASH_PS1_USERNAME='\u'
BASH_PS1_HOSTNAME='\h'
BASH_PS1_USER_HOST_SEPARATOR="@"
BASH_PS1_PWD="\n$(tput setaf 15)PWD: $(tput sgr0)\\w"

BASH_PS1_USER_HOST_SEPARATOR="@"
BASH_PS1_PROMPT="\n\\\$ "

# Fixup git-bash in non login env
shopt -q login_shell || . /etc/profile.d/git-prompt.sh

#__bash_ps1 ps1pc_start, ps1pc_end, prompt_format_string, git_prompt_format_string
function __bash_ps1()
{
	# Preserve exit status
	local exit=$?
	
	local user_color sep_color host_color pwd_color
	local show_git_prompt git_prompt_printf_format
	local ps1pc_start=""
	local ps1pc_end=""
	local printf_format="%s"
	
	case "$#" in
		0|1|2)	printf_format="${1:-$printf_format}"
			git_prompt_printf_format="${2:- (%s)}"
		;;
		*)		ps1pc_start="$1"
			ps1pc_end="$2"
			printf_format="${3:-$printf_format}"
			git_prompt_printf_format="${4:- (%s)}"
		;;
	esac
	
	# Shamelessly copied the below from git-prompt.sh -- may not need this, and if not, I'll remove it.
	#
	#------------------------------------------------------------
	# ps1_expanded:  This variable is set to 'yes' if the shell
	# subjects the value of PS1 to parameter expansion:
	#
	#   * bash does unless the promptvars option is disabled
	#   * zsh does not unless the PROMPT_SUBST option is set
	#   * POSIX shells always do
	#
	# If the shell would expand the contents of PS1 when drawing
	# the prompt, a raw ref name must not be included in PS1.
	# This protects the user from arbitrary code execution via
	# specially crafted ref names.  For example, a ref named
	# 'refs/heads/$(IFS=_;cmd=sudo_rm_-rf_/;$cmd)' might cause the
	# shell to execute 'sudo rm -rf /' when the prompt is drawn.
	#
	# Instead, the ref name should be placed in a separate global
	# variable (in the __git_ps1_* namespace to avoid colliding
	# with the user's environment) and that variable should be
	# referenced from PS1.  For example:
	#
	#     __git_ps1_foo=$(do_something_to_get_ref_name)
	#     PS1="...stuff...\${__git_ps1_foo}...stuff..."
	#
	# If the shell does not expand the contents of PS1, the raw
	# ref name must be included in PS1.
	#
	# The value of this variable is only relevant when in pcmode.
	#
	# Assume that the shell follows the POSIX specification and
	# expands PS1 unless determined otherwise.  (This is more
	# likely to be correct if the user has a non-bash, non-zsh
	# shell and safer than the alternative if the assumption is
	# incorrect.)
	#
	local bash_ps1_expanded=yes
	[ -z "$ZSH_VERSION" ] || [[ -o PROMPT_SUBST ]] || bash_ps1_expanded=no
	[ -z "$BASH_VERSION" ] || shopt -q promptvars || bash_ps1_expanded=no
	
	local user="${BASH_PS1_USERNAME:-\\u}"
	local user_color="${BASH_PS1_USERNAME_COLOR:-$(tput setaf 2)}"
	local sep="${BASH_PS1_USER_HOST_SEPARATOR:-@}"
	local sep_color="${BASH_PS1_USER_HOST_SEPARATOR_COLOR:-$user_color}"
	local host="${BASH_PS1_HOSTNAME:-\\h}"
	local host_color="${BASH_PS1_HOSTNAME_COLOR:-$user_color}"
	local pwd=" ${BASH_PS1_PWD:-\\w}"
	local pwd_color="${BASH_PS1_PWD_COLOR:-$(tput setaf 3)}"
	local prompt_delimiter="${BASH_PS1_PROMPT:-\n\\\$ }"
	local prompt_delimiter_color="${BASH_PS1_PROMPT_COLOR:-$(tput sgr0)}"
	
	if [ ${BASH_PS1_SHOW_USERNAME:-1} != 1 ]; then
		user=""
	fi
	
	if [ ${BASH_PS1_SHOW_HOSTNAME:-1} != 1 ]; then
		host=""
	fi
	
	if [ ${BASH_PS1_SHOW_PWD:-1} != 1 ]; then
		pwd=""
	fi
	
	# PROMPT_COMMAND='__git_ps1 "\n$(tput setaf 170)$MSYSTEM $(tput setaf 34)\u@\h\n$(tput setaf 15)PWD: $(tput setaf 111)\w$(tput sgr0)" "\n\\\$ " "\n$(tput setaf 15)GIT:$(tput sgr0) %s$(tput sgr0)"'
	#
	# 
	# Default Command Prompt examples:
	# PROMPT_COMMAND='__bash_ps1 "%u%s%h $(tput setaf 170)$MSYSTEM %w%$ "'			# <---- Equivalent to the next line:
	# PROMPT_COMMAND='__bash_ps1 "%u%s%h $(tput setaf 170)$MSYSTEM %w%$ " "(%s)"'
	#
	# Example of my custom prompt, as shown in the first line of this comment:
	# PROMPT_COMMAND='__bash_ps1 "\n$(tput setaf 170)$MSYSTEM " "" "%u%s%h\n$(tput setaf 15)PWD: %w%$" "\n$(tput setaf 15)GIT: $(tput sgr0) %s$(tput sgr0)"'
	#
	# The goal, then, is to have __bash_ps1 act much like __git_ps1 in order to build up your custom shell prompt.
	
	return;
}

PROMPT_COMMAND='__git_ps1 "$(tput setaf 2)\u@\h $(tput setaf 5)$MSYSTEM $(tput setaf 3)\w$(tput sgr0)" "\n\\\$ "'

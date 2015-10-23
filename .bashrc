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
	local show_git_prompt 
	local git_printf_format=" (%s)"
	local ps1pc_start=""
	local ps1pc_end=""
	local printf_format="%s"
	
	case "$#" in
		0|1|2)	printf_format="${1:-$printf_format}"
			git_printf_format="${2:- (%s)}"
		;;
		*)		ps1pc_start="$1"
			ps1pc_end="$2"
			printf_format="${3:-$printf_format}"
			git_printf_format="${4:-$git_printf_format}"
		;;
	esac
	
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
	# __bash_ps1 {1}:ps1pc_start {2}:ps1pc_end {3}:print_format [{4}:git_print_format]
	# __bash_ps1 {1}:print_format [{2}:git_print_format]
	# 
	# Default Command Prompt examples:
	# PROMPT_COMMAND='__bash_ps1 "%u%z%h $(tput setaf 170)$MSYSTEM %w%p "'			# <---- Equivalent to the next line:
	# PROMPT_COMMAND='__bash_ps1 "%u%z%h $(tput setaf 170)$MSYSTEM %w%p " "(%s)"'
	#
	# Example of my custom prompt, as shown in the first line of this comment:
	# PROMPT_COMMAND='__bash_ps1 "\n$(tput setaf 170)$MSYSTEM " "" "%u%z%h\n$(tput setaf 15)PWD: %w%p" "\n$(tput setaf 15)GIT: $(tput sgr0) %s$(tput sgr0)"'
	#
	# The goal, then, is to have __bash_ps1 act much like __git_ps1 in order to build up your custom shell prompt.
	
	# This block should be removed before committing to 'master', as it's just a sanity check that the various prompt parts are being
	# grabbed correctly from the command line arguments to __bash_ps1.
	if [ "$#" -ge "3" ]; then
		echo "Three or more arguments."
		echo "ps1pc_start=$ps1pc_start"
		echo "ps1pc_end=$ps1pc_end"
		echo "printf_format=$printf_format"
		echo "git_printf_format=$git_printf_format"
	elif [ "$#" -gt "0" ] && [ "$#" -lt "3" ]; then
		echo "Less than 3 arguments, but at least 1."
		echo "ps1pc_start=$ps1pc_start"
		echo "ps1pc_end=$ps1pc_end"
		echo "printf_format=$printf_format"
		echo "git_printf_format=$git_printf_format"
	else
		echo "Zero arguments"
		echo "ps1pc_start=$ps1pc_start"
		echo "ps1pc_end=$ps1pc_end"
		echo "printf_format=$printf_format"
		echo "git_printf_format=$git_printf_format"
	fi
	
	# ANOTHER DEBUG STRING
	echo "prompt: $ps1pc_start$printf_format$git_printf_format$ps1pc_end"
	# __bash_ps1 "\$(tput setaf 170)\$MSYSTEM " "" "%u%z%h\\n\$(tput setaf 15)PWD: %w%v%p" "\\n\$(tput setaf 15)GIT: %s"
	
	
	# Need to parse the bash prompt format string (printf_format)
	echo -e "\nReplacing %u in \$printf_format:"
	printf_format2="${printf_format/\%u/\$\{user_color\}\$\{user\}}"
	echo "$printf_format2"
	
	echo -e "\nReplacing %z in \$printf_format:"
	printf_format2="${printf_format2/\%z/\$\{sep_color\}\$\{sep\}}"
	echo "$printf_format2"
	
	echo -e "\nReplacing %h in \$printf_format:"
	printf_format2="${printf_format2/\%h/\$\{host_color\}\$\{host\}}"
	echo "$printf_format2"
	
	echo -e "\nReplacing %w in \$printf_format:"
	printf_format2="${printf_format2/\%w/\$\{pwd_color\}\$\{pwd\}}"
	echo "$printf_format2"
	
	if [[ -n "$git_printf_format" ]]; then
		echo -e "\n\$git_printf_format is defined. Splitting prompt into respective parts for call to __git_ps1."
		ps1pc_end="\${prompt_delimiter_color}\${prompt_delimiter}"
		printf_format2="${printf_format2/\%p/}"
		printf_format2="${printf_format2/\%v/}"
		echo "'__git_ps1 \"\${ps1pc_start}\" \"\${ps1pc_end}\" \"\${printf_format}\" \"\${git_printf_format}\"'"
		echo "\$ps1pc_start: ${ps1pc_start}"
		echo "\$printf_format: ${printf_format2}"
		echo "\$ps1pc_end: ${ps1pc_end}"
		echo "__git_ps1: ${ps1pc_start}${printf_format2}${git_printf_format}${ps1pc_end}"
	else
		echo -e "\n$git_printf_format not defined. Replacing %v with an empty string and expanding %p."
		printf_format="${printf_format2/\%p/\$\{prompt_delimiter_color\}\$\{prompt_delimiter\}}"
		printf_format="${printf_format2/\%v/}"
		echo "$printf_format2"
	fi
	
	local bash_ps1_user="${user_color}${user}"
	local bash_ps1_sep="${sep_color}${sep}"
	local bash_ps1_host="${host_color}${host}"
	local bash_ps1_pwd="${pwd_color}${pwd}"
	local bash_ps1_delimiter="${prompt_delimiter_color}${prompt_delimiter}"
	
	#printf_format="${printf_format/\%u/${bash_ps1_user}/}"
	#printf_format="${printf_format/\%z/${bash_ps1_sep}/}"
	#printf_format="${printf_format/\%h/${bash_ps1_host}/}"
	#printf_format="${printf_format/\%w/${bash_ps1_pwd}/}"	
	#printf_format="${printf_format/\%p/${bash_ps1_delimiter}/}"
	
	# OK, so, at some point, we have to split the printf_format (which is the format string to be used for the bash prompt)
	# at the point where the git prompt should be displayed (denoted by %v in the bash printf_format format string).
	# Then, we need to make the necessary substitutions for the various "format parameters" for user, host, etc.
	# in the bash prompt format string(s). These tokens could appear before or after the git prompt.
	local after_git_prompt="${printf_format##*\%v}"
	echo "after_git_prompt = ${after_git_prompt}"
	before_git_prompt="${printf_format%\%v*}"
	echo "before_git_prompt = ${before_git_prompt}"
	echo "printf_format: ${printf_format}"
	
	return $exit;
}

PROMPT_COMMAND='__git_ps1 "$(tput setaf 2)\u@\h $(tput setaf 5)$MSYSTEM $(tput setaf 3)\w$(tput sgr0)" "\n\\\$ "'

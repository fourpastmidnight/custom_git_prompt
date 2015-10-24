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
BASH_PS1_SHOW_COLORIZED_PROMPT=1

#BASH_PS1_USERNAME_COLOR="$(tput setaf 2)"
#BASH_PS1_HOSTNAME_COLOR="$(tput setaf 2)"
#BASH_PS1_USER_HOST_SEPARATOR_COLOR="$(tput setaf 2)"
#BASH_PS1_PWD_COLOR="$(tput setaf 3)"
#BASH_PS1_PROMPT_COLOR="$(tput sgr0)"

#BASH_PS1_USERNAME='\u'
#BASH_PS1_HOSTNAME='\h'
#BASH_PS1_USER_HOST_SEPARATOR="@"
#BASH_PS1_PWD="\n$(tput setaf 15)PWD: $(tput sgr0)\\w"

#BASH_PS1_USER_HOST_SEPARATOR="@"
#BASH_PS1_PROMPT="\n\\\$ "
#BASH_PS1_FORMAT_STRING=

# Fixup git-bash in non login env
shopt -q login_shell || . /etc/profile.d/git-prompt.sh

function __bash_ps1_is_declared()
{
	case $(declare | grep -c "$1=") in
		0)		return 1;;
		*)		return 0;;
	esac
}

function __bash_ps1_colorize_promptstring()
{
	local user_host_color="$(tput setaf 2)"
	local pwd_color="$(tput setaf 3)"
	local prompt_color="$(tput sgr0)"
	
	# if any bash prompt color variable is not declared, then use the default color.
	# else, if it is declared and is null, or it is defined but empty, then use $(tput sgr0), otherwise, use the given color.
	#
	# Additionally, you'll notice that we're trying to preserve any other colorizing that may be occurring
	# within any of the prompt variables. For example, if you specify BASH_PS1_USERNAME="$(tput setaf 14)Hello! \u"
	# and subsequently also set BASH_PS1_USERNAME_COLOR="$(tput setaf 2)", then you would expect that
	# Hello! would still by displayed in cyan while the username would be displayed in green.
	if ! __bash_ps1_is_declared BASH_PS1_USERNAME_COLOR; then
		u="${u/\\u/$user_host_color\\u}"
	else
		u="${u/\\u/${BASH_PS1_USERNAME_COLOR:-$(tput sgr0)}\\u}"
	fi
	
	# TL;DR : Don't need to "preserve" color formatting for the username/hostname separator character.
	#
	# Since this is meant to be a separator character (or characters) between the
	# username and hostname, no "color preservation" needs to be done.
	# If the user wants a highly customized, colorized username/hostname separator,
	# they would simply set BASH_PS1_USER_HOST_SEPARATOR to some complex string embedded
	# with color info. Additionalliy, BASH_PS1_USER_HOST_SEPARATOR_COLOR provides the overall
	# base color for the username/hostname separator.
	if ! __bash_ps1_is_declared BASH_PS1_USER_HOST_SEPARATOR_COLOR; then
		z="$user_host_color$z"
	else
		z="${BASH_PS1_USER_HOST_SEPARATOR_COLOR-$(tput sgr0)}$z"
	fi
	
	if ! __bash_ps1_is_declared BASH_PS1_HOSTNAME_COLOR; then
		h="${h/\\h/$user_host_color\\h}"
	else
		h="${h/\\h/${BASH_PS1_HOSTNAME_COLOR:-$(tput sgr0)}\\h}"
	fi
	
	if ! __bash_ps1_is_declared BASH_PS1_PWD_COLOR; then
		w="${w/\\w/$pwd_color\\w}"
	else
		w="${w/\\w/${BASH_PS1_PWD_COLOR:-$(tput sgr0)}\\w}"
	fi
	
	p="${BASH_PS1_PROMPT_COLOR-$prompt_color}$p$(tput sgr0)"
}

function __bash_ps1_printf_format_contains()
{
	case $(echo "$1" | grep -c $2) in
		0)		return 1 ;;
		*)		return 0 ;;
	esac
}

function __bash_ps1_is_function_defined()
{
	declare -Ff "$1" >/dev/null
}

function __bash_ps1()
{
	# Preserve exit status.
	local exit=$?
	
	local git_printf_format=" (%s)"
	local bash_ps1pc_start=""
	local bash_ps1pc_end=""
	local bash_printf_format="%u%z%h%w%v%p"
	local git_printf_format
	
	case "$#" in
		0|1|2)		bash_printf_format="${1:-$printf_format}"
					git_printf_format="$2"
		;;
		*)			bash_ps1pc_start="${1:-$ps1pc_start}"
					bash_ps1pc_end="${2:-$ps1pc_end}"
					bash_printf_format="${3:-$printf_format}"
					git_printf_format="${4:-}"
		;;
	esac
	
	#echo -e "\n"
	#echo "bash_printf_format = $bash_printf_format$(tput sgr0)"
	#echo "bash_ps1pc_start   = $bash_ps1pc_start$(tput sgr0)"
	#echo "bash_ps1pc_end     = $bash_ps1pc_end$(tput sgr0)"
	#echo -e "\n"
	
	# from git-prompt, local vars in __git_ps1 that are part of the git prompt format string
	# I just wanted to list them and document them here because I want to use a similar strategy for the bash prompt.
	#local r=""		# show rebase/merge state (e.g. |REBASE 1/20 )
	#local b=""		# current branch name
	#local step=""	# when rebasing or merging, shows what merge/rebase conflict you're currently working on
	#local total=""  # when rebasing or merging, shows the total number of conflicts in the rebase or merge in progress.
	
	#local w=""  # working directory state; shows unstaged (*) and untracked (%) files glyphs
	#local i=""  # git index state; shows whether the index represents the repo's initial commit (#) or if there are staged files (+)
	#local s=""  # git stash state; if the repo contains stashes, this variable gets set to $.
	#local u=""  # shows unstaged (*) files
	#local c=""  # if you're in a bare git repo, then this displays "BARE:" prior to the branch name; e.g. BARE:master
	#local p=""  # git upstream info; shows if the repo is ahead or behind of the remote and optionally how many commits ahead/behind.
	
	#local z=" " # separator between git branch info and git repo dirty status info
	#local f="$w$i$s$u"	# This is the format string for the repository dirty status info
	#local gitstring="$c$b${f:+$z$f}$r$p"   # the entire git string; if $f is defined, the use $z$f instead.
	
	# Setup the default bashstring variable substitutions.
	# This should result, by default, with a prompt like:  "user@host ~\n$ "
	local u="${BASH_PS1_USERNAME:-\\u}"
	#echo "Username: $u$(tput sgr0)"
	local z="${BASH_PS1_USER_HOST_SEPARATOR:-@}"
	#echo "Separator: $z$(tput sgr0)"
	local h="${BASH_PS1_HOSTNAME:-\\h}"
	#echo "Hostname: $h$(tput sgr0)"
	local w="${BASH_PS1_PWD:- \\w}"
	#echo "PWD: $w$(tput sgr0)"
	local p="$bash_ps1pc_end${BASH_PS1_PROMPT:-\n\\\$ }"
	#echo "\$ = $p$(tput sgr0)"
	
	#echo -e "\n"
	
	# Set the initial bash string, defaulted to "\u@\h \w\n\\\$"
	# The "format specifiers" have the following interpretation:
	#
	#   %u :  Username. Will get substituted to \u or the value provided in BASH_PS1_USERNAME
	#   %z :  Username/hostname separator. Will get substituted to @ or the value provided in BASH_PS1_USER_HOST_SEPARATOR
	#   %h :  Hostname. Will get substituted to \h or the value provided in BASH_PS1_HOSTNAME
	#   %w :  Present working directory. Will get substituted to \w or the value provided in BASH_PS1_PWD
	#   %v :  Version Control Prompt. Place this format specifier where ever in your bash prompt you want 
	#         your source code version control prompt to be displayed. This specifier will be replaced by,
	#         executing __git_ps1 from git-prompt.sh (or your local sourced version), for example, when git
	#		  is your source code control management system.
	#   %p :  Prompt delimiter. Will get substituted to "\n\\\$ " ($ on a new line) or the value provided in BASH_PS1_PROMPT
	#
	# If you actually want %[uzhwvp] to display in your bash prompt for some reason, then simply escape the % by appending %.
	# E.g. %%u would allow an actual "%u" to be displayed in your bash prompt.
	local bashstring="${BASH_PS1_FORMAT_STRING:-%u%z%h%w%v%p}"
	
	#echo "Current bashstring: $bashstring"
	
	# If the user indicates they want to see a colorized prompt (either by declaring the variable
	# but leaving it unset or setting its value to anything greater than 0), then colorize the prompt string.
	if [ ${BASH_PS1_SHOW_COLORIZED_PROMPT:-1} -gt 0 ]; then
		__bash_ps1_colorize_promptstring
	fi
	
	# If the user decides not to show some components of the default bash prompt,
	# then set the placeholder variable to the empty string.
	if [ -z "${BASH_PS1_SHOW_USERNAME}" ]; then
		u=""
	fi
	
	if [ -z "${BASH_PS1_SHOW_HOSTNAME}" ]; then
		h=""
	fi
	
	if [ -z "$u" ] && [ -z "$h" ]; then
		z=""
	fi
	
	if [ -z "${BASH_PS1_SHOW_PWD}" ]; then
		w=""
	fi
	
	# Now that we know what the user wants to display, (via the BASH_PS1_SHOW_XXXX variables),
	# substitute the "format specifiers" %u, %h, etc. with $u, $h, etc.
	# I couldn't use the exact same method as __git_ps1 because the end user has flexility to
	# display their bash prompt components in any order they choose, hence this more awkward
	# substitution syntax.
	#
	# NOTE: in preparation for calling your vcs prompt formatter, i.e. __git_ps1, don't substitute %v.
	bashstring="${bashstring/\%u/$u}"
	#echo $bashstring
	bashstring="${bashstring/\%z/$z}"
	#echo $bashstring
	bashstring="${bashstring/\%h/$h}"
	#echo $bashstring
	bashstring="${bashstring/\%w/$w}"
	#echo $bashstring
	bashstring="${bashstring/\%p/$p}"
	#echo $bashstring
	
	if __bash_ps1_is_function_defined __git_ps1; then
		# Split the bashstring on %v and pass the part before %v to the ps1pc_start param
		# and the part after %v to the ps1pc_end param.
		local __git_ps1pc_end="${bashstring##*\%v}"
		local __git_ps1pc_start="${bash_ps1pc_start}${bashstring%\%v*}"
		
		#echo "__git_ps1pc_start = $__git_ps1pc_start$(tput sgr0)"
		#echo "__git_ps1pc_end = $__git_ps1pc_end$(tput sgr0)"
	
		# If a custom gitstring has been defined in $git_printf_format, then pass that to __git_ps1, too.
		#bashstring="__git_ps1 \"$__git_ps1pc_start\" \"$__git_ps1pc_end\" \"$git_printf_format\""
		#echo "PROMPT_COMMAND = $bashstring"
		#echo "PS1 = $PS1"
	fi
	
	#echo "String to be passed to PROMPT_COMMAND: $bashstring"
	
	__git_ps1 "$__git_ps1pc_start" "$__git_ps1pc_end" "${git_printf_format}"
	#echo "PS1 = $PS1"
}

PROMPT_COMMAND='__bash_ps1 "${BASH_PS1_FORMAT_STRING-}" "\n$(tput setaf 15)GIT:$(tput sgr0) %s$(tput sgr0)"'

# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples
export PATH=$PATH:~/bin
export EDITOR=vim
# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# don't put duplicate lines in the history. See bash(1) for more options
# don't overwrite GNU Midnight Commander's setting of `ignorespace'.
HISTCONTROL=$HISTCONTROL${HISTCONTROL+,}ignoredups
# ... or force ignoredups and ignorespace
HISTCONTROL=ignoreboth

# ignore relatively meaningless commands.
export HISTIGNORE="fg*:bg*:history*"

# store a lot of commands
export HISTSIZE=100000
export HISTFILESIZE=100000

# append to the history file, don't overwrite it
shopt -s histappend

# store multiline commands as single entries in history file
shopt -s cmdhist

# allow re-editing of a history command substitution, if the previous run failed
shopt -s histreedit

# correct spelling mistakes
shopt -s cdspell

# look at variables that might hold directory paths
# shopt -s cdable_vars

# tab-completion of hostnames after @
shopt -s hostcomplete

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

function __git_prompt()
{
        x=$(git branch --no-color 2>/dev/null | grep '^*'| awk '{print ($2)}') || return
        (test -z "$x" && echo "") || echo git:$x: 
        #echo $x
}

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]  \$ '
    #PS1="\d \t: \u@\H: \w "
 
else
    #PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
    PS1="\d \t: [\u@\H:] \\[\e[1;31m\]\$(__git_prompt)\[\e[0m\]\[\033[01;34m\]\w\[\033[00m\]" 
    PS1=$PS1' \$ '
 
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\H: \w\a\]$PS1"
    #PS1="\d \t: [\u@\H:] \[\033[01;34m\]\w\[\033[00m\] \$ "
 
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# some more ls aliases
#alias ll='ls -l'
#alias la='ls -A'
#alias l='ls -CF'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi

# Check for local mail
MAILCHECK=30
MAILPATH=~/Maildir/new?"You have a new mail."
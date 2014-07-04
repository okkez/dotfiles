# -*- sh -*-
# users generic .zshrc file for zsh(1)

## Environment variable configuration
#
# LANG
#
export LANG=ja_JP.UTF-8

# 8bit settings
setopt print_eightbit

## Default shell configuration
#
# set prompt
#
autoload colors
colors

# case ${UID} in
# 0)
#     PROMPT="%B%{${fg[red]}%}%/#%{${reset_color}%}%b "
#     PROMPT2="%B%{${fg[red]}%}%_#%{${reset_color}%}%b "
#     SPROMPT="%B%{${fg[red]}%}%r is correct? [n,y,a,e]:%{${reset_color}%}%b "
#     [ -n "${REMOTEHOST}${SSH_CONNECTION}" ] &&
#         PROMPT="%{${fg[cyan]}%}$(echo ${HOST%%.*} | tr '[a-z]' '[A-Z]') ${PROMPT}"
#     ;;
# *)
#     PROMPT="%{${fg[red]}%}%/$%{${reset_color}%} "
#     PROMPT2="%{${fg[red]}%}%_$%{${reset_color}%} "
#     SPROMPT="%{${fg[red]}%}%r is correct? [n,y,a,e]:%{${reset_color}%} "
#     [ -n "${REMOTEHOST}${SSH_CONNECTION}" ] &&
#         PROMPT="%{${fg[cyan]}%}$(echo ${HOST%%.*} | tr '[a-z]' '[A-Z]') ${PROMPT}"
#     ;;
# esac

case ${UID} in
    0)
	PROMPT="%B%{${fg[red]}%}#%{${reset_color}%}%b "
	PROMPT2="%B%{${fg[red]}%}%_#%{${reset_color}%}%b "
	RPROMPT="[%/]"
	SPROMPT="%B%{${fg[red]}%}%r is correct? [n,y,a,e]:%{${reset_color}%}%b "
	[ -n "${REMOTEHOST}${SSH_CONNECTION}" ] &&
          PROMPT="%{${fg[cyan]}%}$(echo ${HOST%%.*} | tr '[a-z]' '[A-Z]') ${PROMPT}"
	;;
    *)
	PROMPT="%{${fg[red]}%}$%{${reset_color}%} "
	PROMPT2="%{${fg[red]}%}%_$%{${reset_color}%} "
	RPROMPT="[%/]"
	SPROMPT="%{${fg[red]}%}%r is correct? [n,y,a,e]:%{${reset_color}%} "
	[ -n "${REMOTEHOST}${SSH_CONNECTION}" ] &&
          PROMPT="%{${fg[cyan]}%}$(echo ${HOST%%.*} | tr '[a-z]' '[A-Z]') ${PROMPT}"
	;;
esac

DEFAULT_PROMPT=$PROMPT
DEFAULT_RPROMPT=$RPROMPT
 
# auto change directory
#
setopt auto_cd

# auto directory pushd that you can get dirs list by cd -[tab]
#
setopt auto_pushd

# command correct edition before each completion attempt
#
setopt correct

# compacked complete list display
#
setopt list_packed

# no remove postfix slash of command line
#
setopt noautoremoveslash

# no beep sound when complete list displayed
#
setopt nolistbeep

# numerical sort
#
setopt numeric_glob_sort

# delete rprompt after exec command
#
setopt transient_rprompt

## Keybind configuration
#
# emacs like keybind (e.x. Ctrl-a goes to head of a line and Ctrl-e goes
#   to end of it)
#
bindkey -e

# historical backward/forward search with linehead string binded to ^P/^N
#
autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^p" history-beginning-search-backward-end
bindkey "^n" history-beginning-search-forward-end
bindkey "\\ep" history-beginning-search-backward-end
bindkey "\\en" history-beginning-search-forward-end


## Command history configuration
#
HISTFILE=~/.zsh_history
HISTSIZE=10000000
SAVEHIST=10000000
setopt hist_no_store        # ignore history command
setopt hist_ignore_dups     # ignore duplication command history list
setopt hist_ignore_all_dups
setopt hist_reduce_blanks   # reduce blanks
setopt hist_ignore_space    # ignore the command starts with blanks
setopt share_history        # share command history data
setopt extended_history     # save timestamp and elapsed time to history file
setopt hist_save_no_dups
setopt hist_find_no_dups


## Completion configuration
#
fpath=(~/.zsh/functions/Completion ${fpath})
autoload -U compinit
compinit

zstyle ':completion:*' format '%B%d%b'
zstyle ':completion:*' group-name ''
zstyle ':completion:*:default' menu select=2
zstyle ':completion:*:default' list-colors ""
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
zstyle ':completion:*' use-cache yes

setopt complete_in_word
setopt glob_complete
setopt hist_expand
setopt no_beep
setopt numeric_glob_sort

## expansion
#
setopt magic_equal_subst    # expand filename after equal mark.


## zsh editor
#
autoload zed


## Prediction configuration
#
#autoload predict-on
#predict-off

## cdr - directory history
#
autoload -Uz chpwd_recent_dirs cdr add-zsh-hook
add-zsh-hook chpwd chpwd_recent_dirs
zstyle ':chpwd:*' recent-dirs-max 5000
zstyle ':chpwd:*' recent-dirs-default yes
zstyle ':completion:*' recent-dirs-insert both

## Alias configuration
#
# expand aliases before completing
#
setopt complete_aliases     # aliased ls needs if file/dir completions work

alias where="command -v"
alias j="jobs -l"

case "${OSTYPE}" in
    freebsd*|darwin*)
        alias ls=" ls -G -w"
        ;;
    linux*)
        alias ls=" ls --color"
        ;;
    solaris*)
        alias ls=" gls --color"
esac

alias l=" ls"
alias la=" ls -a"
alias lf=" ls -F"
alias ll=" ls -alh"

alias du="du -h"
alias df="df -h"

alias su="su -l"

case "${OSTYPE}" in
darwin*)
    alias updateports="sudo port selfupdate; sudo port outdated"
    alias portupgrade="sudo port upgrade installed"
    ;;
freebsd*)
    case ${UID} in
    0)
        updateports()
        {
            if [ -f /usr/ports/.portsnap.INDEX ]
            then
                portsnap fetch update
            else
                portsnap fetch extract update
            fi
            (cd /usr/ports/; make index)

            portversion -v -l \<
        }
        alias appsupgrade='pkgdb -F && BATCH=YES NO_CHECKSUM=YES portupgrade -a'
        ;;
    esac
    ;;
esac


## terminal configuration
#
unset LSCOLORS
case "${TERM}" in
xterm)
    export TERM=xterm-color
    ;;
kterm)
    export TERM=kterm-color
    # set BackSpace control character
    stty erase
    ;;
cons25)
    unset LANG
    export LSCOLORS=ExFxCxdxBxegedabagacad
    export LS_COLORS='di=01;34:ln=01;35:so=01;32:ex=01;31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
    zstyle ':completion:*' list-colors \
        'di=;34;1' 'ln=;35;1' 'so=;32;1' 'ex=31;1' 'bd=46;34' 'cd=43;34'
    ;;
esac

# set terminal title including current directory
#
case "${TERM}" in
kterm*|xterm*)
    precmd() {
        echo -ne "\033]0;${USER}@${HOST%%.*}:${PWD}\007"
    }
    export LSCOLORS=exfxcxdxbxegedabagacad
    export LS_COLORS='di=34:ln=35:so=32:pi=33:ex=31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
    zstyle ':completion:*' list-colors \
        'di=34' 'ln=35' 'so=32' 'ex=31' 'bd=46;34' 'cd=43;34'
    ;;
esac


## load user .zshrc configuration file
#
[ -f ~/dotfiles/zshrc.mine ] && source ~/dotfiles/zshrc.mine

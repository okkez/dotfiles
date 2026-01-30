# External Tool Integrations

# Terminal Configuration
unset LSCOLORS

case "${TERM}" in
kterm*|xterm*|alacritty)
    add-zsh-hook precmd set_term_title
    export LSCOLORS=exfxcxdxbxegedabagacad
    export LS_COLORS='di=34:ln=35:so=32:pi=33:ex=31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
    zstyle ':completion:*' list-colors \
        'di=34' 'ln=35' 'so=32' 'ex=31' 'bd=46;34' 'cd=43;34'
    ;;
esac

# virtualenvwrapper
if [[ -f /usr/share/virtualenvwrapper/virtualenvwrapper.sh ]]; then
    source /usr/share/virtualenvwrapper/virtualenvwrapper.sh
fi

# dircolors
DIRCOLORS=$HOME/src/dircolors-solarized/dircolors.ansi-universal
test -s $DIRCOLORS && eval $(dircolors $DIRCOLORS)

# GUIX Profile
if [[ -f "${GUIX_PROFILE}/etc/profile" ]]; then
    . ${GUIX_PROFILE}/etc/profile
fi

# REPORTTIME for long-running commands
REPORTTIME=10

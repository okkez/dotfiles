# Aliases

alias where="command -v"
alias j="jobs -l"

# ls aliases
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

# lsd aliases
alias l=" lsd"
alias la=" lsd -a"
alias lf=" lsd -F"
alias ll=" lsd -alh"

# System utilities
alias du="du -h"
alias df="df -h"
alias su="su -l"

# Development tools
alias gosh="rlwrap gosh"
alias g="goruby -rirb -e'IRB.start'"
alias ec=emacsclient
alias ecc="ec -c"
alias ecn="ec -nw"

# mise/asdf
alias asdf=mise

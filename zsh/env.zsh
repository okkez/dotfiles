# Environment Variables

export LANG=ja_JP.UTF-8

# PATH Management
typeset -U path
path=(
    $HOME/bin
    $HOME/.local/bin
    $HOME/.local/share/mise/shims
    $HOME/.cargo/bin
    $GOPATH/bin
    $PNPM_HOME
    "${KREW_ROOT:-$HOME/.krew}/bin"
    $path
)

# Tool Configuration
export RUBYLIB="${RUBYLIB}":/usr/local/lib/site_ruby
export HREF_DATADIR=~/.href
export EDITOR=vim
export GOPATH=$HOME/go
export RUBY_CONFIGURE_OPTS="--enable-shared --disable-install-doc"
export PNPM_HOME="/home/kenji/.local/share/pnpm"

# virtualenvwrapper
export VIRTUALENVWRAPPER_PYTHON=/usr/bin/python
export WORKON_HOME=$HOME/.virtualenvs
export VIRTUAL_ENV_DISABLE_PROMPT=1

# GUIX
GUIX_PROFILE="/home/kenji/.guix-profile"

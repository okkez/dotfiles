# Completion Configuration

# Setup completion directories
mkdir -p ~/.zsh/completions
fpath=(~/.zsh/functions/Completion ~/.zsh/completions $fpath)

# Initialize completion system
autoload bashcompinit && bashcompinit
autoload -Uz compinit && compinit

# Completion styling
zstyle ':completion:*' format '%B%d%b'
zstyle ':completion:*' group-name ''
zstyle ':completion:*:default' menu select=2
zstyle ':completion:*:default' list-colors ""
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
zstyle ':completion:*' use-cache yes

# Tool-specific completions

# Rust
if [[ -f $HOME/.cargo/bin/rustup ]]; then
    [[ ! -f ~/.zsh/completions/_rustup ]] && rustup completions zsh > ~/.zsh/completions/_rustup
    test ! -f ~/.zsh/completions/_cargo && \
        ln -sf $(realpath $(dirname $(rustup which cargo))/../share/zsh/site-functions/_cargo) ~/.zsh/completions/_cargo
fi

# gh
[[ ! -f ~/.zsh/completions/_gh ]] && type gh > /dev/null 2>&1 && gh completion -s zsh > ~/.zsh/completions/_gh

# kubectl (lazy load)
if type kubectl > /dev/null; then
    function kubectl() {
        unfunction $0
        source <(kubectl completion zsh)
        $0 "$@"
    }
fi

# aws
complete -C 'aws_completer' aws

# terraform
complete -o nospace -C $(mise which terraform) terraform

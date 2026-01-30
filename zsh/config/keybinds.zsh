# Keybinds

# emacs like keybind
bindkey -e

# historical backward/forward search with linehead string binded to ^P/^N
autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^p" history-beginning-search-backward-end
bindkey "^n" history-beginning-search-forward-end
bindkey "\\ep" history-beginning-search-backward-end
bindkey "\\en" history-beginning-search-forward-end

# From zshrc.mine
bindkey "^?" backward-delete-char
bindkey "[3~" backward-delete-char

# Disable suspend on Ctrl-S
if [[ -t 0 ]]; then
  stty stop undef
  stty start undef
fi

# zabrze integration
eval "$(zabrze init --bind-keys)"
zle -N __zabrze::expand-or-complete
function __zabrze::expand-or-complete() {
    zle __zabrze::expand
    zle expand-or-complete
}
bindkey "^I" __zabrze::expand-or-complete

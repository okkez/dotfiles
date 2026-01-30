# Functions

function say() {
  echo "(SayText \"$*\")"| festival --pipe
}

function reload() {
  source ~/.zshrc
}

function set_term_title() {
    echo -ne "\033]0;${USER}@${HOST%%.*}:${PWD}\007"
}

# Load zsh editor
autoload zed

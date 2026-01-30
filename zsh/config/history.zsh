# Command History Configuration

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

# cdr - directory history
autoload -Uz chpwd_recent_dirs cdr add-zsh-hook
add-zsh-hook chpwd chpwd_recent_dirs
zstyle ':chpwd:*' recent-dirs-max 5000
zstyle ':chpwd:*' recent-dirs-default yes
zstyle ':completion:*' recent-dirs-insert both

# CLH (Command Line History) integration
function clh-add-history() {
    command=${1}
    test ${#command} -lt 4 && return
    echo -n ${command} | grep -E "^ " && return
    echo -n ${command} | grep -E "^ll? " && return

    (
        setopt LOCAL_OPTIONS NO_NOTIFY NO_MONITOR
        curl --silent -X POST \
             --user ${CLH_USER}:${CLH_PASS} \
             -H "Content-Type: application/x-www-form-urlencoded" \
             --data-urlencode "hostname=$(hostname)" \
             --data-urlencode "working_directory=${PWD}" \
             --data-urlencode "command=${command}" \
             https://clh.okkez.net/ >& /dev/null &
    )
}
add-zsh-hook preexec clh-add-history

function clh-search-history() {
    BUFFER=$(curl --silent --user ${CLH_USER}:${CLH_PASS}  "https://clh.okkez.net/?pwd=${PWD}" | \
                 jaq -r 'map("https://clh.okkez.net/" + (.id | tostring) + "\t" + .command) | join("\n")' | \
                 sk --layout=reverse --query "$LBUFFER" --delimiter '\t' --with-nth 2 --nth 1 \
                    --bind 'ctrl-k:execute-silent(echo {} | cut -f1 | xargs -n 1 curl --user ${CLH_USER}:${CLH_PASS} --silent -o /dev/null -X DELETE)' | \
                 cut -f 2)
    CURSOR=$#BUFFER
    zle clear-screen
}
zle -N clh-search-history
bindkey '^s' clh-search-history

function clh-search-history-all() {
    BUFFER=$(curl --silent --user ${CLH_USER}:${CLH_PASS} https://clh.okkez.net/ | \
                 jaq -r 'map("https://clh.okkez.net/" + (.id | tostring) + "\t" + .command) | join("\n")' |
                 sk --layout=reverse --query "$LBUFFER" --delimiter '\t' --with-nth 2 --nth 1 \
                    --bind 'ctrl-k:execute-silent(echo {} | cut -f1 | xargs -n 1 curl --user ${CLH_USER}:${CLH_PASS} --silent -o /dev/null -X DELETE)' | \
                 cut -f 2)
    CURSOR=$#BUFFER
    zle clear-screen
}
zle -N clh-search-history-all
bindkey '^t' clh-search-history-all

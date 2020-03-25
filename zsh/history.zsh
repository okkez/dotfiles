function clh-add-history() {
    command=${1}
    test ${#command} -lt 4 && return
    echo -n ${command} | grep -E "^ " && return

    # 何も表示させないためにサブシェルで POST する
    (
        setopt LOCAL_OPTIONS NO_NOTIFY NO_MONITOR
        curl --silent -X POST \
             -H "Content-Type: application/x-www-form-urlencoded" \
             --data-urlencode "hostname=$(hostname)" \
             --data-urlencode "working_directory=${PWD}" \
             --data-urlencode "command=${command}" \
             https://clh.okkez.net/ >& /dev/null &
    )
}
add-zsh-hook preexec clh-add-history

function clh-search-history() {
    BUFFER=$(curl --silent https://clh.okkez.net/?pwd=${PWD} | jq -r 'map(.command) | join("\n")' | sk --layout=reverse --query "$LBUFFER")
    CURSOR=$#BUFFER
    zle clear-screen
}
zle -N clh-search-history
bindkey '^s' clh-search-history

function clh-search-history-all() {
    BUFFER=$(curl --silent https://clh.okkez.net/ | jq -r 'map(.command) | join("\n")' | sk --layout=reverse --query "$LBUFFER")
    CURSOR=$#BUFFER
    zle clear-screen
}
zle -N clh-search-history-all
bindkey '^t' clh-search-history-all

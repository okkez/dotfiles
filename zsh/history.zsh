function clh-add-history() {
    command=${1}
    test ${#command} -lt 4 && return
    echo -n ${command} | grep -E "^ " && return
    echo -n ${command} | grep -E "^ll? " && return

    # 何も表示させないためにサブシェルで POST する
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
                 jq -r 'map("https://clh.okkez.net/" + (.id | tostring) + "\t" + .command) | join("\n")' | \
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
                 jq -r 'map("https://clh.okkez.net/" + (.id | tostring) + "\t" + .command) | join("\n")' |
                 sk --layout=reverse --query "$LBUFFER" --delimiter '\t' --with-nth 2 --nth 1 \
                    --bind 'ctrl-k:execute-silent(echo {} | cut -f1 | xargs -n 1 curl --user ${CLH_USER}:${CLH_PASS} --silent -o /dev/null -X DELETE)' | \
                 cut -f 2)
    CURSOR=$#BUFFER
    zle clear-screen
}
zle -N clh-search-history-all
bindkey '^t' clh-search-history-all

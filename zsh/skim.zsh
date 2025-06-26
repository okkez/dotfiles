export SKIM_DEFAULT_COMMAND="fdfind --type f || git ls-tree -r --name-only HEAD || rg --files || find . -type f"
export SKIM_DEFAULT_OPTIONS="--ansi --prompt='Q> '"

function skim-select-history() {
    BUFFER=$(history -n 1 | sk --layout=reverse --tac --query "$LBUFFER")
    CURSOR=$#BUFFER
    zle clear-screen
}
zle -N skim-select-history
bindkey '^r' skim-select-history

function skim-cdr () {
    local selected_dir=$(cdr -l | awk '{ print $2 }' | sk --layout=reverse)
    if [ -n "$selected_dir" ]; then
        BUFFER="cd ${selected_dir}"
        zle accept-line
    fi
    zle clear-screen
}
zle -N skim-cdr
bindkey '^@' skim-cdr

function skim-ghq () {
    local repo=$(ghq list | sk --layout=reverse --query "$LBUFFER")
    if [ -n "$repo" ]; then
        repo=$(ghq list --full-path --exact $repo)
        BUFFER="cd ${repo}"
        zle accept-line
    fi
    zle clear-screen
}
zle -N skim-ghq
bindkey '^]' skim-ghq

function cdgem() {
  local gem_name=$(bundle list --unique | sed -e 's/^ *\* *//g' | sk | cut -d \  -f 1)
  if [ -n "$gem_name" ]; then
    local gem_dir=$(bundle info --path ${gem_name})
    echo "cd to ${gem_dir}"
    cd ${gem_dir}
  fi
}

function skim-git-worktree() {
    local selected_worktree=$(git worktree list | sk --layout=reverse --query "$LBUFFER" \
        --preview 'echo "Branch: $(git -C {1} branch --show-current)"; echo ""; echo "Changed files:"; git -C {1} status --porcelain | head -n 10; echo ""; echo "Recent commits:"; git -C {1} log --oneline --color=always -10' | awk '{print $1}')
    if [ -n "$selected_worktree" ]; then
        BUFFER="cd ${selected_worktree}"
        zle accept-line
    fi
    zle clear-screen
}
zle -N skim-git-worktree
bindkey '^G' skim-git-worktree

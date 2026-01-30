# Shell Options

# 8bit settings
setopt print_eightbit

# auto change directory
setopt auto_cd

# auto directory pushd that you can get dirs list by cd -[tab]
setopt auto_pushd

# command correct edition before each completion attempt
setopt correct

# compacted complete list display
setopt list_packed

# no remove postfix slash of command line
setopt noautoremoveslash

# no beep sound when complete list displayed
setopt nolistbeep

# numerical sort
setopt numeric_glob_sort

# delete rprompt after exec command
setopt transient_rprompt

# expand aliases before completing
setopt complete_aliases

# expand filename after equal mark
setopt magic_equal_subst

setopt complete_in_word
setopt glob_complete
setopt hist_expand
setopt no_beep

# From zshrc.mine
setopt ignoreeof
unsetopt bg_nice

# Word delimiter
autoload -Uz select-word-style
select-word-style default
zstyle ':zle:*' word-chars ' /=;@:{}[]()<>,|.'
zstyle ':zle:*' word-style unspecified

# Colors
autoload colors
colors

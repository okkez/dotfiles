# -*- sh -*-
# ---- language-env DON'T MODIFY THIS LINE!
# ログインシェルではない bash の起動時に実行される。
# ----- 基本的な設定 -----
# XIM サーバーの名前を定義する
# (XIM は、language-env だけで使うシェル変数です)
# xprop は、xbase-clients パッケージに含まれます
if [ -n "$WINDOWID" -a -x /usr/bin/X11/xprop ] ; then
  # X Window System 上で走ってるけど X Window System と通信する権限が
  # ないとき (su したときなど) への対策
  xprop -id $WINDOWID >& /dev/null || unset WINDOWID
fi
if [ -n "$WINDOWID" -a -x /usr/bin/X11/xprop ] ; then
  XPROP=`xprop -id $WINDOWID WM_CLASS`
  case $XPROP in
  *kterm* | *krxvt* | *kwterm* | *katerm* ) LANG=ja_JP.UTF-8 ;;
  *UXTerm* ) LANG=ja_JP.UTF-8 ;;
  *hanterm* ) LANG=ko_KR.eucKR ;;
  *caterm* | *crxvt-big5* ) LANG=zh_TW.Big5 ;;
  *crxvt-gb* ) LANG=zh_CN.GB2312 ;;
  *aterm* ) LANG=C ;;
  # gnome-terminal は $WINDOWID の意味が違う
  # mlterm は WM_CLASS を設定しない
  # Eterm もロケール自動認識になった
  # xterm もロケール自動認識になった (ただしフォント設定が必要)
  # rxvt-beta もロケール自動認識
  * ) : ;;
  esac
else
  case $TERM in
    linux) LANG=C ;;
    xterm)
      if [ "$COLORTERM" != "gnome-terminal" ] ; then
        LANG=C
      fi ;;
    jfbterm) : ;;
    *) LANG=ja_JP.UTF-8 ;;
  esac
fi
case $LANG in
  ja_JP.UTF-8) JLESSCHARSET=utf-8 ; LV=-Ou8 ;;
  ja_JP.*) JLESSCHARSET=japanese-euc ; LV=-Oej ;;
  *) JLESSCHARSET=latin1 ; LV=-Al1 ;;
esac
export LANG JLESSCHARSET LV
if type lv &>/dev/null ; then
  PAGER=lv
elif type jless &>/dev/null ; then
  PAGER=jless
elif type less &>/dev/null ; then
  PAGER=less
else
  PAGER=more
fi
export PAGER
# XMODIFIERS を export しないのは、emacs が Segmentation Fault を起こすから
# ただし、この方法だと、Debian メニューシステムからの起動には対応できない。
function rxvt {
  if /usr/bin/which krxvt &> /dev/null
  then
    krxvt $*
  else
    /usr/bin/rxvt $*
  fi
}
alias jfbterm='LANG=ja_JP.UTF-8 /usr/bin/jfbterm'
alias xemacs='XMODIFIERS= xemacs'
# perl がロケールにかんするワーニングを出す場合に有効にしてください。
# PERL_BADLANG=0 ; export PERL_BADLANG
# .bash_profile で使う。
BASHRC_DONE=1
# mh がインストールされていたら、PATH に加える。
if [ -x /usr/bin/mh/mhmail ]
then
  if type mhmail &>/dev/null
  then
    true
  else
    PATH=$PATH:/usr/bin/mh
  fi
fi
## ----- お好みに応じて -----
# ls の動作 (属性表示、色つき)。man ls 参照
if [ "$TERM" = "dumb" -o "$TERM" = "emacs" ]
then
  alias ls='/bin/ls -F'
else
  alias ls='/bin/ls -F --color=auto'
fi
# 標準エディタを vi にする。Debian Policy Manual 参照
EDITOR=vi
export EDITOR
# プロンプト。man bash 参照
if [ "$TERM" = "dumb" -o "$TERM" = "emacs" ]
then
  PS1='\w\$ '
else
  if [ "$UID" = "0" ]
  then
    PS1='\[\e[41m\]\w\$\[\e[m\] '
  else
    PS1='\[\e[7m\]\w\$\[\e[m\] '
  fi
fi
# ファイルを作るとき、どんな属性で作るか。man umask 参照
umask 022
# less の動作。man less 参照
LESS=-M
export LESS
if type /usr/bin/lesspipe &>/dev/null
then
  LESSOPEN="| /usr/bin/lesspipe '%s'"
  LESSCLOSE="/usr/bin/lesspipe '%s' '%s'"
  export LESSOPEN LESSCLOSE
fi
# Ctrl-D でログアウトするのを抑制する。man bash 参照
IGNOREEOF=3
# カレントディレクトリのバックアップファイルを表示する
# (削除する際は "chkbackups | xargs rm" を実行のこと)
alias chkbackups='/usr/bin/find . -name "?*~" -o -name "?*.bak" -o -name ".[^.]?*~" -o -name ".[^.]?*.bak" -maxdepth 1'
# X Window System 上での設定
if [ "$DISPLAY" ]
then
  # 画面サイズを変更すると COLUMNS, LINES を変更する。man bash 参照
  shopt -s checkwinsize
  # 端末ウィンドウのタイトルを変更する
  function xtitle()
  {
    /bin/echo -e "\033]0;$*\007\c"
  }
fi
# ---- language-env end DON'T MODIFY THIS LINE!
# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# don't put duplicate lines in the history. See bash(1) for more options
#export HISTCONTROL=ignoredups

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" -a -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
xterm-color)
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
    ;;
*)
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
    ;;
esac

# Comment in the above and uncomment this below for a color prompt
#PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME}: ${PWD/$HOME/~}\007"'
    ;;
*)
    ;;
esac

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

#if [ -f ~/.bash_aliases ]; then
#    . ~/.bash_aliases
#fi

# enable color support of ls and also add handy aliases
if [ "$TERM" != "dumb" ]; then
    eval "`dircolors -b`"
    alias ls='ls --color=auto'
    #alias dir='ls --color=auto --format=vertical'
    #alias vdir='ls --color=auto --format=long'
fi

# some more ls aliases
alias ll='ls -l'
alias la='ls -A'
alias l='ls -CF'
alias ec='emacsclient'

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
fi

export RUBYLIB="${RUBYLIB}":/usr/local/lib/site_ruby
export PATH=~/.gems/bin:"${PATH}"
#export PATH=~/jruby-1.0/bin:"${PATH}"
export GEM_HOME=~/.gems
export HREF_DATADIR=~/.href

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

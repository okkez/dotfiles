#!/bin/bash

files="
zshrc
bash_profile
bashrc
emacs
screenrc
irbrc
"
for f in $files; do
  if test -L $HOME/.$f; then
    echo $f
  else
    ln -f -s $HOME/dotfiles/$f $HOME/.$f
  fi
done


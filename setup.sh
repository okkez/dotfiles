#!/bin/bash
# -*- indent-tabs-mode: nil; sh-basic-offset: 2; sh-indentation: 2 -*-

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

if test -d $HOME/.rbenv; then
  git clone git://github.com/sstephenson/rbenv.git $HOME/.rbenv
  git clone git://github.com/sstephenson/ruby-build.git $HOME/.rben/plugins/ruby-build
fi

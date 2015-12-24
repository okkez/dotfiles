#!/bin/bash
# -*- indent-tabs-mode: nil; sh-basic-offset: 2; sh-indentation: 2 -*-

files="
zshrc
bash_profile
bashrc
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

if test -L $HOME/.emacs.d/init.el; then
  echo init.el
else
  ln -f -s $HOME/dotfiles/emacs.d/init.el $HOME/.emacs.d/init.el
fi

if ! test -d $HOME/.rbenv; then
  git clone git://github.com/sstephenson/rbenv.git $HOME/.rbenv
  git clone git://github.com/sstephenson/ruby-build.git $HOME/.rbenv/plugins/ruby-build
  git clone git://github.com/sstephenson/rbenv-gem-rehash.git $HOME/.rbenv/plugins/rbenv-gem-rehash
  git clone git://github.com/sstephenson/rbenv-default-gems.git $HOME/.rbenv/plugins/rbenv-default-gems
  git clone git://github.com/aripollak/rbenv-bundler-ruby-version.git $HOME/.rbenv/plugins/rbenv-bundler-ruby-version
fi

if ! dpkg -l golang > /dev/null 2>&1; then
  sudo apt-get install -y golang
  go get github.com/peco/peco/cmd/peco
fi

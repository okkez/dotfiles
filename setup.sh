#!/bin/bash
# -*- indent-tabs-mode: nil; sh-basic-offset: 2; sh-indentation: 2 -*-

packages="
git
curl
jq
"

for package in $packages; do
  dpkg -l | grep -q $package || sudo apt install $package
done

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

mkdir -p $HOME/.emacs.d/

if test -L $HOME/.emacs.d/init.el; then
  echo init.el
else
  ln -f -s $HOME/dotfiles/emacs.d/init.el $HOME/.emacs.d/init.el
fi

if ! test -d $HOME/.rbenv; then
  git clone https://github.com/sstephenson/rbenv.git $HOME/.rbenv
  git clone https://github.com/sstephenson/ruby-build.git $HOME/.rbenv/plugins/ruby-build
  git clone https://github.com/sstephenson/rbenv-gem-rehash.git $HOME/.rbenv/plugins/rbenv-gem-rehash
  git clone https://github.com/sstephenson/rbenv-default-gems.git $HOME/.rbenv/plugins/rbenv-default-gems
  git clone https://github.com/aripollak/rbenv-bundler-ruby-version.git $HOME/.rbenv/plugins/rbenv-bundler-ruby-version
fi

if ! test -d $HOME/.nvm; then
  git clone https://github.com/creationix/nvm.git ~/.nvm \
    && cd ~/.nvm \
    && git checkout $(git describe --abbrev=0 --tags)
fi

if ! test -e $HOME/bin/peco; then
  if type jq > /dev/null; then
    url=$(curl https://api.github.com/repos/peco/peco/releases/latest |
            jq -r '.assets[] | select(.name == "peco_linux_amd64.tar.gz").browser_download_url')
  else
    url=$(curl https://api.github.com/repos/peco/peco/releases/latest |
            sed -n -e 's/browser_download_url.\+\(https:.\+peco_linux_amd64.tar.gz\)\"/\1/p' |
            sed -e 's/\"//' -e 's/ //g')
  fi
  curl -L -O $url
  tar xf peco_linux_amd64.tar.gz
  mkdir -p $HOME/bin
  mv peco_linux_amd64/peco $HOME/bin/peco
  rm -rf peco_linux_amd64.tar.gz
  rm -rf peco_linux_amd64
fi

if ! test -e $HOME/bin/hub; then
  url=$(curl https://api.github.com/repos/github/hub/releases/latest |
          jq -r '.assets[] | select(.name | startswith("hub-linux-amd64")).browser_download_url')
  curl -L -O $url
  tar xf $(basename $url)
  mkdir -p $HOME/bin
  mv $(basename -s .tgz $url)/bin/hub $HOME/bin/hub
  rm -rf $(basename $url)
  rm -rf $(basename -s .tgz $url)
fi

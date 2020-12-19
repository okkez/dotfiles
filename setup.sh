#!/bin/bash
# -*- indent-tabs-mode: nil; sh-basic-offset: 2; sh-indentation: 2 -*-

packages="
git
curl
jq
apel
rdtool-elisp
emacs
elpa-magit
elpa-flycheck
develock-el
cmigemo
rsync
ruby
screen
zsh
build-essential
ddskk
unzip
aspell
"

sudo apt install -y $packages

files="
zshrc
bash_profile
bashrc
screenrc
irbrc
aspell.conf
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

mkdir -p $HOME/.config/git

if ! test -L $HOME/.config/git/config; then
  ln -f -s $HOME/dotfiles/git-config $HOME/.config/git/config
fi

if ! test -d $HOME/.rbenv; then
  git clone https://github.com/rbenv/rbenv.git $HOME/.rbenv
  git clone https://github.com/rbenv/ruby-build.git $HOME/.rbenv/plugins/ruby-build
  git clone https://github.com/rbenv/rbenv-gem-rehash.git $HOME/.rbenv/plugins/rbenv-gem-rehash
  git clone https://github.com/rbenv/rbenv-default-gems.git $HOME/.rbenv/plugins/rbenv-default-gems
  git clone https://github.com/rbenv/rbenv-each.git $HOME/.rbenv/plugins/rbenv-each
  git clone https://github.com/aripollak/rbenv-bundler-ruby-version.git $HOME/.rbenv/plugins/rbenv-bundler-ruby-version
fi

if ! test -d $HOME/.nvm; then
  git clone https://github.com/creationix/nvm.git $HOME/.nvm \
    && cd $HOME/.nvm \
    && git checkout $(git describe --abbrev=0 --tags)
fi

if ! test -d $HOME/.luaenv; then
  git clone https://github.com/cehoffman/luaenv.git $HOME/.luaenv
  git clone https://github.com/cehoffman/lua-build.git $HOME/.luaenv/plugins/lua-build
  git clone https://github.com/xpol/luaenv-luarocks.git $HOME/.luaenv/plugins/luaenv-luarocks
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

mkdir -p $HOME/.peco

if test -L $HOME/.peco/config.json; then
  echo $HOME/.peco/config.json
else
  ln -f -s $HOME/dotfiles/peco-config.json $HOME/.peco/config.json
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

if ! test -e $HOME/bin/ghq; then
  url=$(curl https://api.github.com/repos/motemen/ghq/releases/latest |
          jq -r '.assets[] | select(.name == "ghq_linux_amd64.zip").browser_download_url')
  curl -L -O $url
  unzip $(basename $url)
  mkdir -p $HOME/bin
  mv $(basename -s .zip $url)/ghq $HOME/bin/ghq
  mv $(basename -s .zip $url)/misc/zsh/_ghq $HOME/dotfiles/zsh/ghq.sh
  rm -rf $(basename $url)
  rm -rf $(basename -s .zip $url)
fi

mkdir -p $HOME/wc

if ! test -d $HOME/wc/gnome-terminal-colors-solarized; then
  git clone https://github.com/Anthony25/gnome-terminal-colors-solarized.git $HOME/wc/gnome-terminal-colors-solarized
fi

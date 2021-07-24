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
hunspell
direnv
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

if test -x $HOME/.cargo/bin/rustup; then
  curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
fi

rustup update
cargo install skim
cargo install starship

if test -L $HOME/.config/starship.toml; then
  echo $HOME/.config/starship.toml
else
  ln -f -s $HOME/dotfiles/starship.toml $HOME/.config/starship.toml
fi

if dpkg -l gh; then
  :
else
  url=$(curl https://api.github.com/repos/cli/cli/releases/latest |
          jq -r '.assets[] | select(.name | test("gh_.*linux_amd64.deb")).browser_download_url')
  curl -L -O $url
  sudo apt install $(basename $url)
  rm -f $(basename $url)
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

#!/bin/bash
# -*- indent-tabs-mode: nil; sh-basic-offset: 2; sh-indentation: 2 -*-

curl -L https://github.com/itamae-kitchen/mitamae/releases/latest/download/mitamae-x86_64-linux.tar.gz | tar xz
mv mitamae-x86_64-linux /tmp/mitamae
sudo /tmp/mitamae local mitamae/system.rb
/tmp/mitamae local mitamae/dotfiles.rb

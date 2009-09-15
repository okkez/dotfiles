= What's this?

my dotfile.


= How to use.

Please execute below commands.

  $ ln -s ~/dotfiles/zshrc ~/.zshrc
  $ ln -s ~/dotfiles/zsh.mine ~/.zsh.mine
  $ ln -s ~/dotfiles/bash_profile ~/.bash_profile
  $ ln -s ~/dotfiles/bashrc ~/.bashrc
  $ ln -s ~/dotfiles/emacs ~/.emacs
  $ ln -s ~/dotfiles/screenrc ~/.screenrc
  $ ln -s ~/dotfiles/irbrc ~/.irbrc

  $ mkdir -p ~/.elisp/repos

Please install below elisp.

* install-elisp.el

  $ cd ~/.elisp; wget http://www.emacswiki.org/cgi-bin/wiki/download/install-elisp.el

* auto-install.el

  M-x install-elisp RET http://www.emacswiki.org/emacs/download/auto-install.el

* color-theme.el

  see EmacsWiki: Color Theme <http://www.emacswiki.org/cgi-bin/wiki?ColorTheme>

* rcodetools

  $ sudo gem install rcodetools

copy *.el from rcodetools' directory.

* rinari

  $ cd ~/.elisp
  $ git clone git://github.com/eschulte/rinari.git
  $ git submodule init
  $ git submodule update
  $ git clone git://github.com/eschulte/rhtml.git
  $ git svn clone http://yasnippet.googlecode.com/svn/trunk yasnippet
  $ git clone git://github.com/eschulte/yasnippets-rails.git
  
* anything.el

  M-x auto-install-from-emacswiki RET anything.el
  M-x auto-install-from-emacswiki RET anything-config.el
  M-x auto-install-from-emacswiki RET anything-match-plugin.el

* key-chord.el

  M-x auto-install-from-emacswiki RET key-chord.el

* grep-edit.el

  M-x auto-install-from-emacswiki RET grep-edit.el

* japanese-holidays.el

  M-x auto-install-from-url RET http://www.meadowy.org/meadow/netinstall/export/799/branches/3.00/pkginfo/japanese-holidays/japanese-holidays.el


;; yasnippet
; git svn clone -rHEAD http://yasnippet.googlecode.com/svn/trunk/ yasnippet
; git clone git://github.com/eschulte/yasnippets-rails.git
(setq load-path (cons "~/.elisp/yasnippet" load-path))
(require 'yasnippet)
(yas/initialize)
(yas/load-directory "~/.elisp/yasnippets-rails/rails-snippets")


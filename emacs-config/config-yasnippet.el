;; yasnippet
; git svn clone -rHEAD http://yasnippet.googlecode.com/svn/trunk/ yasnippet
; git clone git://github.com/eschulte/yasnippets-rails.git
(add-to-list 'load-path "~/.elisp/yasnippet")
(require 'yasnippet)
(yas/initialize)
(yas/load-directory "~/.elisp/yasnippets-rails/rails-snippets")
(yas/load-directory "~/.elisp/yasnippet/snippets")

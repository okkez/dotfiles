;; yasnippet
; git clone https://github.com/capitaomorte/yasnippet.git
; git clone git://github.com/eschulte/yasnippets-rails.git
(require 'yasnippet)
(yas/initialize)
(yas/load-directory "~/.emacs.d/el-get/yasnippets-rails/rails-snippets")
(yas/load-directory "~/.emacs.d/el-get/yasnippet/snippets")

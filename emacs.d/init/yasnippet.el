;; yasnippet
; git clone https://github.com/capitaomorte/yasnippet.git
; git clone git://github.com/eschulte/yasnippets-rails.git

(el-get-bundle helm-c-yasnippet
  (require 'yasnippet)
  (global-set-key (kbd "C-c y") 'helm-c-yas-complete)
  (yas-initialize)
  (yas-load-directory "~/.emacs.d/el-get/yasnippets-rails/rails-snippets")
  (yas-load-directory "~/.emacs.d/el-get/yasnippet/snippets")
  (yas-load-directory "~/dotfiles/emacs.d/snippets"))

;; yasnippet
; git clone https://github.com/capitaomorte/yasnippet.git
; git clone git://github.com/eschulte/yasnippets-rails.git

(el-get-bundle yasnippet-snippets)
(el-get-bundle yasnippets-rails)
(el-get-bundle yasnippet
  (with-eval-after-load-feature 'yasnippet
    (yas-global-mode 1)
    (yas-load-directory "~/.emacs.d/el-get/yasnippets-rails/rails-snippets")
    (yas-load-directory "~/.emacs.d/el-get/yasnippet-snippets/snippets/")
    (yas-load-directory "~/dotfiles/emacs.d/snippets")))
(el-get-bundle helm-c-yasnippet
  (with-eval-after-load-feature 'helm-c-yasnippet
    (global-set-key (kbd "C-c y") 'helm-c-yas-complete)))

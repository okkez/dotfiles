; -*- mode: emacs-lisp -*-
;; el-get は GitHub の master を使う
(add-to-list 'load-path "~/.emacs.d/el-get/el-get")
(unless (require 'el-get nil 'noerror)
  (with-current-buffer
      (url-retrieve-synchronously
       "https://raw.github.com/dimitri/el-get/master/el-get-install.el")
    (let (el-get-master-branch)
      (goto-char (point-max))
      (eval-print-last-sexp))))

;; additional recipes path
(add-to-list 'el-get-recipe-path
             (expand-file-name "~/dotfiles/emacs.d/recipes"))

(el-get-bundle! emacs-jp/init-loader
  (setq-default init-loader-show-log-after-init t
                init-loader-byte-compile t)
  (init-loader-load
   (expand-file-name "~/dotfiles/emacs.d/init-loader")))

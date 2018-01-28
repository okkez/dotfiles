; -*- mode: emacs-lisp -*-

(setq gc-cons-threshold (* 128 1024 1024))

;; customizeの出力先設定
(setq custom-file "~/.emacs.d/custom-file.el")
(if (file-exists-p (expand-file-name "~/.emacs.d/custom-file.el"))
    (load (expand-file-name custom-file) t nil nil))

;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
;(package-initialize)

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

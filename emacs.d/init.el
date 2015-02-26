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
             (concat (file-name-directory load-file-name) "recipes"))

;; el-get-list-packages で f でレシピを開く
(defun el-get-current-recipe ()
  "get recipe name of current line"
  (save-excursion
    (beginning-of-line)
    (buffer-substring
     (progn (skip-chars-forward " \t") (point))
     (progn (skip-chars-forward "^ \t") (point)))))

(defun el-get-find-recipe-at-line ()
  "find recipe of current line"
  (interactive)
  (let ((package (el-get-current-recipe)))
    (el-get-find-recipe-file package)))

(add-hook
 'el-get-package-menu-mode-hook
 '(lambda ()
    (define-key el-get-package-menu-mode-map "f" 'el-get-find-recipe-at-line)))

(el-get-bundle! emacs-jp/init-loader
  (setq-default init-loader-show-log-after-init t
                init-loader-byte-compile t)
  (init-loader-load
   (concat (file-name-directory load-file-name) "emacs-config")))

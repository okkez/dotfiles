;; rails.el
(add-to-list 'load-path "~/.elisp/emacs-rails.HEAD")
(defun try-complete-abbrev (old)
  (if (expand-abbrev) t nil))

(setq hippie-expand-try-functions-list
      '(try-complete-abbrev
       try-complete-file-name
       try-expand-dabbrev))
(setq rails-use-mongrel t)
(require 'rails)
(define-key rails-minor-mode-map "\C-c\C-p" 'rails-lib:run-primary-switch)
(define-key rails-minor-mode-map "\C-c\C-n" 'rails-lib:run-secondary-switch)

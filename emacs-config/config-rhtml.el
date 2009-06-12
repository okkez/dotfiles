;; rhtml-mode
; git clone git://github.com/eschulte/rhtml.git
(setq load-path (cons "~/.elisp/rhtml" load-path))
(require 'rhtml-mode)
(add-hook 'rhtml-mode-hook
    (lambda () (rinari-launch)))


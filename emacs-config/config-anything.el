(require 'anything)
(require 'anything-config)
(setq anything-sources
      '(anything-c-source-buffers+
        anything-c-source-colors
        anything-c-source-recentf
        anything-c-source-man-pages
        anything-c-source-emacs-commands
        anything-c-source-emacs-functions
        anything-c-source-files-in-current-dir
        ))

(define-key global-map (kbd "C-z l") 'anything)
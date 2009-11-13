(require 'auto-complete)
(global-auto-complete-mode t)
(define-key ac-complete-mode-map "\C-n" 'ac-next)
(define-key ac-complete-mode-map "\C-p" 'ac-previous)
;; M-/ で補完開始
(setq ac-auto-start nil)
(global-set-key "\M-/" 'ac-start)

;; start completion when entered 4 characters
;(setq ac-auto-start 4)


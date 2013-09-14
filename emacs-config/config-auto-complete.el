(require 'auto-complete-config)
(ac-config-default)
(global-auto-complete-mode t)
(define-key ac-complete-mode-map "\C-n" 'ac-next)
(define-key ac-complete-mode-map "\C-p" 'ac-previous)
(setq ac-dwim t)
;; 情報源の設定
(setq-default ac-sources
              '(ac-source-filename
                ac-source-words-in-same-mode-buffers
                ac-source-dictionary))
(add-hook 'emacs-lisp-mode-hook
          (lambda () (add-to-list 'ac-sources 'ac-source-symbols t)))
;(ac-rcodetools-initialize)
;; M-/ で補完開始
;(setq ac-auto-start nil)
(setq ac-auto-start 4)
;(global-set-key "\M-i" 'ac-start)

(add-to-list 'ac-modes 'rhtml-mode)
(add-to-list 'ac-modes 'rd-mode)


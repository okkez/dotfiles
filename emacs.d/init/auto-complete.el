(el-get-bundle auto-complete
  :features auto-complete-config
  (with-eval-after-load-feature 'auto-complete-config
    (ac-config-default)
    (global-auto-complete-mode t)
    (setq ac-use-menu-map t)
    (setq ac-dwim t)
    (setq ac-delay 0.1)
    (setq ac-auto-show-menu 0.1)
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
    ;(global-set-key (kbd "M-i") 'ac-start)

    (add-to-list 'ac-modes 'rhtml-mode)
    (add-to-list 'ac-modes 'rd-mode)))


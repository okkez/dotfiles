(el-get-bundle avy
  (define-key isearch-mode-map (kbd "M-a") 'avy-isearch)
  (global-set-key [remap goto-line] 'avy-goto-line)
  (global-set-key [remap goto-char] 'avy-goto-char-timer))

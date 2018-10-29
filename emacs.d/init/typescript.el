(el-get-bundle tss
  :depends (json-mode)
  (add-to-list 'auto-mode-alist '("\.ts$" . typescript-mode))
  (with-eval-after-load-feature 'tss
    (setq typescript-indent-level 2)))

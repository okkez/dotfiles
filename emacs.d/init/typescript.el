(el-get-bundle tss
  :depends (json-mode)
  (with-eval-after-load-feature 'tss
    (add-to-list 'auto-mode-alist '("\.ts$" . typescript-mode))
    (setq typescript-indent-level 2)))

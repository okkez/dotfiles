;; hcl-mode
(el-get-bundle hcl-mode
  (with-eval-after-load-feature 'hcl-mode
    (add-to-list 'auto-mode-alist '("\\.tf$" . hcl-mode))
    ))

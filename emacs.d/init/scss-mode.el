(el-get-bundle scss-mode
  (with-eval-after-load-feature 'scss-mode
    (add-to-list 'auto-mode-alist '("\.scss$" . scss-mode))))

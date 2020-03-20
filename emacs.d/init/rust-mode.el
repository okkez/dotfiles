(el-get-bundle rustic
  (with-eval-after-load-feature 'rustic-mode
    (add-to-list 'auto-mode-alist '("\\.rs$" . rustic-mode))))

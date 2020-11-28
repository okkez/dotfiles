(el-get-bundle typescript-mode
  :depends (json-mode)
  (add-to-list 'auto-mode-alist
               '("\.ts$" . typescript-mode)
               '("\.tsx$" . typescript-mode))
  (with-eval-after-load-feature 'typescript-mode
    (setq typescript-indent-level 2)))

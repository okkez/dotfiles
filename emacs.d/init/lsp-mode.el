(el-get-bundle lsp-mode)
(el-get-bundle lsp-ui
  (with-eval-after-load-feature 'lsp-ui-mode
    (add-hook 'lsp-mode-hook 'lsp-ui-mode)))

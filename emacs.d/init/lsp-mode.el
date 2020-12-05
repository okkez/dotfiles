;; lsp-ui depends  lsp-mode
(el-get-bundle lsp-ui
    (add-hook 'lsp-mode-hook 'lsp-ui-mode))

;; lsp-ui depends  lsp-mode
(el-get-bundle lsp-ui
  (add-to-list 'load-path (expand-file-name "~/.emacs.d/el-get/lsp-mode/clients"))
  (add-hook 'lsp-mode-hook 'lsp-ui-mode))

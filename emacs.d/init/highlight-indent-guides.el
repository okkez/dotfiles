(el-get-bundle highlight-indent-guides
  (custom-set-variables
   '(highlight-indent-guides-auto-enabled t)
   '(highlight-indent-guides-responsive t)
   '(highlight-indent-guides-method 'character))
  (add-hook 'prog-mode-hook 'highlight-indent-guides-mode)
  (add-hook 'yaml-mode-hook 'highlight-indent-guides-mode))

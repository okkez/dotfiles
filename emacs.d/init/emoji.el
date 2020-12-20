(el-get-bundle company-emoji
  (add-to-list 'company-backends 'company-emoji))

(el-get-bundle ivy-emoji
  (global-set-key (kbd "C-c i e") 'ivy-emoji))

(el-get-bundle emojify
  (global-emojify-mode)
  (global-set-key (kbd "C-c C-e") 'emojify-insert-emoji))

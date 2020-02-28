;; for eslint
;(el-get-bundle codesuki/add-node-modules-path)
(el-get-bundle mmm-mode
  '(mmm-global-mode (quote maybe) nil (mmm-mode))
  '(mmm-submode-decoration-level 2))
(el-get-bundle elpa:edit-indirect)
(el-get-bundle elpa:vue-html-mode)
(el-get-bundle elpa:ssass-mode)
(el-get-bundle elpa:vue-mode
  :depends (mmm-mode)
  (add-to-list 'auto-mode-alist '("\\.vue$" . vue-mode)))

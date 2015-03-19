(el-get-bundle ace-isearch
  (require 'ace-isearch)
  (global-ace-isearch-mode +1)

  (custom-set-variables
   '(ace-isearch-input-length 7)
   '(ace-isearch-input-idle-delay 0.3)
   '(ace-isearch-submode 'ace-jump-char-mode)
   '(ace-isearch-use-ace-jump 'printing-char))

  (ace-isearch-set-ace-jump-after-isearch-exit t))

(el-get-bundle doom-modeline
  (custom-set-variables
   '(doom-modeline-buffer-file-name-style 'truncate-with-project)
   '(doom-modeline-buffer-modification-icon nil)
   '(doom-modeline-minor-modes nil)
   )
  (require 'doom-modeline)
  (doom-modeline-mode 1))

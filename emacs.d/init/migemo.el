(el-get-bundle migemo
  (require 'migemo)
  (setq migemo-command "cmigemo")
  (setq migemo-options '("-q" "--emacs"))

  ;; Set your installed path
  (setq migemo-dictionary
        (expand-file-name "/usr/share/cmigemo/utf-8/migemo-dict"))

  (setq migemo-user-dictionary nil)
  (setq migemo-regex-dictionary nil)
  (setq migemo-coding-system 'utf-8-unix)
  (migemo-init))

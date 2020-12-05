(el-get-bundle flycheck
  (setq flycheck-display-errors-function
        '(lambda (errors)
           (-when-let (messages (-keep #'flycheck-error-message errors))
             (popup-tip (s-join "\n\n" messages))))))

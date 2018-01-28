(el-get-bundle s)
(el-get-bundle flycheck
  (with-eval-after-load-feature 'flycheck
    (setq flycheck-display-errors-function
          '(lambda (errors)
             (-when-let (messages (-keep #'flycheck-error-message errors))
                        (popup-tip (s-join "\n\n" messages)))))))

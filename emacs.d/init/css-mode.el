(autoload 'css-mode "css-mode" nil t)
(with-eval-after-load 'css-mode
  (setq cssm-indent-level 2)
  (setq cssm-indent-function #'cssm-c-style-indenter))

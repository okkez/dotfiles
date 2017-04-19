;; js2-mode
(el-get-bundle js2-mode
  (with-eval-after-load 'js2-mode
    (add-to-list 'auto-mode-alist '("\\.js$" . js2-mode))
    (add-hook 'js2-mode-hook
              '(lambda ()
                 ;(setq js2-bounce-indent-flag nil)
                 (setq js2-basic-offset 2)
                 (define-key js2-mode-map "\C-m" nil)
                 (define-key js2-mode-map "\C-i" 'indent-and-back-to-indentation)))
    (defun indent-and-back-to-indentation ()
      (interactive)
      (indent-for-tab-command)
      (let ((point-of-indentation
             (save-excursion
               (back-to-indentation)
               (point))))
        (skip-chars-forward "\s " point-of-indentation))))
  (with-eval-after-load 'js2-jsx-mode
    (add-to-list 'auto-mode-alist '("\\.jsx$" . js2-jsx-mode))
    (add-hook 'js2-jsx-mode '(lambda ()
                               (setq js2-basic-offset 2)))))


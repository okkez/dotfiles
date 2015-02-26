;; scheme
(setq scheme-program-name "gosh -i")
(autoload 'scheme-mode "cmuscheme" "Major mode for Scheme." t)
(autoload 'run-scheme "cmuscheme" "Run an inferior Scheme process." t)

(with-eval-after-load 'scheme-mode
  (defun scheme-other-window ()
    "Run scheme on other window"
    (interactive)
    (switch-to-buffer-other-window
     (get-buffer-create "*scheme*"))
    (run-scheme scheme-program-name))

  (add-hook 'scheme-mode-hook
            '(lambda ()
               (define-key scheme-mode-map
                 (kbd "C-c C-s") 'scheme-other-window))))

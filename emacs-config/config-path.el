;; load-path 追加
(setq load-path (cons "~/.elisp" load-path))
(setq load-path (cons "~/.elisp/repos" load-path))

;; PATH 追加
(setq exec-path (cons "/home/kenji/.gems/bin" exec-path))
(setenv "PATH" (concat "/home/kenji/.gems/bin:" (getenv "PATH")))


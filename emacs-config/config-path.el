;; load-path 追加
(add-to-list 'load-path "~/.elisp")
(add-to-list 'load-path "~/.elisp/repos")

;; PATH 追加
(setq exec-path (cons "/home/kenji/.gems/bin" exec-path))
(setenv "PATH" (concat "/home/kenji/.gems/bin:" (getenv "PATH")))


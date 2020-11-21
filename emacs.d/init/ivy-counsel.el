(el-get-bundle counsel
  (global-set-key (kbd "M-x") 'counsel-M-x)
  (global-set-key (kbd "C-x C-b") 'counsel-ibuffer)
  (global-set-key (kbd "C-;") 'counsel-switch-buffer)
  (global-set-key (kbd "M-y") 'counsel-yank-pop)

  (define-key counsel-find-file-map (kbd "C-l") 'counsel-up-directory)

  (with-eval-after-load "magit"
    (setq magit-completing-read-function 'ivy-completing-read))
)

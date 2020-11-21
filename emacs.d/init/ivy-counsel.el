(el-get-bundle amx)
(el-get-bundle ivy-rich)
(el-get-bundle ivy-posframe)
(el-get-bundle counsel
  (with-eval-after-load-feature 'ivy-rich
    (ivy-rich-mode 1))
  (with-eval-after-load-feature 'ivy-posframe
    (setq ivy-posframe-height-alist
          '((t . 30)))
    (setq ivy-posframe-display-functions-alist
          '((counsel-M-x . ivy-posframe-display-at-point)
            (counsel-yank-pop . ivy-posframe-display-at-point)
            (t . ivy-posframe-display)
            ))
    (ivy-posframe-mode 1))

  (global-set-key (kbd "M-x") 'counsel-M-x)
  (global-set-key (kbd "C-x C-f") 'counsel-find-file)
  (global-set-key (kbd "C-x C-b") 'counsel-ibuffer)
  (global-set-key (kbd "C-:") 'counsel-git)
  (global-set-key (kbd "C-;") 'counsel-switch-buffer)
  (global-set-key (kbd "M-y") 'counsel-yank-pop)

  (with-eval-after-load-feature 'counsel-find-file
    (define-key counsel-find-file-map (kbd "C-l") 'counsel-up-directory))

  (with-eval-after-load "magit"
    (setq magit-completing-read-function 'ivy-completing-read))
)

(el-get-bundle windymelt/counsel-ghq
  (global-set-key (kbd "C-\]") 'counsel-ghq))

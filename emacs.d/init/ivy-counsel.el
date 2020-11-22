(el-get-bundle amx)
(el-get-bundle ivy-rich)
(el-get-bundle ivy-posframe)
(el-get-bundle all-the-icons-ivy-rich)
(el-get-bundle wgrep)
(el-get-bundle counsel
  (all-the-icons-ivy-rich-mode 1)
  (ivy-rich-mode 1)
  (setq ivy-posframe-height-alist
        '((counsel-org-capture . 10)
          (t . 30)))
  (setq ivy-posframe-display-functions-alist
        '((counsel-M-x . ivy-posframe-display-at-point)
          (counsel-yank-pop . ivy-posframe-display-at-point)
          (t . ivy-posframe-display)
          ))
  (setq ivy-posframe-min-width (round (* (frame-width) 0.45)))
  (ivy-posframe-mode 1)

  (global-set-key (kbd "M-x") 'counsel-M-x)
  (global-set-key (kbd "C-x C-f") 'counsel-find-file)
  (global-set-key (kbd "C-x C-b") 'counsel-ibuffer)
  (global-set-key (kbd "C-:") 'counsel-git)
  (global-set-key (kbd "C-;") 'counsel-switch-buffer)
  (global-set-key (kbd "M-y") 'counsel-yank-pop)

  (define-key ivy-minibuffer-map (kbd "<escape>") 'minibuffer-keyboard-quit)

  (with-eval-after-load-feature 'counsel
    (define-key isearch-mode-map (kbd "M-i") 'swiper-from-isearch)
    (define-key counsel-find-file-map (kbd "C-l") 'counsel-up-directory))

  (with-eval-after-load "magit"
    (setq magit-completing-read-function 'ivy-completing-read))
)

(el-get-bundle windymelt/counsel-ghq
  (global-set-key (kbd "C-\]") 'counsel-ghq))

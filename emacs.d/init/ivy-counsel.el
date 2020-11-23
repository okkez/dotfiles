(el-get-bundle amx)
(el-get-bundle ivy-rich)
(el-get-bundle ivy-posframe)
(el-get-bundle all-the-icons-ivy-rich)
(el-get-bundle wgrep)
(el-get-bundle counsel
  (setq ivy-posframe-height-alist
        '((counsel-org-capture . 10)
          (counsel-git-log . 10)
          (t . 30)))
  (setq ivy-posframe-display-functions-alist
        '((counsel-M-x . ivy-posframe-display-at-point)
          (counsel-yank-pop . ivy-posframe-display-at-point)
          (counsel-git-log . ivy-posframe-display-at-point)
          (swiper . ivy-posframe-display-at-frame-bottom-window-center)
          (t . ivy-posframe-display)
          ))
  (setq ivy-posframe-min-width (round (* (frame-width) 0.45)))

  (add-hook 'ivy-mode-hook
            '(lambda ()
               (all-the-icons-ivy-rich-mode 1)
               (ivy-rich-mode 1)
               (ivy-posframe-mode 1)))

  (global-set-key (kbd "M-x") 'counsel-M-x)
  (global-set-key (kbd "C-x C-f") 'counsel-find-file)
  (global-set-key (kbd "C-x C-b") 'counsel-ibuffer)
  (global-set-key (kbd "C-:") 'counsel-git)
  (global-set-key (kbd "C-;") 'counsel-switch-buffer)
  (global-set-key (kbd "M-y") 'counsel-yank-pop)
  (global-set-key (kbd "C-c .") 'counsel-rg)

  (define-key ivy-minibuffer-map (kbd "<escape>") 'minibuffer-keyboard-quit)

  ;; https://github.com/abo-abo/swiper/issues/589#issuecomment-234670692
  (defun okkez/ivy-occur-editable ()
    (interactive)
    (run-at-time nil nil
                 (lambda () (ivy-wgrep-change-to-wgrep-mode)))
    (ivy-occur))

  (with-eval-after-load-feature 'counsel
    (setq counsel-git-log-cmd
          "GIT_PAGER=cat git log --no-color --format=%%x00%%B --grep '%s'")
    (setq counsel-fzf-cmd "sk -f \"%s\"")
    (add-to-list 'counsel-async-split-string-re-alist '(counsel-git-log . "\0"))
    (add-to-list 'counsel-async-ignore-re-alist '(counsel-git-log . "^[ \n]*$"))
    (define-key counsel-ag-map (kbd "C-c C-e") 'okkez/ivy-occur-editable)
    (define-key isearch-mode-map (kbd "M-i") 'swiper-from-isearch)
    (define-key counsel-find-file-map (kbd "C-l") 'counsel-up-directory))

  (with-eval-after-load-feature 'swiper
    (define-key counsel-ag-map (kbd "C-c C-e") 'okkez/ivy-occur-editable))

  (with-eval-after-load "magit"
    (add-hook 'magit-mode-hook
              '(lambda ()
                 (define-key git-commit-mode-map (kbd "C-c i") 'counsel-git-log)
                 (key-chord-mode -1)))
    (setq magit-completing-read-function 'ivy-completing-read))
)

(el-get-bundle windymelt/counsel-ghq
  (global-set-key (kbd "C-\]") 'counsel-ghq))

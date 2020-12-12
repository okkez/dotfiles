(el-get-bundle counsel
  :depends (amx ivy-rich ivy-posframe all-the-icons-ivy-rich wgrep)

  (add-hook 'ivy-mode-hook 'ivy-rich-mode)
  (add-hook 'ivy-mode-hook 'all-the-icons-ivy-rich-mode)
  (add-hook 'ivy-mode-hook 'ivy-posframe-mode)
  (ivy-mode t)
  (custom-set-variables
   '(ivy-posframe-height-alist
     '((counsel-org-capture . 10)
       (counsel-git-log . 10)
       (t . 30)))
   '(ivy-posframe-display-functions-alist
     '((counsel-M-x . ivy-posframe-display-at-point)
       (counsel-yank-pop . ivy-posframe-display-at-point)
       (counsel-git-log . ivy-posframe-display-at-point)
       (swiper . ivy-posframe-display-at-frame-bottom-window-center)
       (t . ivy-posframe-display)))
   '(ivy-initial-inputs-alist
     '((counsel-minor . "^+")
       (counsel-package . "^+")
       (counsel-org-capture . "^")
       (counsel-describe-symbol . "^")
       (org-refile . "^")
       (org-agenda-refile . "^")
       (org-capture-refile . "^")
       (Man-completion-table . "^")
       (woman . "^")))
   '(ivy-posframe-min-width (round (* (frame-width) 0.45)))
   '(ivy-reaad-action-function 'ivy-hydra-read-action)
   '(ivy-truncate-lines nil)
   '(ivy-use-virtual-buffers t)
   '(ivy-wrap t)
   '(counsel-git-log-cmd
     "GIT_PAGER=cat git log --no-color --format=%%x00%%B --grep '%s'")
   '(counsel-fzf-cmd "sk -f \"%s\"")
   )

  (global-set-key (kbd "M-x") 'counsel-M-x)
  (global-set-key (kbd "C-x C-f") 'counsel-find-file)
  (global-set-key (kbd "C-x C-b") 'counsel-ibuffer)
  (global-set-key (kbd "C-:") 'counsel-git)
  (global-set-key (kbd "C-;") 'counsel-switch-buffer)
  (global-set-key (kbd "M-y") 'counsel-yank-pop)
  (global-set-key (kbd "C-c .") 'counsel-rg)

  (with-eval-after-load-feature 'ivy
    (define-key ivy-minibuffer-map (kbd "<escape>") 'minibuffer-keyboard-quit))

  ;; https://github.com/abo-abo/swiper/issues/589#issuecomment-234670692
  (defun okkez/ivy-occur-editable ()
    (interactive)
    (run-at-time nil nil
                 (lambda () (ivy-wgrep-change-to-wgrep-mode)))
    (ivy-occur))

  (defun counsel-sk (&optional initial-input initial-directory)
    "Open a file using the sk shell command.
INITIAL-INPUT can be given as the initial minibuffer input.
INITIAL-DIRECTORY, if non-nil, is used as the root directory for search."
    (interactive
     (counsel-fzf nil nil "sk: ")))

  (with-eval-after-load-feature 'counsel
    (add-to-list 'counsel-async-split-string-re-alist '(counsel-git-log . "\0"))
    (add-to-list 'counsel-async-ignore-re-alist '(counsel-git-log . "^[ \n]*$"))
    (define-key isearch-mode-map (kbd "M-i") 'swiper-from-isearch)
    (define-key counsel-find-file-map (kbd "C-l") 'counsel-up-directory)
    (define-key counsel-ag-map (kbd "C-c C-e") 'okkez/ivy-occur-editable))

  (with-eval-after-load-feature 'hydra
    (defhydra hydra-counsel (:hint nil :exit t)
      "
Counsel: describ-_f_unction     find-_L_ibrary   _u_nicode-char
         _d_escbinds            _l_ocate         _y_ank-pop
         describ-_v_ariable     _a_g             _m_ark-ring
         _i_nfo-lookup-symbol   _g_it-grep       org-_c_apture
         a_p_ropos              _r_g             _s_k
      "
      ("d" counsel-descbinds)
      ("y" counsel-yank-pop)
      ("m" counsel-mark-ring)
      ("f" counsel-describe-function)
      ("v" counsel-describe-variable)
      ("p" counsel-apropos)
      ("L" counsel-find-library)
      ("i" counsel-info-lookup-symbol)
      ("u" counsel-unicode-char)
      ("g" counsel-git-grep)
      ("i" counsel-git)
      ("a" counsel-ag)
      ("r" counsel-rg)
      ("l" counsel-locate)
      ("s" counsel-sk)
      ("c" counsel-org-capture)))

  (with-eval-after-load-feature 'swiper
    (define-key swiper-map (kbd "C-c C-e") 'okkez/ivy-occur-editable))

  (with-eval-after-load "magit"
    (add-hook 'magit-mode-hook
              '(lambda ()
                 (define-key git-commit-mode-map (kbd "C-c i") 'counsel-git-log)))
    (setq magit-completing-read-function 'ivy-completing-read))
)

(el-get-bundle counsel-ghq
  (custom-set-variables
   '(counsel-ghq-command-ghq-arg-list '("list" "--full-path")))

  (defun counsel-sk-with-dir (initial-directory)
    (counsel-fzf nil initial-directory "sk: "))

  (with-eval-after-load-feature 'counsel-ghq
    ;; NOTE: ivy-add-actions だと2回目以降で元の default に戻ってしまうため全部上書きする
    (ivy-set-actions 'counsel-ghq
                     '(("o" counsel-sk-with-dir "Open File with counsel-sk"))))
  (global-set-key (kbd "C-\]") 'counsel-ghq))

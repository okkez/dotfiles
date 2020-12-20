;;; flyspell-mode
(el-get-bundle flyspell-correct-popup)

(custom-set-variables
 ;; Do no change M-TAB key bind
 '(flyspell-use-meta-tab nil)
 '(flyspell-auto-correct-binding (kbd "C-z C-;"))
 '(ispell-program-name "hunspell")
 '(ispell-really-hunspell t)
 '(isqpell-dictionary "american"))

(with-eval-after-load-feature 'flyspell
  (define-key flyspell-mode-map (kbd "C-1") 'flyspell-correct-wrapper))

;; Enable spell checker in text-mode
(mapc
 (lambda (hook)
   (add-hook hook 'flyspell-mode))
 '(text-mode-hook))
;; Enable spell checker in comment while programming
(mapc
 (lambda (hook)
   (add-hook hook 'flyspell-prog-mode))
 '(prog-mode-hook
   enh-ruby-mode-hook
   ruby-mode-hook))

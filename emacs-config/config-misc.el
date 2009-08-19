;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; いろいろ
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Deleteキーでカーソル位置の文字が消えるようにする
(global-set-key [delete] 'delete-char)
;; C-h キーでカーソルの左の文字が消えるようにする。
;; ただし、もともと C-h はヘルプなので、
;; これを有効にすると、ヘルプを使うときには
;; M-x help や F1 を使う必要があります。
(global-set-key "\C-h" 'backward-delete-char)

; ---- language-env end DON'T MODIFY THIS LINE!

;(require 'un-define)
;(un-define-debian)

;; default font
(set-default-font "VL ゴシック" 10)
(set-default-coding-systems 'utf-8-unix)

;; 長い行を折り返さない
(setq-default truncate-lines t)

;; ツールバーを消す
(tool-bar-mode nil)

;; 行番号
(line-number-mode t)
(global-linum-mode t)
;; 桁番号
(column-number-mode t)
(set-scroll-bar-mode 'right)
(custom-set-variables
 ;; custom-set-variables was added by Custom -- don't edit or cut/paste it!
 ;; Your init file should contain only one such instance.
 '(auto-compression-mode t nil (jka-compr))
 '(case-fold-search t)
; '(current-language-environment "Japanese")
 '(default-input-method "japanese-anthy")
 '(global-font-lock-mode t nil (font-lock))
 '(show-paren-mode t nil (paren)))
(custom-set-faces
 ;; custom-set-faces was added by Custom -- don't edit or cut/paste it!
 ;; Your init file should contain only one such instance.
 )

;; emacs -> 他アプリへのコピペ
(setq x-select-enable-clipboard t)
(setq selection-coding-system 'compound-text-with-extensions)
;; C-Del でクリップボードにカット
;(global-set-key "\S-[delete]"
;               '(lambda ()
;                  (interactive)
;                  (clipboard-kill-region)))
;; S-Ins でクリップボードからペースト
;(global-set-key "\S-[insert]"
;               '(lambda ()
;                  (interactive)
;                  (clipboard-yank)))

(put 'set-goal-column 'disabled nil)

(put 'narrow-to-region 'disabled nil)


;; css-mode
(setq css-indent-offset 2)

;; for ChangeLog mode
(setq user-full-name "okkez")
(setq user-mail-address "okkez000@gmail.com")

;; install-elisp
(require 'install-elisp)
(setq load-path (cons "~/.elisp/repos" load-path))
(setq install-elisp-repository-directory "~/.elisp/repos/")

;; grep-edit
;; http://d.hatena.ne.jp/rubikitch/20081025/1224869598
(require 'grep)
(require 'grep-edit)

(defadvice grep-edit-change-file (around inhibit-read-only activate)
  ""
  (let ((inhibit-read-only t))
    ad-do-it))
;; (progn (ad-disable-advice 'grep-edit-change-file 'around 'inhibit-read-only) (ad-update 'grep-edit-change-file)) 

(defun my-grep-edit-setup ()
  (define-key grep-mode-map '[up] nil)
  (define-key grep-mode-map "\C-c\C-c" 'grep-edit-finish-edit)
  (message (substitute-command-keys "\\[grep-edit-finish-edit] to apply changes."))
  (set (make-local-variable 'inhibit-read-only) t)
  )
(add-hook 'grep-setup-hook 'my-grep-edit-setup t)

;; racc-mode
(autoload 'racc-mode "racc-mode" "alternate mode for editing racc files" t)
(setq auto-mode-alist (append '(("\\.ry$" . racc-mode)) auto-mode-alist))

;; calendar show holidays
(require 'calendar)
(setq  number-of-diary-entries 31)
(define-key calendar-mode-map "f" 'calendar-forward-day)
(define-key calendar-mode-map "n" 'calendar-forward-day)
(define-key calendar-mode-map "b" 'calendar-backward-day)
(setq mark-holidays-in-calendar t)
;; (install-elisp "http://www.meadowy.org/meadow/netinstall/export/799/branches/3.00/pkginfo/japanese-holidays/japanese-holidays.el")
(require 'japanese-holidays)
(setq calendar-holidays
      (append japanese-holidays local-holidays other-holidays))
(setq calendar-weekend-marker 'diary)
(add-hook 'today-visible-calendar-hook 'calendar-mark-weekend)
(add-hook 'today-invisible-calendar-hook 'calendar-mark-weekend)


;; emacsclient
(server-start)

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
;(set-frame-font "VL Gothic" 10)
(set-default-coding-systems 'utf-8-unix)
;(add-to-list 'default-frame-alist '(font . "VL Gothic-10"))
(defun set-font-size-by-resolution ()
  (let ((size (if (> (x-display-pixel-height) 1500) 15 10)))
    (condition-case err
        (let ((myfont (format "VL ゴシック-%d" size)))
          (set-frame-font myfont)
          (add-to-list 'default-frame-alist `(font . ,myfont)))
      (error (message "%s" err)))))
(set-font-size-by-resolution)

;; Emoji
(set-fontset-font t 'symbol "Noto Color Emoji")

;; 起動時に最大化
(set-frame-parameter nil 'fullscreen 'maximized)

;; 長い行を折り返さない
(setq-default truncate-lines t)

;; ツールバーを消す
(tool-bar-mode 0)

;; 行番号
(global-display-line-numbers-mode t)
;; 桁番号
(column-number-mode t)
(set-scroll-bar-mode 'right)
(custom-set-variables
 ;; custom-set-variables was added by Custom -- don't edit or cut/paste it!
 ;; Your init file should contain only one such instance.
 '(auto-compression-mode t nil (jka-compr))
 '(case-fold-search t)
; '(current-language-environment "Japanese")
; '(default-input-method "japanese-anthy")
 '(default-input-method "japanese-skk")
 '(global-font-lock-mode t nil (font-lock)))
(custom-set-faces
 ;; custom-set-faces was added by Custom -- don't edit or cut/paste it!
 ;; Your init file should contain only one such instance.
 )

(custom-set-variables
 '(skk-server-host "localhost")
 '(skk-server-port 1178)
 '(skk-aux-large-jisyo "/usr/share/skk/SKK-JISYO.L")
 '(skk-server-report-response t))

(with-eval-after-load-feature skk
  (add-hook 'skk-mode-hook
            (lambda ()
              (and (skk-in-minibuffer-p)
                   (skk-mode-exit)))))

(show-paren-mode t)
(custom-set-variables
 '(show-paren-style 'mixed))
(set-face-attribute 'show-paren-match nil
                    :foreground nil
                    :background "#073642"
                    :underline nil)
(electric-pair-mode t)

;; カーソルの点滅を止める
(blink-cursor-mode 0)

;; emacs -> 他アプリへのコピペ
(setq select-enable-clipboard t)
(setq selection-coding-system 'compound-text-with-extensions)
(set-clipboard-coding-system 'utf-8-unix)
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

;; for ChangeLog mode
(setq user-full-name "okkez")
(setq user-mail-address "okkez000@gmail.com")

;; backup files
(setq make-backup-files nil)
(setq backup-directory-alist
      '(("/Dropbox/*.*" . "~/.emacs.d/backup/")
        ("~/Nextcloud/*.*" . "~/.emacs.d/backup/")
        ))

;; racc-mode
(autoload 'racc-mode "racc-mode" "alternate mode for editing racc files" t)
(setq auto-mode-alist (append '(("\\.ry$" . racc-mode)) auto-mode-alist))

;; calendar show holidays
(custom-set-variables
 '(diary-number-of-entries 31)
 '(alendar-mark-holidays-flag t)
 '(alendar-weekend-marker 'diary))
(with-eval-after-load-feature calendar
  (define-key calendar-mode-map "f" 'calendar-forward-day)
  (define-key calendar-mode-map "n" 'calendar-forward-day)
  (define-key calendar-mode-map "b" 'calendar-backward-day)
  (add-hook 'today-visible-calendar-hook 'calendar-mark-weekend)
  (add-hook 'today-invisible-calendar-hook 'calendar-mark-weekend))

;; Emacs Lisp mode
(add-hook 'emacs-lisp-mode-hook
          '(lambda ()
             (plist-put develock-max-column-plist 'emacs-lisp-mode 100)))

;; uniquify
(require 'uniquify)
(setq uniquify-buffer-name-style 'post-forward-angle-brackets)

;; カーソル位置の数字をインクリメント
;; http://www.emacswiki.org/emacs/IncrementNumber
;; http://d.hatena.ne.jp/gongoZ/20091222/1261454818
(defun increment-string-as-number (number)
  "Replace progression string of the position of the cursor
by string that added NUMBER.
Interactively, NUMBER is the prefix arg.

examle:
At the cursor string \"12\"

M-x increment-string-as-number ;; replaced by \"13\"
C-u 10 M-x increment-string-as-number ;; replaced by \"22\"

At the cursor string \"-12\"

M-x increment-string-as-number ;; replaced by \"-11\"
C-u 100 M-x increment-string-as-number ;; replaced by \"88\""
  (interactive "P")
  (let ((col (current-column))
        (p (if (integerp number) number 1)))
    (skip-chars-backward "-0123456789")
    (or (looking-at "-?[0123456789]+")
        (error "No number at point"))
      (replace-match
       (number-to-string (+ p (string-to-number (match-string 0)))))
    (move-to-column col)))
(global-set-key (kbd "C-c +") 'increment-string-as-number)

(defun insert-current-date ()
  (interactive)
  (let ((system-time-locale "C"))
    (insert (format-time-string "%a %b %e %Y"))))
(global-set-key (kbd "C-c d") 'insert-current-date)

;; emacsclient
(server-start)


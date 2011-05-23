;; ruby-mode でもEnterでインデントする
(add-hook 'ruby-mode-hook
          '(lambda ()
             (require 'ruby-electric)
             (ruby-electric-mode t)
             (setq default-abbrev-mode nil)
             (define-key ruby-mode-map "\C-m" 'ruby-reindent-then-newline-and-indent)
             (define-key ruby-mode-map "\C-j" 'newline)))
;; ruby-mode で Develock の桁数変更
(plist-put develock-max-column-plist 'ruby-mode 100)

;; Rakefile も ruby-mode になるように
(add-to-list 'auto-mode-alist '("Rakefile$" . ruby-mode))
(add-to-list 'auto-mode-alist '("\\.rake$" . ruby-mode))
;; Gemfile も ruby-mode になるように
(add-to-list 'auto-mode-alist '("Gemfile$" . ruby-mode))

;; ruby-electric-mode 優先順位を最下位にする。[ruby-list:45511]
(let ((rel (assq 'ruby-electric-mode minor-mode-map-alist)))
  (setq minor-mode-map-alist (append
                              (delete rel minor-mode-map-alist)
                              (list rel))))

;; magic comment
;; Ruby1.9から、ファイルの文字コードを明記する必要がある
;; http://d.hatena.ne.jp/rubikitch/20080307/magiccomment
;(defun ruby-insert-magic-comment-if-needed ()
;  "バッファのcoding-systemをもとにmagic commentをつける。"
;  (if (and (eq major-mode 'ruby-mode)
;           (find-multibyte-characters (point-min) (point-max) 1)
;           (eq ruby-m17n-mode t))
;    (save-excursion
;      (goto-char 1)
;      (when (looking-at "^#!")
;        (forward-line 1))
;      (if (re-search-forward "^#.+coding" (point-at-eol) t)
;          (delete-region (point-at-bol) (point-at-eol))
;        (open-line 1))
;      (let* ((coding-system (symbol-name buffer-file-coding-system))
;             (encoding (cond ((string-match "japanese-iso-8bit\\|euc-j" coding-system)
;                              "euc-jp")
;                             ((string-match "shift.jis\\|sjis\\|cp932" coding-system)
;                              "shift_jis")
;                             ((string-match "utf-8" coding-system)
;                              "utf-8"))))
;        (insert (format "# -*- coding: %s -*-" encoding))))
;    (remove-hook 'before-save-hook 'ruby-insert-magic-comment-if-needed)))

;; (add-hook 'before-save-hook 'ruby-insert-magic-comment-if-needed)
;(define-minor-mode ruby-m17n-mode
;  "Add magic comment"
;  ;; initial value
;  nil
;  ;; indicator for the mode line.
;  " M17n"
;  ;; keymap
;  ruby-mode-map
;  (add-hook 'before-save-hook 'ruby-insert-magic-comment-if-needed))

;; flymake for ruby
(require 'flymake)
;; Invoke ruby with '-c' to get syntax checking
(defun flymake-ruby-init ()
  (let* ((temp-file   (flymake-init-create-temp-buffer-copy
                       'flymake-create-temp-inplace))
         (local-file  (file-relative-name
                       temp-file
                       (file-name-directory buffer-file-name))))
    (list "ruby1.9.1" (list "-c" local-file))))
(push '(".+\\.rb$" flymake-ruby-init) flymake-allowed-file-name-masks)
(push '("Rakefile$" flymake-ruby-init) flymake-allowed-file-name-masks)
(push '("^\\(.*\\):\\([0-9]+\\): \\(.*\\)$" 1 2 nil 3) flymake-err-line-patterns)
(add-hook
 'ruby-mode-hook
 '(lambda ()
    ;; Don't want flymake mode for ruby regions in rhtml files
    (if (and (not (null buffer-file-name))
             (file-writable-p (file-name-directory buffer-file-name)))
        (flymake-mode))
    ;; エラー行で C-c d するとエラーの内容をミニバッファで表示する
    (define-key ruby-mode-map "\C-cd" 'credmp/flymake-display-err-minibuf)))

(defun credmp/flymake-display-err-minibuf ()
  "Displays the error/warning for the current line in the minibuffer"
  (interactive)
  (let* ((line-no             (flymake-current-line-no))
         (line-err-info-list  (nth 0 (flymake-find-err-info flymake-err-info line-no)))
         (count               (length line-err-info-list))
         )
    (while (> count 0)
      (when line-err-info-list
        (let* ((file       (flymake-ler-file (nth (1- count) line-err-info-list)))
               (full-file  (flymake-ler-full-file (nth (1- count) line-err-info-list)))
               (text (flymake-ler-text (nth (1- count) line-err-info-list)))
               (line       (flymake-ler-line (nth (1- count) line-err-info-list))))
          (message "[%s] %s" line text)
          )
        )
      (setq count (1- count)))))



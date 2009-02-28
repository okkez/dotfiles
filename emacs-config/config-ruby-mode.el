;; ruby-mode でもEnterでインデントする
(add-hook 'ruby-mode-hook
          '(lambda () (setq default-abbrev-mode nil)
             (define-key ruby-mode-map "\C-m" 'ruby-reindent-then-newline-and-indent)
             (define-key ruby-mode-map "\C-j" 'newline)))
;; ruby-mode で Develock の桁数変更
(plist-put develock-max-column-plist 'ruby-mode 100)

;; magic comment
;; Ruby1.9から、ファイルの文字コードを明記する必要がある
;; http://d.hatena.ne.jp/rubikitch/20080307/magiccomment
(defun ruby-insert-magic-comment-if-needed ()
  "バッファのcoding-systemをもとにmagic commentをつける。"
  (when (and (eq major-mode 'ruby-mode)
             (find-multibyte-characters (point-min) (point-max) 1))
    (save-excursion
      (goto-char 1)
      (when (looking-at "^#!")
        (forward-line 1))
      (if (re-search-forward "^#.+coding" (point-at-eol) t)
          (delete-region (point-at-bol) (point-at-eol))
        (open-line 1))
      (let* ((coding-system (symbol-name buffer-file-coding-system))
             (encoding (cond ((string-match "japanese-iso-8bit\\|euc-j" coding-system)
                              "euc-jp")
                             ((string-match "shift.jis\\|sjis\\|cp932" coding-system)
                              "shift_jis")
                             ((string-match "utf-8" coding-system)
                              "utf-8"))))
        (insert (format "# -*- coding: %s -*-" encoding))))))

(add-hook 'before-save-hook 'ruby-insert-magic-comment-if-needed)

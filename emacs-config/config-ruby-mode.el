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
;; *.gemspec も ruby-mode になるように
(add-to-list 'auto-mode-alist '("\\.gemspec$" . ruby-mode))

;; ruby-electric-mode 優先順位を最下位にする。[ruby-list:45511]
(let ((rel (assq 'ruby-electric-mode minor-mode-map-alist)))
  (setq minor-mode-map-alist (append
                              (delete rel minor-mode-map-alist)
                              (list rel))))

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



(el-get-bundle ruby-mode-trunk
  :features ruby-mode)
(el-get-bundle ruby-electric-trunk
  :features ruby-electric)
(el-get-bundle rbenv
  (global-rbenv-mode t))
;(require 'ruby-mode)
;(require 'ruby-electric)
(autoload 'ruby-electric-mode "ruby-electric" nil t)
(add-hook 'ruby-mode-hook
          (lambda ()
            (ruby-electric-mode t)
            (define-key ruby-mode-map (kbd "RET") 'newline-and-indent)
            (setq ruby-deep-indent-paren-style nil)
            (defadvice ruby-indent-line (after unindent-closing-paren activate)
              (let ((column (current-column))
                    indent offset)
                (save-excursion
                  (back-to-indentation)
                  (let ((state (syntax-ppss)))
                    (setq offset (- column (current-column)))
                    (when (and (eq (char-after) ?\))
                               (not (zerop (car state))))
                      (goto-char (cadr state))
                      (setq indent (current-indentation)))))
                (when indent
                  (indent-line-to indent)
                  (when (> offset 0) (forward-char offset)))))))
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

(add-hook 'ruby-mode-hook 'flycheck-mode)


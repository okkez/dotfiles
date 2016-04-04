(el-get-bundle enh-ruby-mode
  :features enh-ruby-mode
  (setq enh-ruby-add-encoding-comment-on-save nil))
(el-get-bundle ruby-electric-trunk
  :features ruby-electric)
(el-get-bundle rbenv
  (global-rbenv-mode t))
;(require 'ruby-mode)
;(require 'ruby-electric)
(autoload 'ruby-electric-mode "ruby-electric" nil t)
(defun setup-enh-ruby-mode ()
  (setq enh-ruby-deep-indent-paren nil)
  (define-key enh-ruby-mode-map (kbd "RET") 'newline-and-indent)
  (ruby-electric-mode t))

(defun setup-enh-ruby-mode-faces ()
  (set-face-attribute 'enh-ruby-heredoc-delimiter-face nil
                      :foreground nil
                      :background nil
                      :inherit 'font-lock-string-face)
  (set-face-attribute 'enh-ruby-op-face nil
                      :foreground nil
                      :background nil
                      :inherit 'default)
  (set-face-attribute 'enh-ruby-regexp-delimiter-face nil
                      :foreground nil
                      :background nil
                      :inherit 'font-lock-string-face)
  (set-face-attribute 'enh-ruby-regexp-face nil
                      :foreground nil
                      :background nil
                      :inherit 'font-lock-string-face)
  (set-face-attribute 'enh-ruby-string-delimiter-face nil
                      :foreground nil
                      :background nil
                      :inherit 'font-lock-string-face))

;; enh-ruby-mode で Develock の桁数変更
(plist-put develock-max-column-plist 'enh-ruby-mode 100)

;; Rakefile も enh-ruby-mode になるように
(add-to-list 'auto-mode-alist '("Rakefile$" . enh-ruby-mode))
(add-to-list 'auto-mode-alist '("\\.rake$" . enh-ruby-mode))
;; Gemfile も enh-ruby-mode になるように
(add-to-list 'auto-mode-alist '("Gemfile$" . enh-ruby-mode))
;; *.gemspec も enh-ruby-mode になるように
(add-to-list 'auto-mode-alist '("\\.gemspec$" . enh-ruby-mode))

;; ruby-electric-mode 優先順位を最下位にする。[ruby-list:45511]
(let ((rel (assq 'ruby-electric-mode minor-mode-map-alist)))
  (setq minor-mode-map-alist (append
                              (delete rel minor-mode-map-alist)
                              (list rel))))

(add-hook 'enh-ruby-mode-hook 'setup-enh-ruby-mode)
(add-hook 'enh-ruby-mode-hook 'setup-enh-ruby-mode-faces)
(add-hook 'enh-ruby-mode-hook 'flycheck-mode)

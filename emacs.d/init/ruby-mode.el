(require 'ruby-mode)
(el-get-bundle enh-ruby-mode
  :features enh-ruby-mode
  (custom-set-variables
   '(enh-ruby-deep-indent-paren nil)
   '(enh-ruby-use-ruby-mode-show-parens-config t)
   '(enh-ruby-add-encoding-comment-on-save nil)
   '(flycheck-disabled-checkers '(ruby-reek))))
(el-get-bundle ruby-end)
(el-get-bundle rbenv
  (global-rbenv-mode t))

(defun setup-enh-ruby-mode ()
  (define-key enh-ruby-mode-map (kbd "RET") 'newline-and-indent)
  ;(ruby-electric-mode t)
  ;; enh-ruby-mode で Develock の桁数変更
  (plist-put develock-max-column-plist 'enh-ruby-mode 100))

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
(add-hook 'enh-ruby-mode-hook 'flycheck-mode)

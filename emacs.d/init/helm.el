(eval-when-compile (require 'cl))
(el-get-bundle helm
  (require 'helm)
  (require 'helm-buffers)
  (require 'helm-files)
  (require 'magit)
(define-key global-map (kbd "C-;") 'helm-mini)
(define-key global-map (kbd "M-x") 'helm-M-x)
(define-key global-map (kbd "C-x C-f") 'helm-find-files)
(define-key global-map (kbd "C-x b") 'helm-mini)

(helm-mode +1)
(helm-migemo-mode +1)
(custom-set-variables
 '(helm-command-map-prefix-key "\C-z")
 '(helm-ff-smart-completion nil)
 '(helm-ff-auto-update-initial-value nil)
 '(helm-buffer-max-length 30)
 '(helm-mini-default-sources '(helm-source-buffers-list
                               helm-source-recentf
                               helm-source-files-in-current-dir
                               helm-source-buffer-not-found)))

(define-key helm-find-files-map (kbd "C-h") nil)
(define-key helm-map (kbd "C-h") nil)
(set-face-background 'helm-selection "#104e8b")
(set-face-foreground 'helm-source-header "gray")

(defvar helm-c-source-git-commit-messages
  (helm-build-in-buffer-source "Git Commit Messages"
    :init #'helm-c-git-commit-messages-init
    :action (helm-make-actions
             "Insert" (lambda (candidate)
                        (insert
                         (replace-regexp-in-string "\0" "\n" candidate))))
    :real-to-display #'helm-c-git-commit-messages-real-to-display
    :multiline t
    :migemo t))

(defun helm-git-commit-messages ()
  "`helm' for git commit messages."
  (interactive)
  (helm-other-buffer
   '(helm-c-source-git-commit-messages)
   "*helm commit messages*"))

(defun helm-c-git-commit-messages-init ()
  (with-temp-buffer
    (call-process-shell-command
     "git log --format=\"%x00%B\" | tr '\\n\\000\' '\\000\\n' | sed -e '/^$/d' -e 's/\\x0\\+$//'"
     nil (current-buffer))
    (helm-init-candidates-in-buffer 'global (buffer-string))))

(defun helm-c-git-commit-messages-real-to-display (candidate)
    (replace-regexp-in-string "\0" "\n" candidate))

(defun magit-enable-helm ()
  ;; 過去のコミットメッセージを挿入
  (define-key git-commit-mode-map
    (kbd "C-c i") 'helm-git-commit-messages))
(add-hook 'magit-mode-hook
          'magit-enable-helm)

)


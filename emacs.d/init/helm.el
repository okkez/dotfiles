(eval-when-compile (require 'cl))
(el-get-bundle helm
  (require 'helm)
  (require 'helm-buffers)
  (require 'helm-files))

(define-key global-map (kbd "C-;") 'helm-mini)
(define-key global-map (kbd "M-x") 'helm-M-x)
(define-key global-map (kbd "C-x C-f") 'helm-find-files)
(define-key global-map (kbd "C-x b") 'helm-mini)
(define-key global-map (kbd "C-:") 'helm-git-project)

(helm-mode 1)
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

(el-get-bundle helm-gtags
  (require 'helm-gtags))
(add-hook 'c-mode-hook 'helm-gtags-mode)
(add-hook 'helm-gtags-mode-hook
          '(lambda ()
             (local-set-key (kbd "M-.") 'helm-gtags-find-tag)
             (local-set-key (kbd "M-,") 'helm-gtags-find-rtag)
             (local-set-key (kbd "M-?") 'helm-gtags-find-symbol)
             (local-set-key (kbd "M-*") 'helm-gtags-pop-stack)))

(el-get-bundle helm-migemo
  (require 'helm-migemo))
(el-get-bundle helm-swoop
  (require 'helm-swoop))

;;; http://d.hatena.ne.jp/syohex/20120718/1342620627
;; List files in git repos
(defun helm-c-sources-git-project-for (pwd)
  (loop for elt in
        '(("Modified files" . "--modified")
          ("Untracked files" . "--others --exclude-standard")
          ("All controlled files in this project" . nil))
        for title  = (format "%s (%s)" (car elt) pwd)
        for option = (cdr elt)
        for cmd    = (format "git ls-files %s" (or option ""))
        collect
        `((name . ,title)
          (init . (lambda ()
                    (unless (and (not ,option) (helm-candidate-buffer))
                      (with-current-buffer (helm-candidate-buffer 'global)
                        (call-process-shell-command ,cmd nil t nil)))))
          (candidates-in-buffer)
          (type . file))))

(defun helm-git-project-topdir ()
  (file-name-as-directory
   (replace-regexp-in-string
    "\n" ""
    (shell-command-to-string "git rev-parse --show-toplevel"))))

(defun helm-git-project ()
  (interactive)
  (let ((topdir (helm-git-project-topdir)))
    (if (file-directory-p topdir)
        (let* ((default-directory topdir)
               (sources (helm-c-sources-git-project-for default-directory)))
          (helm-other-buffer sources
                             (format "*helm git project in %s*" default-directory)))
      (helm-other-buffer nil
                         "I'm not in Git Repository!!"))))


(defun string-strip (string)
  (replace-regexp-in-string "\\`[ \r\n]*\\|[ \r\n]*\\'" "" string))

(defvar helm-c-source-git-commit-messages
  '((name . "Git Commit Messages")
    (init . helm-c-git-commit-messages-init)
    (action . (("Insert" . (lambda (candidate)
                             (insert
                              (replace-regexp-in-string "\0" "\n" candidate))))))
    (real-to-display . helm-c-git-commit-messages-real-to-display)
    (migemo)
    (multiline)
    (candidates-in-buffer)))

(defun helm-c-git-commit-messages-init ()
  (with-current-buffer (helm-candidate-buffer 'global)
    (call-process-shell-command
     "git log --format=\"%x00%B\" | tr '\\n\\000\' '\\000\\n' | sed -e '/^$/d' -e 's/\\x0\\+$//'"
     nil (current-buffer))))

(defun helm-git-commit-messages ()
  "`helm' for git commit messages."
  (interactive)
  (helm-other-buffer 'helm-c-source-git-commit-messages
                         "*helm commit messages*"))

(defun helm-c-git-commit-messages-real-to-display (candidate)
    (replace-regexp-in-string "\0" "\n" candidate))

(defun magit-enable-helm ()
  ;; 過去のコミットメッセージを挿入
  (define-key magit-log-edit-mode-map
    (kbd "C-c i") 'helm-git-commit-messages))
(add-hook 'magit-mode-hook
          'magit-enable-helm)

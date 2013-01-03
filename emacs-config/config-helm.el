(eval-when-compile (require 'cl))
(require 'helm)
(require 'helm-buffers)
(require 'helm-files)

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

(define-key global-map (kbd "C-:") 'helm-git-project)

(defun string-strip (string)
  (replace-regexp-in-string "\\`[ \r\n]*\\|[ \r\n]*\\'" "" string))

(defvar helm-c-source-git-commit-messages
  '((name . "Git Commit Messages")
    (candidates . helm-c-git-commit-messages-candidates)
    (action . (("Insert" . (lambda (str) (insert str)))))
    (migemo)
    (multiline))
  "Source for browsing and inserting commit messages.")

(defun helm-c-git-commit-messages-candidates ()
  (let* ((messages-string
          (shell-command-to-string "\\git \\log -50 --format=\"%x00%B\""))
         (raw-messages (string-to-list (split-string messages-string "\0")))
         (messages (mapcar (lambda (raw-message)
                             (string-strip raw-message))
                           raw-messages)))
    (remove-if (lambda (message)
                 (string-equal message ""))
               messages)))

(defun helm-git-commit-messages ()
  "`helm' for git commit messages."
  (interactive)
  (helm-other-buffer 'helm-c-source-git-commit-messages
                         "*helm commit messages*"))

(defun magit-enable-helm ()
  ;; 過去のコミットメッセージを挿入
  (define-key magit-log-edit-mode-map
    (kbd "C-c i") 'helm-git-commit-messages))
(add-hook 'magit-mode-hook
          'magit-enable-helm)

(defun my-helm-mini ()
  "My Helm mini source"
  (interactive)
  (helm-other-buffer '(helm-c-source-buffers-list
                       helm-c-source-recentf
                       helm-c-source-files-in-current-dir
                       helm-c-source-buffer-not-found)
                     "*my helm mini*"))

(set-face-background 'helm-selection "#0a2832")

(helm-mode 1)
(custom-set-variables
 '(helm-command-map-prefix-key "\C-z")
 '(helm-ff-smart-completion nil)
 '(helm-ff-auto-update-initial-value nil))

(define-key global-map (kbd "C-;") 'my-helm-mini)
(define-key global-map (kbd "M-x") 'helm-M-x)
(define-key global-map (kbd "C-x C-f") 'helm-find-files)
(define-key global-map (kbd "C-x b") 'my-helm-mini)
(define-key helm-find-files-map (kbd "C-h") nil)
(define-key helm-map (kbd "C-h") nil)


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
 '(helm-command-map-prefix-key "\C-z"))
;(define-key helm-command-map (kbd "C-x C-f") 'helm-filelist+)
(define-key global-map (kbd "C-;") 'my-helm-mini)
(define-key global-map (kbd "M-x") 'helm-M-x)
;(define-key global-map (kbd "C-x C-f") 'helm-filelist+)
(define-key global-map (kbd "C-x b") 'my-helm-mini)


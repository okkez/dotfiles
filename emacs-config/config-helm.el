(eval-when-compile (require 'cl))
(require 'helm)
(require 'helm-buffers)
(require 'helm-files)

(defun my-helm-mini ()
  "My Helm mini source"
  (interactive)
  (helm-other-buffer '(helm-c-source-buffers-list
                       helm-c-source-recentf
                       helm-c-source-files-in-current-dir
                       helm-c-source-buffer-not-found)
                     "*my helm mini*"))

(helm-mode 1)
(custom-set-variables
 '(helm-command-map-prefix-key "\C-z"))
;(define-key helm-command-map (kbd "C-x C-f") 'helm-filelist+)
(define-key global-map (kbd "C-;") 'my-helm-mini)
(define-key global-map (kbd "M-x") 'helm-M-x)
;(define-key global-map (kbd "C-x C-f") 'helm-filelist+)
(define-key global-map (kbd "C-x b") 'my-helm-mini)


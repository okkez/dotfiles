(require 'anything)
(require 'anything-config)

;; candidates-file  plug-in
(defun anything-compile-source--candidates-file (source)
  (if (assoc-default 'candidates-file source)
      `((init acf-init
              ,@(let ((orig-init (assoc-default 'init source)))
                  (cond ((null orig-init) nil)
                        ((functionp orig-init) (list orig-init))
                        (t orig-init))))
        (candidates-in-buffer)
        ,@source)
    source))
(add-to-list 'anything-compile-source-functions
             'anything-compile-source--candidates-file)

(defun acf-init ()
  (destructuring-bind (file &optional updating)
      (anything-mklist (anything-attr 'candidates-file))
    (with-current-buffer (anything-candidate-buffer (find-file-noselect file))
      (when updating
        (buffer-disable-undo)
        (font-lock-mode -1)
        (auto-revert-mode 1)))))

(defvar anything-c-source-home-directory
  '((name . "Home directory")
    ;; /var/local/db/home.filelist にホームディレクトリのファイル名が1行につきひとつ格納されている
    (candidates-file "/var/local/db/home.filelist" updating)
    (requires-pattern . 5)
    (candidate-number-limit . 20)
    (type . file)))

; (defvar anything-c-source-find-library
;   '((name . "Elisp libraries")
;     ;; これは全Emacs Lispファイル
;     (candidates-file "/log/elisp.filelist" updating)
;     (requires-pattern . 4)
;     (type . file)
;     (major-mode emacs-lisp-mode)))

(setq anything-sources
      '(anything-c-source-buffers+
        anything-c-source-colors
        anything-c-source-recentf
        anything-c-source-man-pages
        anything-c-source-emacs-commands
        anything-c-source-emacs-functions
        anything-c-source-files-in-current-dir
        anything-c-source-home-directory
        ))

(define-key global-map (kbd "C-z l") 'anything)
(require 'anything-startup)

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

(require 'ac-anything)
(define-key ac-complete-mode-map (kbd "C-:") 'ac-complete-with-anything)


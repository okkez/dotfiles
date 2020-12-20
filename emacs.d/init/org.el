;;; org-mode
;;; http://d.hatena.ne.jp/rubikitch/20090121
(el-get-bundle org
  :depends (org-bullets)
  (custom-set-variables
   '(browse-at-remote-prefer-symbolic nil)
   '(org-startup-truncated nil)
   '(org-return-follows-link t)
   '(org-src-fontify-natively t)
   '(org-directory "~/Nextcloud/memo/")
   '(org-default-notes-file (concat org-directory "agenda.org"))
   ;; TODO の状態
   '(org-todo-keywords '("TODO" "Wait" "DONE"))
   '(org-todo-interpretation 'sequence)
   ;; Capture templates for code-reading
   '(org-capture-templates
     '(("code-link"
        "Store the code-reading notes with GitHub and file links for the current cursor position."
        plain
        (function org-code-capture--find-store-point)
        "%^{Summary}\n%(with-current-buffer (org-capture-get :original-buffer) (browse-at-remote-get-url))\n# %a"
        :immediate-finish t)
       ("just-code-link"
        "Immediately store GitHub and file links for the current cursor position to the current code-reading notes."
        plain
        (function org-code-capture--find-store-point)
        "%(with-current-buffer (org-capture-get :original-buffer) (browse-at-remote-get-url))\n# %a"
        :immediate-finish t)
       ("t" "Todo" entry (file+headline org-default-notes-file "Inbox")
        "** TODO %?\n   %i\n   %a\n   %t")
       ("b" "Bug" entry (file+headline org-default-notes-file "Inbox")
        "** TODO %?   :bug:\n   %i\n   %a\n   %t")
       ("i" "Idea" entry (file+headline org-default-notes-file "New Ideas")
        "** %?\n   %i\n   %a\n   %t")))
   ;; '(org-bullets-bullet-list ("" "" "" "" "" "" "" ""))
   )

  (custom-set-faces
   '(org-level-1 ((t (:foreground "#859900"))))
   '(org-level-2 ((t (:foreground "#859900"))))
   '(org-level-3 ((t (:foreground "#859900"))))
   '(org-level-4 ((t (:foreground "#859900"))))
   '(org-level-5 ((t (:foreground "#859900"))))
   '(org-level-6 ((t (:foreground "#859900"))))
   '(org-level-7 ((t (:foreground "#859900"))))
   '(org-level-8 ((t (:foreground "#859900"))))
   '(org-link ((t (:foreground "#839496" :weight normal)))))

  (add-to-list 'auto-mode-alist '("\\.org$" . org-mode))
  (add-hook 'org-mode-hook '(lambda ()
                              (org-bullets-mode 1)
                              (key-chord-define-local "cx" 'org-toggle-checkbox)))
  (with-eval-after-load-feature 'org
    (require 'ox-md))

  ;;; start https://ladicle.com/post/20200625_123915/
  (defconst okkez/org-journal-dir "~/Nextcloud/org/journal/")
  (defconst okkez/org-journal-file-format (concat okkez/org-journal-dir "%Y-%m-%d.org"))

  (defvar org-code-capture--store-file "")
  (defvar org-code-capture--store-header "")

  ;; This function is used in combination with a coding template of org-capture.
  (defun org-code-capture--store-here ()
    "Register current subtree as a capture point."
    (interactive)
    (setq org-code-capture--store-file (buffer-file-name))
    (setq org-code-capture--store-header (nth 4 (org-heading-components))))

  ;; This function is used with a capture-template for (function) type.
  ;; Look for headline that registered at `org-code-capture--store-header`.
  ;; If the matching subtree is not found, create a new Capture tree.
  (defun org-code-capture--find-store-point ()
    "Find registered capture point and move the cursor to it."
    (let ((filename (if (string= "" org-code-capture--store-file)
                        (format-time-string okkez/org-journal-file-format)
                      org-code-capture--store-file)))
      (set-buffer (org-capture-target-buffer filename)))
    (goto-char (point-min))
    (unless (derived-mode-p 'org-mode)
      (error
       "Target buffer \"%s\" for org-code-capture--find-store-file should be in Org mode"
       (current-buffer))
      (current-buffer))
    (if (re-search-forward org-code-capture--store-header nil t)
        (goto-char (point-at-bol))
      (goto-char (point-max))
      (or (bolp) (insert "\n"))
      (insert "* Capture\n")
      (beginning-of-line 0))
    (org-end-of-subtree))
  ;;; end https://ladicle.com/post/20200625_123915/

  ;; agenda
  (define-key global-map (kbd "C-c a") 'org-agenda)

  ;; key-chord
  ; (key-chord-define-global "op" 'org-remember)

  )

;; ~/memo/agenda.org を開く
(define-key global-map (kbd "C-z a")
  '(lambda () (interactive) (find-file "~/Nextcloud/memo/agenda.org")))
;; ~/Nextcloud/memo/standup-meeting.org を開く
(define-key global-map (kbd "C-z s")
  '(lambda () (interactive) (find-file "~/Nextcloud/memo/standup-meeting.org")))
;; ~/Nextcloud/memo/cheat-sheet.org を開く
(define-key global-map (kbd "C-z c")
  '(lambda () (interactive) (find-file "~/Nextcloud/memo/cheat-sheet.org")))

;; 祝日を表示する 不要？
;(setq org-agenda-files (list org-default-notes-file
;                             (format-time-string "~/memo/holidays.%Y.org")))

(defun insert-next-date ()
  (let* ((time (decode-time (current-time))))
    (setf (elt time 3) (+ (elt time 3) 1))
    (format-time-string "%Y-%m-%d(%a)" (apply 'encode-time time))))

(defun insert-this-date ()
  (let* ((time (decode-time (current-time))))
    (format-time-string "%Y-%m-%d(%a)" (apply 'encode-time time))))

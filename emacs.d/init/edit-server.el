(el-get-bundle! edit-server
  ;; edit Chromium's textarea with emacs
  (progn
    (setq edit-server-port 19292)
    (edit-server-start)))

;; for Gmail
(el-get-bundle! edit-server-htmlize
  (add-hook 'edit-server-start-hook 'edit-server-maybe-dehtmlize-buffer)
  (add-hook 'edit-server-done-hook  'edit-server-maybe-htmlize-buffer))

(el-get-bundle! atomic-chrome
  (atomic-chrome-start-server))

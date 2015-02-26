;; rabbit-mode
(el-get-bundle rabbit-mode
  (with-eval-after-load 'rabbit-mode
    (add-to-list 'auto-mode-alist '("\\.\\(rbt\\|rab\\)$" . rabbit-mode))))

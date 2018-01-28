;; rabbit-mode
(el-get-bundle rabbit-mode
  (with-eval-after-load-feature 'rabbit-mode
    (add-to-list 'auto-mode-alist '("\\.\\(rbt\\|rab\\)$" . rabbit-mode))))

(el-get-bundle company-mode
  (global-company-mode t)
  (with-eval-after-load-feature 'company
    (custom-set-variables
     '(company-idle-delay nil)
     '(company-selection-wrap-around t))

    (global-set-key (kbd "C-M-i") 'company-complete)

    ;; C-n, C-pで補完候補を次/前の候補を選択
    (define-key company-active-map (kbd "M-n") nil)
    (define-key company-active-map (kbd "M-p") nil)
    (define-key company-active-map (kbd "C-n") 'company-select-next)
    (define-key company-active-map (kbd "C-p") 'company-select-previous)
    (define-key company-search-map (kbd "C-n") 'company-select-next)
    (define-key company-search-map (kbd "C-p") 'company-select-previous)

    ;; C-sで絞り込む
    (define-key company-active-map (kbd "C-s") 'company-filter-candidates)

    ;; TABで候補を設定
    (define-key company-active-map (kbd "C-i") 'company-complete-common-or-cycle)
    (define-key company-active-map (kbd "<tab>") 'company-complete-common-or-cycle)

    ;; ドキュメントの表示方法を変更
    (define-key company-active-map (kbd "C-h") nil)
    (define-key company-active-map (kbd "C-S-h") 'company-show-doc-buffer)

    ;; 各種メジャーモードでも C-M-iで company-modeの補完を使う
    (define-key emacs-lisp-mode-map (kbd "C-M-i") 'company-complete)
    ))

(el-get-bundle company-quickhelp
  (custom-set-variables
   '(company-quickhelp-mode t)))

(el-get-bundle company-emoji
  (add-to-list 'company-backends 'company-emoji))

(el-get-bundle tigersoldier/company-lsp
  (with-eval-after-load-feature 'company-mode
    (add-to-list 'company-backends 'company-lsp)))

;; lookup.el
(autoload 'lookup "lookup" nil t)
(autoload 'lookup-region "lookup" nil t)
(autoload 'lookup-pattern "lookup" nil t)
(autoload 'lookup-word "lookup" nil t)
(with-eval-after-load 'lookup
  (setq lookup-enable-splash nil)
  ;;; lookup 用 search-agents 定義
  (setq lookup-search-agents '(
                               (ndeb "~/.dic/OALD_7") (ndspell)
                               ;(ndeb "~/.dic/readers") (ndspell)
                               ;(ndeb "~/.dic/EIJIRO77") (ndspell)
                               ;(ndeb "~/.dic/ROGET") (ndspell)
                               ;(ndeb "~/.dic/mypaedia") (ndspell)
                               ;(ndtp "localhost") (ndspell)
                               )))

;; 起動するキーの設定
(define-key global-map (kbd "C-x l")   'lookup)
(define-key global-map (kbd "C-x y")   'lookup-region)
(define-key global-map (kbd "C-x C-y") 'lookup-pattern)

;; マウスで起動する場合
;(global-set-key [S-mouse-1] 'mouse-set-point)
;(global-set-key [S-down-mouse-1] 'lookup-mouse-drag-region)
;(global-set-key [S-drag-mouse-1] 'lookup-mouse-set-region)
;(global-set-key [S-double-mouse-1] 'lookup-mouse-set-point)
;(autoload 'lookup-mouse-drag-region "lookup-mouse" nil t)

;; ;; autolookup
;; (setq auto-lookup-backend 'lookup)
;; (autoload 'auto-lookup-mode "autolookup" "" t)
;; (autoload 'global-auto-lookup-mode "autolookup" "" t)




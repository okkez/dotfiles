;; lookup.el
(autoload 'lookup "lookup" nil t)
(autoload 'lookup-region "lookup" nil t)
(autoload 'lookup-pattern "lookup" nil t)
(autoload 'lookup-word "lookup" nil t)
(setq lookup-enable-splash nil)

;; 起動するキーの設定
(define-key ctl-x-map "l" 'lookup)              ; C-x l - lookup
(define-key ctl-x-map "y" 'lookup-region)       ; C-x y - lookup-region
(define-key ctl-x-map "\C-y" 'lookup-pattern)   ; C-x C-y - lookup-pattern

;; マウスで起動する場合
;(global-set-key [S-mouse-1] 'mouse-set-point)
;(global-set-key [S-down-mouse-1] 'lookup-mouse-drag-region)
;(global-set-key [S-drag-mouse-1] 'lookup-mouse-set-region)
;(global-set-key [S-double-mouse-1] 'lookup-mouse-set-point)
;(autoload 'lookup-mouse-drag-region "lookup-mouse" nil t)

;; autolookup
(setq auto-lookup-backend 'lookup)
(autoload 'auto-lookup-mode "autolookup" "" t)
(autoload 'global-auto-lookup-mode "autolookup" "" t)

;;; lookup 用 search-agents 定義
(setq lookup-search-agents '(
                             (ndeb "~/.dic/OALD_7")(ndspell)
                             ;(ndeb "~/.dic/readers")(ndspell)
                             ;(ndeb "~/.dic/EIJIRO77")(ndspell)
                             ;(ndeb "~/.dic/ROGET")(ndspell)
                             ;(ndeb "~/.dic/mypaedia")(ndspell)
                             ;(ndtp "localhost")(ndspell)
                             ))


; ---- language-env DON'T MODIFY THIS LINE!
(setq debug-on-error t)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 日本語表示の設定
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(if (featurep 'mule)
    (progn
      (set-language-environment "Japanese")
      (prefer-coding-system 'utf-8-unix)
      (set-keyboard-coding-system 'utf-8-unix)
      (if (not window-system) (set-terminal-coding-system 'utf-8-unix))
      ;;
      ))
; 日本語 info が文字化けしないように
(auto-compression-mode t)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Xでのカラー表示
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(require 'font-lock)
(if (not (featurep 'xemacs))
    (global-font-lock-mode t))

;; tab-width
(setq tab-width 4)

(setq-default indent-tabs-mode nil)

;; stop bell
;(setq visible-bell t)
(setq ring-bell-function 'ignore)
(el-get-bundle tarao/with-eval-after-load-feature-el)

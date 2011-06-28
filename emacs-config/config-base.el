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
; xemacs の shell-mode で 日本語 EUC が使えるようにする
(if (featurep 'xemacs)
    (add-hook 'shell-mode-hook
              (function
               (lambda () (set-buffer-process-coding-system 'utf-8-unix 'utf-8-unix)))))
; 日本語 grep
(if (file-exists-p "/usr/bin/lgrep")
    (setq grep-command "lgrep -n "))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 漢字変換 (Anthy) の設定
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;(set-input-method "japanese-anthy")
;(load-library "anthy")
;(global-set-key "\C-\\" 'anthy-mode)
;(setq default-input-method "japanese-anthy")
;(toggle-input-method nil)
;; UIM の設定
;(require 'uim)
;(require 'uim-leim)
;(setq default-input-method "japanese-anthy-uim")
;(global-set-key "\C-\\" 'uim-mode)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Xでのカラー表示
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(require 'font-lock)
(if (not (featurep 'xemacs))
    (global-font-lock-mode t))

;; tab-width
(setq default-tab-width 4)

(setq-default indent-tabs-mode nil)

;; stop bell
;(setq visible-bell t)
(setq ring-bell-function 'ignore)

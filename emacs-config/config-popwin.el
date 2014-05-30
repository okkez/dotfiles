(require 'popwin)
(setq display-buffer-function 'popwin:display-buffer)
(setq popwin:close-popup-window-timer-interval 0.05)

(push "*Backtrace*" popwin:special-display-config)

;; vc
(push "*vc-diff*" popwin:special-display-config)
(push "*vc-change-log*" popwin:special-display-config)

;; ag
(push "*ag*" popwin:special-display-config)

;; helm
;(setq helm-samewindow nil)
;(push '("\\*[Hh]elm"
;        :regexp t
;        :position right
;        :width 100)
;      popwin:special-display-config)
;(push '("*my helm mini*"
;        :position right
;        :width 100)
;      popwin:special-display-config)
;

;; po-mode
(push '("\\*.*\\.po\\*"
       :regexp t
       :position bottom
       :height 20)
     popwin:special-display-config)

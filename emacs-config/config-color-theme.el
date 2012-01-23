;; color-theme
(require 'color-theme)
(color-theme-initialize)
;(color-theme-dark-laptop)
(require 'color-theme-solarized)
(setq solarized-termcolors 256)     ; 16    , 256
(setq solarized-degrade nil)        ; nil   , t
(setq solarized-bold t)             ; t     , nil
(setq solarized-underline t)        ; t     , nil
(setq solarized-italic t)           ; t     , nil
(setq solarized-contrast 'normal)   ; normal, high, low
(setq solarized-visibility 'normal) ; normal, high, low
(color-theme-solarized-dark)

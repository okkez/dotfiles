;; config-hiki.el

(setq hiki-site-list '(
                       ("日本 Ruby の会" "http://jp.rubyist.net/")
                       ;("Fuga-Hiki" "http://example.jp/hiki/hiki.cgi")
                       ))
(autoload 'hiki-edit     "hiki-mode" nil t)
(autoload 'hiki-edit-url "hiki-mode" nil t)
(autoload 'hiki-index     "hiki-mode" nil t)
; (require 'hiki-mode)

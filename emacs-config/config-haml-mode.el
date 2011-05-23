;; haml-mode
;; git://github.com/nex3/haml.git
(add-to-list 'load-path "~/.elisp/haml-mode")
(add-to-list 'load-path "~/.elisp/sass-mode")
(require 'haml-mode)
(require 'sass-mode)

(add-to-list 'ac-modes 'haml-mode)
(add-to-list 'ac-modes 'sass-mode)
(add-hook 'sass-mode-hook 'ac-css-keywords-setup)

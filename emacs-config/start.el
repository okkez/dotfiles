;;; start.el
;;;

(defvar my-emacs-config-dir (expand-file-name "~/dotfiles/emacs-config"))

(defun my-emacs-load-config (name)
  "Load NAME as a configure file in `my-emacs-config-dir'.
Assume that the filename should be config-NAME.el."
  (load (concat my-emacs-config-dir "/config-" name ".el")))

(defvar my-emacs-pre-config '("path"))
(defvar my-emacs-misc-config
  '("anthy"
    ;"auto-insert-tkld"
    ;"auto-save"
    "base"
    "c-mode"
    ;"cedet"
    ;"clmemo"
    "color-theme"
    ;"darcsum"
    ;"ecb"
    ;"flymake"
    ;"haskell-mode"
    "hiki"
    "html-mode"
    ;"ibuffer"
    "iswitchb"
    ;"japanese"
    "js2-mode"
    "lookup"
    "mcomplete"
    ;"migemo"
    ;"muse"
    ;"paren"
    ;"planner"
    "rabbit-mode"
    "rcodetools"
    ;"remember"
    ;"riece"
    "ruby-mode"
    "rails"
    "scheme"
    ;"smart-compile"
    ;"tdiary"
    ;"yatex"
    ))
(defvar my-emacs-post-config '("misc" "key"))
(defvar my-emacs-config
  (append nil my-emacs-pre-config my-emacs-misc-config my-emacs-post-config))

(mapcar 'my-emacs-load-config my-emacs-config)


;(setq Info-directory-list '( "~/share/info" "/usr/local/share/info" 
;                             "/sw/share/info" "/usr/share/info"))


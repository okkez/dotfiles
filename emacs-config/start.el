;;; start.el
;;;

(defvar my-emacs-config-dir (expand-file-name "~/dotfiles/emacs-config"))

(defun my-emacs-load-config (name)
  "Load NAME as a configure file in `my-emacs-config-dir'.
Assume that the filename should be config-NAME.el."
  (load (concat my-emacs-config-dir "/config-" name ".el")))

(defvar my-emacs-pre-config '("path" "key"))
(defvar my-emacs-misc-config
  '("anthy"
    "install-elisp"
    "auto-install"
    "auto-complete"
    "anything"
    ;"auto-insert-tkld"
    ;"auto-save"
    "base"
    "c-mode"
    ;"cedet"
    ;"clmemo"
    "color-theme"
    "css-mode"
    ;"darcsum"
    ;"ecb"
    ;"flymake"
    ;"haskell-mode"
    "key-chord"
    "hiki"
    "haml-mode"
    "html-mode"
    ;"ibuffer"
    ;"iswitchb"
    ;"japanese"
    "js2-mode"
    "lookup"
    ;"mcomplete"
    "migemo"
    ;"muse"
    "org"
    ;"paren"
    ;"planner"
    "rabbit-mode"
    "rcodetools"
    ;"remember"
    ;"riece"
    "ruby-mode"
    ;"rails"
    "rinari"
    "rhtml"
    "scheme"
    ;"smart-compile"
    ;"tdiary"
    "view"
    "yasnippet"
    ;"yatex"
    ))
(defvar my-emacs-post-config '("misc"))
(defvar my-emacs-config
  (append nil my-emacs-pre-config my-emacs-misc-config my-emacs-post-config))

(mapcar 'my-emacs-load-config my-emacs-config)


;(setq Info-directory-list '( "~/share/info" "/usr/local/share/info" 
;                             "/sw/share/info" "/usr/share/info"))


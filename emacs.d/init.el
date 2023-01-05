; -*- mode: emacs-lisp; lexical-binding: t; -*-

(defconst my:default-gc-cons-threshold gc-cons-threshold)
(setq gc-cons-threshold (* 128 1024 1024))
(defun my:set-gc-cons-threshold ()
  (setq gc-cons-threshold my:default-gc-cons-threshold))
(add-hook 'emacs-startup-hook 'my:set-gc-cons-threshold)

;; this enables this running method
;;   emacs -q -l ~/.debug.emacs.d/{{pkg}}/init.el
(eval-and-compile
  (when (or load-file-name byte-compile-current-file)
    (setq user-emacs-directory
          (expand-file-name
           (file-name-directory (or load-file-name byte-compile-current-file))))))

(eval-and-compile
  (customize-set-variable
   'package-archives '(("org"   . "https://orgmode.org/elpa/")
                       ("melpa" . "https://melpa.org/packages/")
                       ("gnu"   . "https://elpa.gnu.org/packages/")))
  (package-initialize)
  (unless (package-installed-p 'leaf)
    (package-refresh-contents)
    (package-install 'leaf))

  (leaf leaf-keywords
    :ensure t
    :init
    ;; optional packages if you want to use :hydra, :el-get, :blackout,,,
    (leaf hydra :ensure t)
    (leaf el-get :ensure t)
    (leaf blackout :ensure t)

    :config
    ;; initialize leaf-keywords.el
    (leaf-keywords-init)))

;; Write configurations below...

(setq-default indent-tabs-mode nil)
;; prefix key
(defvar my-prefix (kbd "C-z") "*Prefix key for my favorite.")
(defvar my-map (make-sparse-keymap) "*Keymap for `my-prefix' commands.")
(define-key global-map my-prefix my-map)

(leaf el-get
  :after el-get
  :config
  ;; additional recipes path
  (add-to-list 'el-get-recipe-path
               (expand-file-name "~/dotfiles/emacs.d/recipes"))
  (unless
      (file-directory-p
       (expand-file-name "~/.emacs.d/el-get/el-get/recipes/elpa"))
    (el-get-elpa-build-local-recipes))
  (el-get 'sync))

(leaf leaf
      :config
      (leaf leaf-convert :ensure t)
      (leaf leaf-tree
            :ensure t
            :custom ((imenu-list-size . 30)
                     (imenu-list-position . 'left))))

(leaf macrostep
      :ensure t
      :bind (("C-c e" . macrostep-expand)))


(leaf exec-path-from-shell
  :doc "Get environment variables such as $PATH from the shell"
  :req "emacs-24.1" "cl-lib-0.6"
  :tag "environment" "unix" "emacs>=24.1"
  :url "https://github.com/purcell/exec-path-from-shell"
  :added "2021-10-30"
  :emacs>= 24.1
  :ensure t
  :config (exec-path-from-shell-initialize))

(leaf key-chord
  :doc "map pairs of simultaneously pressed keys to commands"
  :req "emacs-24"
  :tag "input" "chord" "keyboard" "emacs>=24"
  :added "2021-11-14"
  :emacs>= 24
  :ensure t
  :chord (("jk" . view-mode))
  :setq ((key-chord-two-keys-delay . 0.15)
         (key-chord-safety-interval-backward . 0.1)
         (key-chord-safety-interval-forward . 0.25))
  :config
  (key-chord-mode 1))

(leaf builtin
  :config
  (leaf key
    :bind
    (;; Deleteキーでカーソル位置の文字が消えるようにする
     ([delete] . delete-char)
     ;; C-h キーでカーソルの左の文字が消えるようにする。
     ;; ただし、もともと C-h はヘルプなのでこれを有効にすると
     ;; ヘルプを使うときには M-x help や F1 を使う必要があります。
     ("C-h" . backward-delete-char)
     ("C-m" . newline-and-indent)
     ("C-:" . project-find-file))
    :config
    ;; other-window を逆回りにする
    (global-set-key (kbd "C-z p")
                    #'(lambda ()
                        (interactive)
                        (other-window -1)))
    (global-set-key (kbd "C-x C-i")
                    #'(lambda ()
                        (interactive)
                        (indent-region (point-min) (point-max) nil))))
  (leaf cus-edit
    :doc "tools for customizing Emacs and Lisp packages"
    :tag "builtin" "faces" "help"
    :custom `((custom-file . ,(locate-user-emacs-file "custom-file.el"))))

  (leaf cua-base
    :doc "emulate CUA key bindings"
    :tag "builtin"
    :added "2021-10-31"
    :custom ((cua-enable-cua-keys . nil))
    :config (cua-mode t))

  (leaf desktop
    :doc "save partial status of Emacs when killed"
    :tag "builtin"
    :added "2021-11-01"
    :hook (after-init-hook . desktop-save-mode))

  (leaf display-line-numbers
    :doc "interface for display-line-numbers"
    :tag "builtin"
    :added "2021-10-31"
    :init (global-display-line-numbers-mode t))

  (leaf tool-bar
    :doc "setting up the tool bar"
    :tag "builtin" "frames" "mouse"
    :added "2021-10-31"
    :init (tool-bar-mode 0))

  (leaf simple
    :doc "basic editing commands for Emacs"
    :tag "builtin" "internal"
    :added "2021-10-31"
    :init
    ;; 桁番号
    (column-number-mode t)
    (set-goal-column nil))

  (leaf frame
    :doc "multi-frame management independent of window systems"
    :tag "builtin" "internal"
    :added "2021-10-31"
    :config
    ;; 起動時に最大化
    (set-frame-parameter nil 'fullscreen 'maximized)
    (blink-cursor-mode 0))

  (leaf scroll-bar
    :doc "window system-independent scroll bar support"
    :tag "builtin" "hardware"
    :added "2021-10-31"
    :config (set-scroll-bar-mode 'right))

  (leaf select
    :doc "lisp portion of standard selection support"
    :tag "builtin"
    :added "2021-10-31"
    :custom
    ;; emacs -> 他アプリへのコピペ
    ((select-enable-clipboard . t)
     (select-coding-system . 'compound-text-with-extensions)))

  (leaf paren
    :doc "highlight matching paren"
    :tag "builtin"
    :added "2021-10-31"
    :custom ((show-paren-style . 'mixed))
    :config
    (set-face-attribute 'show-paren-match nil
                        :foreground nil
                        :background "#073642"
                        :underline nil)
    :hook (emacs-startup-hook . show-paren-mode))

  (leaf elec-pair
    :doc "Automatic parenthesis pairing"
    :tag "builtin"
    :added "2021-10-31"
    :hook (emacs-startup-hook . electric-pair-mode))

  (leaf files
    :doc "file input and output commands for Emacs"
    :tag "builtin"
    :added "2021-10-31"
    :custom ((make-backup-files . nil)
             (backup-directory-alist . '(("/Dropbox/*.*" . "~/.emacs.d/backup/")
                                         ("~/Nextcloud/*.*" . "~/.emacs.d/backup/")))))

  (leaf savehist
    :doc "Save minibuffer history"
    :tag "builtin"
    :added "2021-10-31"
    :hook (after-init-hook . savehist-mode))

  (leaf server
    :doc "Lisp code for GNU Emacs running as server process"
    :tag "builtin"
    :added "2021-10-31"
    :config (server-start))

  (leaf uniquify
    :doc "unique buffer names dependent on file name"
    :tag "builtin" "files"
    :added "2021-11-03"
    :custom   ((uniquify-buffer-name-style . 'post-forward-angle-brackets)))

  (leaf calendar
    :doc "calendar functions"
    :tag "builtin"
    :added "2021-11-03"
    :custom ((diary-number-of-entries . 31)
             (calendar-mark-holidays-flag . t)
             (calendar-weekend-marker 'diary))
    :bind (:calendar-mode-map
           ("f" . calendar-forward-day)
           ("n" . calendar-forward-day)
           ("b" . calendar-backward-day))
    :hook ((today-visible-calendar-hook . calendar-mark-weekend)
           (today-invisible-calendar-hook . calendar-mark-weekend)))
  (leaf recentf
    :doc "setup a menu of recently opened files"
    :tag "builtin"
    :added "2022-11-14"
    :hook (emacs-startup-hook . recentf-mode)
    :custom ((recentf-max-saved-items . 1000)))
  )

(leaf skk
  :ensure ddskk
  :custom ((default-input-method . "japanese-skk")
           (skk-server-host . "localhost")
           (skk-server-port . 1178)
           (skk-aux-large-jisyo . "/usr/share/skk/SKK-JISYO.L")
           (skk-server-report-response . t))
  :config
  (leaf ddskk-posframe
    :ensure t
    :global-minor-mode t))

(leaf *font
  :custom-face
  ;((default . '((t (:family "VL ゴシック" :foundry "VL  " :slant normal :weight normal :height 113 :width normal)))))
  ((default . '((t (:family "Ricty Diminished" :foundry "PfEd" :slant normal :weight normal :height 113 :width normal)))))
  :config
  (defun set-fontset-font:around (set-fontset-font name target font-spec &optional frame add)
    "Warn if specified font is not installed."
    (if (stringp font-spec) (setq font-spec (font-spec :family font-spec)))
    (if (and (fontp font-spec)
             (null (find-font font-spec)))
        (warn "set-fontset-font: font %s is not found." (font-get font-spec :family))
      (funcall set-fontset-font name target font-spec frame add)))

  (advice-add 'set-fontset-font :around #'set-fontset-font:around)
  ;; 0123456789 ABCDEFGHIJKLMNOPQRSTUVWXYZ abcdefghijklmnopqrstuvwxyz
  ;; あいうえお アイウエオ 🍣🍺🍻📚🎆
  ;; 漢字もいい感じ亜異上御
  ;; 竈門襧豆子で異体字確認
  ;; 句読点も、。
  ;; M-x list-character-sets
  ;; M-x describe-char
  (defun my:setup-font ()
    (set-default-coding-systems 'utf-8-unix)
    (set-fontset-font t 'japanese-jisx0208 "Ricty Diminished")
    (set-fontset-font t 'japanese-jisx0208-1978 "Ricty Diminished")
    (set-fontset-font t 'japanese-jisx0212 "Ricty Diminished")
    (set-fontset-font t 'japanese-jisx0213-1 "Ricty Diminished")
    (set-fontset-font t 'japanese-jisx0213-2 "Ricty Diminished")
    (set-fontset-font t 'japanese-jisx0213.2004-1 "Ricty Diminished")
    (set-fontset-font t 'symbol "Noto Color Emoji")
    (setq use-default-font-for-symbols nil))
  (my:setup-font)
  (add-hook 'focus-in-hook #'my:setup-font)

  )

;; どこに入れていいか迷うもの
(leaf misc
  :custom (
           (case-fold-search . t)
           (truncate-lines . t)
           (ring-bell-function . 'ignore)
           ;(global-font-lock-mode . t nil (font-lock))
           )
  :config
  (auto-compression-mode t)
  ;; disable commands
  (put 'set-goal-column 'disabled nil)
  (put 'narrow-to-region 'disabled nil)
  ;; カーソル位置の数字をインクリメント
  ;; http://www.emacswiki.org/emacs/IncrementNumber
  ;; http://d.hatena.ne.jp/gongoZ/20091222/1261454818
  (defun increment-string-as-number (number)
    "Replace progression string of the position of the cursor
by string that added NUMBER.
Interactively, NUMBER is the prefix arg.

examle:
At the cursor string \"12\"

M-x increment-string-as-number ;; replaced by \"13\"
C-u 10 M-x increment-string-as-number ;; replaced by \"22\"

At the cursor string \"-12\"

M-x increment-string-as-number ;; replaced by \"-11\"
C-u 100 M-x increment-string-as-number ;; replaced by \"88\""
    (interactive "P")
    (let ((col (current-column))
          (p (if (integerp number) number 1)))
      (skip-chars-backward "-0123456789")
      (or (looking-at "-?[0123456789]+")
          (error "No number at point"))
      (replace-match
       (number-to-string (+ p (string-to-number (match-string 0)))))
      (move-to-column col)))
  (global-set-key (kbd "C-c +") 'increment-string-as-number)
  (leaf hydra
    :hydra
    (hydra-zoom ()
                "zoom"
                ("g" text-scale-increase "in")
                ("l" text-scale-decrease "out"))
    :chord (("zz" . hydra-zoom/body))
    :bind (("C-z z" . hydra-zoom/body)))
  )

(leaf solarized-theme
  :doc "The Solarized color theme"
  :req "emacs-24.1"
  :tag "solarized" "themes" "convenience" "emacs>=24.1"
  :url "http://github.com/bbatsov/solarized-emacs"
  :added "2021-10-30"
  :emacs>= 24.1
  :ensure t
  :config (load-theme 'solarized-dark t))

(leaf all-the-icons
  :doc "A library for inserting Developer icons"
  :req "emacs-24.3"
  :tag "lisp" "convenient" "emacs>=24.3"
  :url "https://github.com/domtronn/all-the-icons.el"
  :added "2021-11-02"
  :emacs>= 24.3
  :ensure t)

(leaf dmacro
  :doc "Repeated detection and execution of key operation"
  :req "emacs-24.1" "cl-lib-0.6"
  :tag "convenience" "emacs>=24.1"
  :url "https://github.com/emacs-jp/dmacro"
  :added "2021-11-03"
  :emacs>= 24.1
  :ensure t
  :custom `((dmacro-key . ,(kbd "C-t")))
  :hook (after-init-hook . global-dmacro-mode))

(leaf dash
  :doc "A modern list library for Emacs"
  :url "https://github.com/magnars/dash.el"
  :added "2021-11-02"
  :ensure t)

(leaf shrink-path
  :doc "fish-style path"
  :req "emacs-24" "s-1.6.1" #("dash-1.8.0" 0 4
                              (face nil)) "f-0.10.0"
  :tag "emacs>=24"
  :url "https://gitlab.com/bennya/shrink-path.el"
  :added "2021-11-02"
  :emacs>= 24
  :ensure t)

(leaf doom-modeline
  :doc "A minimal and modern mode-line"
  :req "emacs-25.1" "all-the-icons-2.2.0" "shrink-path-0.2.0" "dash-2.11.0"
  :tag "mode-line" "faces" "emacs>=25.1"
  :url "https://github.com/seagle0128/doom-modeline"
  :added "2021-10-31"
  :emacs>= 25.1
  :ensure t
  :require t
  :custom
  ((doom-modeline-buffer-file-name-style . 'auto)
   (doom-modeline-buffer-modification-icon . nil)
   (doom-modeline-minor-modes . nil))
  :hook (after-init-hook . doom-modeline-mode))

(leaf anzu
 :doc "Show number of matches in mode-line while searching"
 :req "emacs-25.1"
 :tag "emacs>=25.1"
 :url "https://github.com/emacsorphanage/anzu"
 :added "2021-10-30"
 :emacs>= 25.1
 :ensure t
 :custom ((anzu-mode-lighter . "")
          (anzu-deactivate-region . t)
          (anzu-search-threshold . 1000))
 :config (global-anzu-mode +1)
 :bind (([remap query-replace] . anzu-query-replace)
        ([remap query-replace-regexp] . anzu-query-replace-regexp)))

(leaf browse-at-remote
  :doc "Open github/gitlab/bitbucket/stash/gist/phab/sourcehut page from Emacs"
  :req "f-0.17.2" "s-1.9.0" "cl-lib-0.5"
  :tag "pagure" "sourcehut" "phabricator" "stash" "gist" "bitbucket" "gitlab" "github"
  :url "https://github.com/rmuslimov/browse-at-remote"
  :added "2021-10-30"
  :ensure t
  :bind (("M-g r" . browse-at-remote)
         ("M-g k" . browse-at-remote-kill)))

(leaf git-gutter+
  :doc "Manage Git hunks straight from the buffer"
  :req "git-commit-0" "dash-0"
  :tag "vc" "git"
  :url "https://github.com/nonsequitur/git-gutter-plus"
  :added "2021-11-02"
  :ensure t
  :after git-commit)

(leaf fringe-helper
  :doc "helper functions for fringe bitmaps"
  :tag "lisp"
  :url "http://nschum.de/src/emacs/fringe-helper/"
  :added "2021-11-02"
  :ensure t)

(leaf git-gutter-fringe+
  :doc "Fringe version of git-gutter+.el"
  :req "git-gutter+-0.1" "fringe-helper-1.0.1"
  :url "https://github.com/nonsequitur/git-gutter-fringe-plus"
  :added "2021-10-30"
  :ensure t
  :custom-face
  ((git-gutter+-added . '((t (:background "#8c9a43" :foreground "#8c9a43"))))
   (git-gutter+-deleted . '((t (:background "#d66556" :foreground "#d66556"))))
   (git-gutter+-modified . '((t (:background "#268bd2" :foreground "#268bd2")))))
  :hook (after-init-hook . global-git-gutter+-mode))

(leaf popup
  :doc "Visual Popup User Interface"
  :req "emacs-24.3"
  :tag "lisp" "emacs>=24.3"
  :url "https://github.com/auto-complete/popup-el"
  :added "2021-11-03"
  :emacs>= 24.3
  :ensure t)

(leaf flycheck
  :doc "On-the-fly syntax checking"
  :req "dash-2.12.1" "pkg-info-0.4" "let-alist-1.0.4" "seq-1.11" "emacs-24.3"
  :tag "tools" "languages" "convenience" "emacs>=24.3"
  :url "http://www.flycheck.org"
  :added "2021-10-30"
  :emacs>= 24.3
  :ensure t
  :config
  (setq flycheck-display-errors-function
        '(lambda (errors)
           (-when-let (messages (-keep #'flycheck-error-message errors))
                      (popup-tip (s-join "\n\n" messages))))))

(leaf flyspell
  :doc "On-the-fly spell checker"
  :tag "builtin"
  :added "2021-11-03"
  :custom
  `(;; Do no change M-TAB key bind
    (flyspell-use-meta-tab . nil)
    (flyspell-auto-correct-binding . ,(kbd "C-z C-;"))
    (ispell-program-name . "hunspell")
    (ispell-really-hunspell . t)
    (isqpell-dictionary . "en_US"))
  :hook ((text-mode-hook . flyspell-mode)
         ((prog-mode-hook ruby-mode-hook) . flyspell-prog-mode))
  :config
  (setenv "DICTIONARY" "en_US")
  (leaf flyspell-correct
    :doc "Correcting words with flyspell via custom interface"
    :req "emacs-24"
    :tag "emacs>=24"
    :url "https://github.com/d12frosted/flyspell-correct"
    :added "2021-11-03"
    :emacs>= 24
    :ensure t)

  (leaf flyspell-correct-popup
    :doc "Correcting words with flyspell via popup interface"
    :req "flyspell-correct-0.6.1" "popup-0.5.3" "emacs-24"
    :tag "emacs>=24"
    :url "https://github.com/d12frosted/flyspell-correct"
    :added "2021-10-30"
    :emacs>= 24
    :ensure t
    :after flyspell-correct
    :bind (("C-1" . flyspell-correct-wrapper)))
  )

(leaf lookup
  :custom ((lookup-enable-splash . nil)
           (lookup-search-agents . '((ndeb "~/.dic/OALD_7") (ndspell))
                                 ;(ndeb "~/.dic/readers") (ndspell)
                                 ;(ndeb "~/.dic/EIJIRO77") (ndspell)
                                 ;(ndeb "~/.dic/ROGET") (ndspell)
                                 ;(ndeb "~/.dic/mypaedia") (ndspell)
                                 ;(ndtp "localhost") (ndspell)
                                 ))
  :bind
  (("C-x l" . lookup)
   ("C-x y" . lookup-region)
   ("C-x C-y" . lookup-pattern))
  :config
  (autoload 'lookup "lookup" nil t)
  (autoload 'lookup-region "lookup" nil t)
  (autoload 'lookup-pattern "lookup" nil t)
  (autoload 'lookup-word "lookup" nil t)
  )

(leaf highlight-thing
  :doc "Minimalistic minor mode to highlight current thing under point."
  :tag "symbol" "thing" "highlight"
  :url "https://github.com/fgeller/highlight-thing.el"
  :added "2021-10-31"
  :ensure t
  :hook (prog-mode-hook . highlight-thing-mode))

(leaf highlight-indent-guides
  :doc "Minor mode to highlight indentation"
  :req "emacs-24.1"
  :tag "emacs>=24.1"
  :url "https://github.com/DarthFennec/highlight-indent-guides"
  :added "2021-10-31"
  :emacs>= 24.1
  :ensure t
  :hook ((prog-mode-hook yaml-mode-hook) . highlight-indent-guides-mode)
  :custom
  ((highlight-indent-guides-auto-enabled . t)
   (highlight-indent-guides-responsive . t)
   (highlight-indent-guides-method . 'character)
   (highlight-indent-guides-character . ?|)))

(leaf dash
  :doc "A modern list library for Emacs"
  :url "https://github.com/magnars/dash.el"
  :added "2021-10-31"
  :ensure t)

(leaf popwin
  :doc "Popup Window Manager"
  :req "emacs-24.3"
  :tag "convenience" "emacs>=24.3"
  :url "https://github.com/emacsorphanage/popwin"
  :added "2021-10-31"
  :emacs>= 24.3
  :ensure t
  :setq ((popwin:close-popup-window-timer-interval . 0.05))
  :defer-config
  (push "*Backtrace*" popwin:special-display-config)
  ;; vc
  (push "*vc-diff*" popwin:special-display-config)
  (push "*vc-change-log*" popwin:special-display-config)
  ;; ag
  (push "*ag*" popwin:special-display-config)
  ;; po-mode
  (push '("\\*.*\\.po\\*"
          :regexp t
          :position bottom
          :height 20)
        popwin:special-display-config)
  )

(leaf pos-tip
  :doc "Show tooltip at point"
  :tag "tooltip"
  :added "2021-10-31"
  :ensure t)

(leaf corfu
  :doc "Completion Overlay Region FUnction"
  :req "emacs-27.1"
  :tag "emacs>=27.1"
  :url "https://github.com/minad/corfu"
  :added "2022-11-13"
  :emacs>= 27.1
  :ensure t
  :global-minor-mode global-corfu-mode
  :custom ((corfu-cycle . t)
           (corfu-auto . t))
  :bind ((:corfu-map
          ("TAB" . corfu-next)
          ("<tab>" . corfu-next)
          ("S-TAB" . corfu-previous)
          ("<backtab>" . corfu-previous)
          ("C-n" . corfu-next)
          ("C-p" . corfu-previous))))

(leaf corfu-doc
  :doc "Documentation popup for Corfu"
  :req "emacs-27.1" "corfu-0.25"
  :tag "convenience" "documentation" "popup" "corfu" "emacs>=27.1"
  :url "https://github.com/galeo/corfu-doc"
  :added "2022-11-13"
  :emacs>= 27.1
  :ensure t
  :after corfu
  :hook (corfu-mode-hook . corfu-doc-mode)
  :bind ((:corfu-map
          ("M-n" . corfu-doc-scroll-up)
          ("M-p" . corfu-doc-scroll-down)
          ("M-d" . corfu-doc-toggle))))

(leaf kind-icon
  :doc "Completion kind icons"
  :req "emacs-27.1" "svg-lib-0"
  :tag "completion" "emacs>=27.1"
  :url "https://github.com/jdtsmith/kind-icon"
  :added "2022-11-13"
  :emacs>= 27.1
  :ensure t
  :after svg-lib corfu
  :custom ((kind-icon-default-face . corfu-default))
  :config (add-to-list 'corfu-margin-formatters #'kind-icon-margin-formatter)
  )

(leaf cape
  :doc "Completion At Point Extensions"
  :req "emacs-27.1"
  :tag "emacs>=27.1"
  :url "https://github.com/minad/cape"
  :added "2022-11-13"
  :emacs>= 27.1
  :ensure t
  :config
  (add-to-list 'completion-at-point #'cape-file t)
  (add-to-list 'completion-at-point #'cape-dabbrev t)
  (add-to-list 'completion-at-point #'cape-keyword t))

(leaf emojify
  :doc "Display emojis in Emacs"
  :req "seq-1.11" "ht-2.0" "emacs-24.3"
  :tag "convenience" "multimedia" "emacs>=24.3"
  :url "https://github.com/iqbalansari/emacs-emojify"
  :added "2021-10-31"
  :emacs>= 24.3
  :ensure t
  :bind ("C-c C-e" . emojify-insert-emoji)
  :hook (emacs-startup-hook . global-emojify-mode))

(leaf which-key
  :doc "Display available keybindings in popup"
  :req "emacs-24.4"
  :tag "emacs>=24.4"
  :url "https://github.com/justbur/emacs-which-key"
  :added "2021-10-31"
  :emacs>= 24.4
  :ensure t
  :hook (emacs-startup-hook . which-key-mode))

(leaf posframe
  :doc "Pop a posframe (just a frame) at point"
  :req "emacs-26.1"
  :tag "tooltip" "convenience" "emacs>=26.1"
  :url "https://github.com/tumashu/posframe"
  :added "2021-10-31"
  :emacs>= 26.1
  :ensure t
  :config
  (leaf which-key-posframe
    :doc "Using posframe to show which-key"
    :req "emacs-26.0" "posframe-0.4.3" "which-key-3.3.2"
    :tag "tooltip" "bindings" "convenience" "emacs>=26.0"
    :url "https://github.com/yanghaoxie/which-key-posframe"
    :added "2021-10-31"
    :emacs>= 26.0
    :ensure t
    :hook (emacs-startup-hook . which-key-posframe-mode))

  (leaf hydra-posframe
    :tag "out-of-MELPA"
    :added "2021-10-31"
    :el-get Ladicle/hydra-posframe
    :require t
    :after hydra
    :hook (emacs-startup-hook . hydra-posframe-mode))

  (leaf vertico-posframe
    :doc "Using posframe to show Vertico"
    :req "emacs-26.0" "posframe-1.0.0" "vertico-0.13.0"
    :tag "vertico" "matching" "convenience" "abbrev" "emacs>=26.0"
    :url "https://github.com/tumashu/vertico-posframe"
    :added "2021-10-31"
    :emacs>= 26.0
    :ensure t
    :after vertico
    :hook (emacs-startup-hook . vertico-posframe-mode))
  )

(leaf yasnippet
  :doc "Yet another snippet extension for Emacs"
  :req "cl-lib-0.5"
  :tag "emulation" "convenience"
  :url "http://github.com/joaotavora/yasnippet"
  :added "2021-10-31"
  :ensure t
  :hydra
  (hydra-yasnippet (:exit t :hint nil)
                   "
 YASnippets^^
 Modes^^      Load/Visit^^      Actions
---------------------------------------------------------
[_g_] global  [_d_] directory  [_i_] insert
[_m_] minor   [_f_] file       [_t_] tryout
[_e_] extra   [_l_] list       [_n_] new
^^            [_a_] reload-all
"
                   ("d" yas-load-directory)
                   ("e" yas-activate-extra-mode)
                   ("i" yas-insert-snippet)
                   ("t" yas-tryout-snippet)
                   ("n" yas-new-snippet)
                   ("f" yas-visit-snippet-file)
                   ("l" yas-describe-tables)
                   ("g" yas-global-mode)
                   ("m" yas-minor-mode)
                   ("a" yas-reload-all))
  :bind (("C-c y" . hydra-yasnippet/body))
  :hook (after-init-hook . yas-global-mode)
  :config
  (yas-load-directory "~/dotfiles/emacs.d/snippets")
  (leaf yasnippet-snippets
    :doc "Collection of yasnippet snippets"
    :req "yasnippet-0.8.0"
    :tag "snippets"
    :url "https://github.com/AndreaCrotti/yasnippet-snippets"
    :added "2021-10-31"
    :ensure t)
  )
(leaf dumb-jump
  :doc "Jump to definition for 50+ languages without configuration"
  :req "emacs-24.3" "s-1.11.0" "dash-2.9.0" "popup-0.5.3"
  :tag "programming" "emacs>=24.3"
  :url "https://github.com/jacktasia/dumb-jump"
  :added "2021-11-01"
  :emacs>= 24.3
  :ensure t
  :custom ((dumb-jump-default-project . "")
           (dumb-jump-prefer-searcher . 'rg))
  :config
  (smart-jump-setup-default-registers)
  (add-hook 'xref-backend-functions #'dumb-jump-xref-activate)
  :hydra
  (hydra-dumb-jump
   (:color blue :column 3)
   "Dumb Jump"
   ("j" dumb-jump-go "Go")
   ("o" dumb-jump-go-other-window "Other window")
   ("e" dumb-jump-go-prefer-external "Go external")
   ("x" dumb-jump-go-prefer-external-other-window "Go external other window")
   ("i" dumb-jump-go-prompt "Prompt")
   ("l" dumb-jump-quick-look "Quick look")
   ("b" dumb-jump-back "Back"))
  :chord (("dj" . hydra-dumb-jump/body))
  :bind (("C-z d" . hydra-dumb-jump/body))
  )

(leaf migemo
  :doc "Japanese incremental search through dynamic pattern expansion"
  :req "cl-lib-0.5"
  :url "https://github.com/emacs-jp/migemo"
  :added "2021-10-31"
  :ensure t
  :if (executable-find "cmigemo")
  :custom `((migemo-command . "cmigemo")
            (migemo-options . '("-q" "--emacs"))
            (migemo-directory . ,(expand-file-name "/usr/share/cmigemo/utf-8/migemo-dict"))
            (migemo-user-dictionary . nil)
            (migemo-regex-dictionary . nil)
            (migemo-coding-system . 'utf-8-unix))
  :hook (after-init-hook . migemo-init))

(leaf avy
  :doc "Jump to arbitrary positions in visible text and select text quickly."
  :req "emacs-24.1" "cl-lib-0.5"
  :tag "location" "point" "emacs>=24.1"
  :url "https://github.com/abo-abo/avy"
  :added "2021-10-31"
  :emacs>= 24.1
  :ensure t
  :hydra
  (hydra-avy (:exit t :hint nil)
    "
 Avy^^
 Line^^       Region^^        Goto
----------------------------------------------------------
 [_y_] yank   [_Y_] yank      [_c_] timed char  [_C_] char
 [_m_] move   [_M_] move      [_w_] word        [_W_] any word
 [_k_] kill   [_K_] kill      [_l_] line        [_L_] end of line"
    ("c" avy-goto-char-timer)
    ("C" avy-goto-char)
    ("w" avy-goto-word-1)
    ("W" avy-goto-word-0)
    ("l" avy-goto-line)
    ("L" avy-goto-end-of-line)
    ("m" avy-move-line)
    ("M" avy-move-region)
    ("k" avy-kill-whole-line)
    ("K" avy-kill-region)
    ("y" avy-copy-line)
    ("Y" avy-copy-region))
  :bind (([remap goto-line] . avy-goto-line)
         ([remap goto-char] . avy-goto-char-timer)
         ("C-z g" . hydra-avy/body)
         (:isearch-mode-map
          ("C-a" . avy-isearch)))
  :chord (("jj" . hydra-avy/body)))

(leaf ace-window
  :doc "Quickly switch windows."
  :req "avy-0.5.0"
  :tag "location" "window"
  :url "https://github.com/abo-abo/ace-window"
  :added "2021-10-31"
  :ensure t
  :custom-face
  ((aw-leading-char-face . '((t (:foreground "light coral" :height 4.0)))))
  :hydra
  (hydra-window (:color red :hint nil)
    "
Window: _v_sprit  _h_sprit  _o_ther  _s_wap _a_ce-window del_0_:_1_
"
    ("v" split-window-right)
    ("h" split-window-below)
    ("o" other-window-or-split)
    ("s" window-swap-states)
    ; ("x" window-toggle-division)
    ("a" ace-window :exit t)
    ("0" delete-window :exit t)
    ("1" delete-other-windows :exit t)
    ;; Common setting with hydra-work
    ("_" delete-other-windows :exit t)
    ; ("n" new-frame)
    ; ("m" other-frame)
    ; ("d" delete-frame :exit t)
    )
  :bind ("C-z w" . hydra-window/body)
  )

(leaf vertico
  :doc "VERTical Interactive COmpletion"
  :req "emacs-27.1"
  :tag "emacs>=27.1"
  :url "https://github.com/minad/vertico"
  :added "2021-10-31"
  :emacs>= 27.1
  :ensure t
  :preface
  ;; https://scrapbox.io/emacs/find-file%E3%81%A7Helm%E3%81%BF%E3%81%9F%E3%81%84%E3%81%ABC-l%E3%81%A7%E3%83%87%E3%82%A3%E3%83%AC%E3%82%AF%E3%83%88%E3%83%AA%E3%82%92%E9%81%A1%E3%82%8B
  (defun my-filename-upto-parent ()
    "Move to parent directory like \"cd ..\" in find-file."
    (interactive)
    (let ((sep (eval-when-compile (regexp-opt '("/" "\\")))))
      (save-excursion
        (left-char 1)
        (when (looking-at-p sep)
        (delete-char 1)))
      (save-match-data
        (when (search-backward-regexp sep nil t)
          (right-char 1)
          (filter-buffer-substring (point)
                                   (save-excursion (end-of-line) (point))
                                   #'delete)))))
  :custom ((vertico-count . 20))
  :bind
  (:vertico-map (("C-l" . my-filename-upto-parent)))
  :hook (after-init-hook . vertico-mode))

(leaf rainbow-delimiters
  :doc "Highlight brackets according to their depth"
  :tag "tools" "lisp" "convenience" "faces"
  :url "https://github.com/Fanael/rainbow-delimiters"
  :added "2021-11-02"
  :ensure t
  :hook (prog-mode-hook . rainbow-delimiters-mode))

(leaf marginalia
  :doc "Enrich existing commands with completion annotations"
  :req "emacs-26.1"
  :tag "emacs>=26.1"
  :url "https://github.com/minad/marginalia"
  :added "2021-10-31"
  :emacs>= 26.1
  :ensure t
  :hook (after-init-hook . marginalia-mode))

(leaf embark
  :doc "Conveniently act on minibuffer completions"
  :req "emacs-26.1"
  :tag "convenience" "emacs>=26.1"
  :url "https://github.com/oantolin/embark"
  :added "2021-10-31"
  :emacs>= 26.1
  :ensure t
  :bind (("C-z e" . embark-act)))

(leaf consult
  :doc "Consulting completing-read"
  :req "emacs-26.1"
  :tag "emacs>=26.1"
  :url "https://github.com/minad/consult"
  :added "2021-10-31"
  :emacs>= 26.1
  :ensure t
  :custom ((consult-project-root-function
            . (lambda ()
                (when-let (project (project-current))
                  (car (project-roots project))))))
  :hydra (hydra-consult
          (:hint nil :exit t)
    "
 Describe^^               Ring^^           Other^^
----------------------------------------------------------
 [_f_] describe-function  [_y_] yank-pop   [_c_] org-capture
 [_b_] describe-binds     [_m_] mark-ring  [_u_] unicord-char
 [_v_] describe-variable  [_r_] recentf    [_e_] colors-emacs
 [_F_] describe-face      [_R_] register   [_w_] colors-web
 [_a_] apropos"
      ("b" describe-bindings)
      ("f" describe-function)
      ("v" describe-variable)
      ("F" describe-face)
      ("a" consult-apropos)
      ("y" consult-yank-pop)
      ("m" consult-mark)
      ("r" consult-recent-file)
      ("R" consult-register)
      ;("u" consult-unicode-char)
      ;("c" consult-org-capture)
      ("e" read-color)
      ;("w" consult-colors-web)
      )
  :bind (("C-;" . consult-buffer)
         ("M-y" . consult-yank-pop)
         ("C-z l" . consult-line)
         ("C-c c" . hydra-consult/body)))

(leaf embark-consult
  :doc "Consult integration for Embark"
  :req "emacs-25.1" "embark-0.9" "consult-0.1"
  :tag "convenience" "emacs>=25.1"
  :url "https://github.com/oantolin/embark"
  :added "2021-10-31"
  :emacs>= 25.1
  :ensure t
  :after embark consult
  :require t)

(leaf fussy
  :doc "Fuzzy completion style using `flx'"
  :req "emacs-27.2" "flx-0.5"
  :tag "matching" "emacs>=27.2"
  :url "https://github.com/jojojames/fussy"
  :added "2022-11-25"
  :emacs>= 27.2
  :ensure t flx
  :config
  (leaf fuz-bin
    :el-get jcs-elpa/fuz-bin
    :config
    (fuz-bin-load-dyn))
  (add-to-list 'completion-styles 'fussy t)
  :custom ((fussy-score-fn . #'fussy-fuz-bin-score)
           (fussy-filter-fn . #'fussy-filter-orderless-flex)
           ;; For example, project-find-file uses 'project-files which uses
           ;; substring completion by default. Set to nil to make sure it's
           ;; using flx.
           (completion-category-defaults . nil)
           (completion-category-overrides . nil)))

(leaf orderless
  :doc "Completion style for matching regexps in any order"
  :req "emacs-26.1"
  :tag "extensions" "emacs>=26.1"
  :url "https://github.com/oantolin/orderless"
  :added "2021-10-31"
  :emacs>= 26.1
  :ensure t
  :config
  (add-to-list 'completion-styles 'orderless t)
  (defun affe-orderless-regexp-compiler (input _type _ignorecase)
    (setq input (orderless-pattern-compiler input))
    (cons input (lambda (str) (orderless--highlight input str)))))

(leaf affe
  :doc "Asynchronous Fuzzy Finder for Emacs"
  :req "emacs-27.1" "consult-0.12"
  :tag "emacs>=27.1"
  :url "https://github.com/minad/affe"
  :added "2021-10-31"
  :emacs>= 27.1
  :ensure t
  :after orderless
  :custom ((affe-find-command . "fdfind --color=never --full-path")
           (affe-regexp-compiler . #'affe-orderless-regexp-compiler))
  :bind (("C-c ." . affe-grep)))

(leaf consult-ghq
  :doc "Ghq interface using consult"
  :req "emacs-26.1" "consult-0.8" #("affe-0.1" 0 4
                                    (face nil))
  :tag "ghq" "consult" "usability" "convenience" "emacs>=26.1"
  :url "https://github.com/tomoya/consult-ghq"
  :added "2021-10-31"
  :emacs>= 26.1
  :ensure t
  :bind (("C-\]" . consult-ghq-find)))

(leaf amx
  :doc "Alternative M-x with extra features."
  :req "emacs-24.4" "s-0"
  :tag "completion" "usability" "convenience" "emacs>=24.4"
  :url "http://github.com/DarwinAwardWinner/amx/"
  :added "2021-10-31"
  :emacs>= 24.4
  :ensure t)

(leaf wgrep
  :doc "Writable grep buffer and apply the changes to files"
  :tag "extensions" "edit" "grep"
  :url "http://github.com/mhayashi1120/Emacs-wgrep/raw/master/wgrep.el"
  :added "2021-10-31"
  :ensure t
  :custom ((wgrep-enable-key . "e")))

(leaf editorconfig
  :doc "EditorConfig Emacs Plugin"
  :req "cl-lib-0.5" "nadvice-0.3" "emacs-24"
  :tag "emacs>=24"
  :url "https://github.com/editorconfig/editorconfig-emacs#readme"
  :added "2021-10-31"
  :emacs>= 24
  :ensure t
  :after nadvice
  :hook (emacs-startup-hook . editorconfig-mode))

(leaf tree-sitter
  :doc "Incremental parsing system"
  :req "emacs-25.1" "tsc-0.16.1"
  :tag "tree-sitter" "parsers" "tools" "languages" "emacs>=25.1"
  :url "https://github.com/emacs-tree-sitter/elisp-tree-sitter"
  :added "2021-12-22"
  :emacs>= 25.1
  :ensure t
  :require t
  :hook ((emacs-startup-hook . global-tree-sitter-mode)
         (tree-sitter-after-on-hook . tree-sitter-hl-mode))
  )

(leaf atomic-chrome
  :doc "Edit Chrome text area with Emacs using Atomic Chrome"
  :req "emacs-24.4" "let-alist-1.0.4" "websocket-1.4"
  :tag "textarea" "edit" "chrome" "emacs>=24.4"
  :url "https://github.com/alpha22jp/atomic-chrome"
  :added "2021-10-31"
  :emacs>= 24.4
  :ensure t
  :hook (emacs-startup-hook . atomic-chrome-start-server)
  :custom ((atomic-chrome-default-major-mode . 'markdown-mode)
           (atomic-chrome-buffer-open-style . 'frame)
           (atomic-chrome-buffer-frame-height . 80)
           (atomic-chrome-buffer-frame-width . 150)
           (atomic-chrome-url-major-mode-alist
            . '(("helpdesk\\.classmethod\\.net" . text-mode)))))

(leaf lsp-ui
  :doc "UI modules for lsp-mode"
  :req "emacs-26.1" "dash-2.18.0" "lsp-mode-6.0" "markdown-mode-2.3"
  :tag "tools" "languages" "emacs>=26.1"
  :url "https://github.com/emacs-lsp/lsp-ui"
  :added "2021-10-31"
  :emacs>= 26.1
  :ensure t
  :after lsp-mode markdown-mode
  :config (add-to-list
           'load-path (expand-file-name "~/.emacs.d/el-get/lsp-mode/clients"))
  :hook (lsp-mode-hook . lsp-ui-mode)
  :custom ((lsp-completion-provider :none)))

(leaf magit
  :doc "A Git porcelain inside Emacs."
  :req "emacs-25.1" "dash-2.19.1" "git-commit-3.3.0" "magit-section-3.3.0" "transient-0.3.6" "with-editor-3.0.5"
  :tag "vc" "tools" "git" "emacs>=25.1"
  :added "2021-10-31"
  :emacs>= 25.1
  :ensure t
  :after git-commit magit-section with-editor)

(leaf magit-delta
  :doc "Use Delta when displaying diffs in Magit"
  :req "emacs-25.1" "magit-20200426" "xterm-color-2.0"
  :tag "emacs>=25.1"
  :url "https://github.com/dandavison/magit-delta"
  :added "2021-12-25"
  :emacs>= 25.1
  :ensure t
  :after magit xterm-color
  :hook (magit-mode-hook . magit-delta-mode))
(leaf *programming
  :config
  (leaf sh-script
  :doc "shell-script editing commands for Emacs"
  :tag "builtin"
  :added "2022-12-08"
  :custom ((sh-basic-offset . 2)))
  (leaf scheme-mode
    :custom ((scheme-program-name . "gosh -i"))
    :config
    (autoload 'scheme-mode "cmuscheme" "Major mode for Scheme." t)
    (autoload 'run-scheme "cmuscheme" "Run an inferior Scheme process." t)
    (defun scheme-other-window ()
      "Run scheme on other window"
      (interactive)
      (switch-to-buffer-other-window
       (get-buffer-create "*scheme*"))
      (run-scheme scheme-program-name))
    (add-hook 'scheme-mode-hook
              '(lambda ()
                 (define-key scheme-mode-map
                   (kbd "C-c C-s") 'scheme-other-window))))
  (leaf css-mode
    :doc "Major mode to edit CSS files"
    :tag "builtin"
    :added "2021-10-31"
    :custom ((css-indent-offset . 2)))
  (leaf dockerfile-mode
    :doc "Major mode for editing Docker's Dockerfiles"
    :req "emacs-24"
    :tag "docker" "emacs>=24"
    :url "https://github.com/spotify/dockerfile-mode"
    :added "2021-10-31"
    :emacs>= 24
    :ensure t)
  (leaf go-mode
    :doc "Major mode for the Go programming language"
    :tag "go" "languages"
    :url "https://github.com/dominikh/go-mode.el"
    :added "2021-10-31"
    :ensure t
    :hook (go-mode-hook . lsp-deferred))
  (leaf haml-mode
    :doc "Major mode for editing Haml files"
    :req "emacs-24" "cl-lib-0.5"
    :tag "html" "languages" "markup" "emacs>=24"
    :url "https://github.com/nex3/haml-mode"
    :added "2021-10-31"
    :emacs>= 24
    :ensure t)
  (leaf hcl-mode
    :doc "Major mode for Hashicorp"
    :req "emacs-24.3"
    :tag "emacs>=24.3"
    :url "https://github.com/purcell/emacs-hcl-mode"
    :added "2021-10-31"
    :emacs>= 24.3
    :ensure t
    :mode "\\.tf$")

  (leaf nginx-mode
    :doc "major mode for editing nginx config files"
    :tag "nginx" "languages"
    :added "2022-12-30"
    :ensure t
    :mode "/nginx/sites-\\(?:available\\|enabled\\|conf.d\\)")

  (leaf lua-mode
    :doc "a major-mode for editing Lua scripts"
    :req "emacs-24.3"
    :tag "tools" "processes" "languages" "emacs>=24.3"
    :url "https://immerrr.github.io/lua-mode"
    :added "2022-12-30"
    :emacs>= 24.3
    :ensure t
    :mode "\\.lua$")

  (leaf vcl-mode
    :doc "Major mode for Varnish Configuration Language"
    :tag "vcl" "varnish"
    :url "http://elpa.gnu.org/packages/vcl-mode.html"
    :added "2023-01-02"
    :ensure t)

  (leaf js2-mode
    :doc "Improved JavaScript editing mode"
    :req "emacs-24.1" "cl-lib-0.5"
    :tag "javascript" "languages" "emacs>=24.1"
    :url "https://github.com/mooz/js2-mode/"
    :added "2021-10-31"
    :emacs>= 24.1
    :ensure t
    :custom ((js2-basinc-offset . 2))
    :mode "\\.js$" "\\.jsx$"
    :bind ((:js2-mode-map
            ("C-m" . nil)
            ("C-i" . indent-and-back-to-indentation)))
    :preface
    (defun indent-and-back-to-indentation ()
      (interactive)
      (indent-for-tab-command)
      (let ((point-of-indentation
             (save-excursion
               (back-to-indentation)
               (point))))
        (skip-chars-forward "\s " point-of-indentation))))

  ;; (leaf rabbit-mode
  ;;   :tag "out-of-MELPA"
  ;;   :added "2021-10-31"
  ;;   :el-get (rabbit-shocker/rabbit-mode
  ;;            :url "https://raw.github.com/rabbit-shocker/rabbit/master/misc/emacs/rabbit-mode.el")
  ;;   :require t
  ;;   :mode "\\.rbt$" "\\.rab$")
  (leaf json-mode
    :doc "Major mode for editing JSON files."
    :req "json-snatcher-1.0.0" "emacs-24.4"
    :tag "emacs>=24.4"
    :url "https://github.com/joshwnj/json-mode"
    :added "2021-11-09"
    :emacs>= 24.4
    :ensure t
    :after json-snatcher)

  (leaf ruby-mode
    :doc "Major mode for editing Ruby files"
    :tag "out-of-MELPA"
    :added "2021-12-24"
    :el-get (ruby/elisp
             :url "https://raw.githubusercontent.com/ruby/elisp/master/ruby-mode.el")
    :mode "\\.rb$" "Rakefile$" "\\.rake$" "Gemfile" "\\.gemspec$" "\\.cap$" "Capfile$"
    :ensure t ruby-end inf-ruby
    :custom
    ((ruby-deep-indent-paren-style . nil))
    :hook ((ruby-mode-hook . flycheck-mode)
           (ruby-mode-hook . inf-ruby-minor-mode)
           (ruby-mode-hook . lsp-deferred))
    :bind
    ((:ruby-mode-map
      ("RET" . ruby-reindent-then-newline-and-indent)))
    :config
    (plist-put develock-max-column-plist 'ruby-mode 150)
    ;; ruby-electric-mode 優先順位を最下位にする。[ruby-list:45511]
    (let ((rel (assq 'ruby-electric-mode minor-mode-map-alist)))
      (setq minor-mode-map-alist (append
                                  (delete rel minor-mode-map-alist)
                                  (list rel))))
    (defadvice ruby-indent-line (after unindent-closing-paren activate)
      (let ((column (current-column))
            indent offset)
        (save-excursion
          (back-to-indentation)
          (let ((state (syntax-ppss)))
            (setq offset (- column (current-column)))
            (when (and (eq (char-after) ?\))
                       (not (zerop (car state))))
              (goto-char (cadr state))
              (setq indent (current-indentation)))))
        (when indent
          (indent-line-to indent)
          (when (> offset 0) (forward-char offset)))))
    )
  (leaf rhtml-mode
    :doc "major mode for editing RHTML files"
    :added "2021-11-03"
    :ensure t)
  (leaf rustic
    :doc "Rust development environment"
    :req "emacs-26.1" "rust-mode-0.5.0" "dash-2.13.0" "f-0.18.2" "let-alist-1.0.4" "markdown-mode-2.3" "project-0.3.0" "s-1.10.0" "seq-2.3" "spinner-1.7.3" "xterm-color-1.6"
    :tag "languages" "emacs>=26.1"
    :added "2021-10-31"
    :emacs>= 26.1
    :ensure t
    :after rust-mode markdown-mode project spinner xterm-color
    :mode "\\.rs$")

  (leaf scss-mode
    :doc "Major mode for editing SCSS files"
    :tag "mode" "css" "scss"
    :url "https://github.com/antonj/scss-mode"
    :added "2021-10-31"
    :ensure t
    :mode "\\.scss$")
  (leaf slim-mode
    :doc "Major mode for editing Slim files"
    :tag "language" "markup"
    :url "http://github.com/slim-template/emacs-slim"
    :added "2021-10-31"
    :ensure t)
  (leaf typescript-mode
    :doc "Major mode for editing typescript"
    :req "emacs-24.3"
    :tag "languages" "typescript" "emacs>=24.3"
    :url "http://github.com/ananthakumaran/typescript.el"
    :added "2021-10-31"
    :emacs>= 24.3
    :ensure t
    :custom ((typescript-indent-level . 2))
    :mode "\\.ts$" "\\.tsx$")
  (leaf mmm-mode
    :doc "Allow Multiple Major Modes in a buffer"
    :req "cl-lib-0.2"
    :tag "tools" "languages" "faces" "convenience"
    :url "https://github.com/purcell/mmm-mode"
    :added "2021-10-31"
    :ensure t
    :custom ((mmm-submode-decoration-level . 2))
    :config
    (leaf edit-indirect
      :doc "Edit regions in separate buffers"
      :req "emacs-24.3"
      :tag "emacs>=24.3"
      :url "https://github.com/Fanael/edit-indirect"
      :added "2021-10-31"
      :emacs>= 24.3
      :ensure t)
    (leaf vue-html-mode
      :doc "Major mode for editing Vue.js templates"
      :tag "template" "vue" "languages"
      :url "http://github.com/AdamNiederer/vue-html-mode"
      :added "2021-10-31"
      :ensure t)
    (leaf ssass-mode
      :doc "Edit Sass without a Turing Machine"
      :req "emacs-24.3"
      :tag "sass" "languages" "emacs>=24.3"
      :url "http://github.com/AdamNiederer/ssass-mode"
      :added "2021-10-31"
      :emacs>= 24.3
      :ensure t)
    (leaf vue-mode
      :doc "Major mode for vue component based on mmm-mode"
      :req #("mmm-mode-0.5.5" 0 8
             (face nil)) #("vue-html-mode-0.2" 0 13
             (face nil)) #("ssass-mode-0.2" 0 10
             (face nil)) #("edit-indirect-0.1.4" 0 13
             (face nil))
      :tag "languages"
      :added "2021-10-31"
      :ensure t
      :after mmm-mode vue-html-mode ssass-mode edit-indirect
      :mode "\\.vue$")
    )
  (leaf yaml-mode
    :doc "Major mode for editing YAML files"
    :req "emacs-24.1"
    :tag "yaml" "data" "emacs>=24.1"
    :url "https://github.com/yoshiki/yaml-mode"
    :added "2021-10-31"
    :emacs>= 24.1
    :ensure t)
  )

(leaf org-modern
  :doc "Modern looks for Org"
  :req "emacs-27.1"
  :tag "emacs>=27.1"
  :url "https://github.com/minad/org-modern"
  :added "2022-11-14"
  :emacs>= 27.1
  :ensure t)

(leaf org
  :doc "Export Framework for Org Mode"
  :tag "builtin"
  :added "2021-10-31"
  :custom
  `((browse-at-remote-prefer-symbolic . nil)
    (org-startup-truncated . nil)
    (org-return-follows-link . t)
    (org-src-fontify-natively . t)
    (org-directory . "~/Nextcloud/memo/")
    (org-default-notes-file . "~/Nextcloud/memo/agenda.org")
    ;; TODO の状態
    (org-todo-keywords . '("TODO" "Wait" "DONE"))
    (org-todo-interpretation . 'sequence)
   ;; Capture templates for code-reading
   (org-capture-templates
    . '(("code-link"
         "Store the code-reading notes with GitHub and file links for the current cursor position."
         plain
         (function org-code-capture--find-store-point)
         "%^{Summary}\n%(with-current-buffer (org-capture-get :original-buffer) (browse-at-remote-get-url))\n# %a"
         :immediate-finish t)
        ("just-code-link"
         "Immediately store GitHub and file links for the current cursor position to the current code-reading notes."
         plain
         (function org-code-capture--find-store-point)
         "%(with-current-buffer (org-capture-get :original-buffer) (browse-at-remote-get-url))\n# %a"
         :immediate-finish t)
        ("t" "Todo" entry (file+headline org-default-notes-file "Inbox")
         "** TODO %?\n   %i\n   %a\n   %t")
        ("b" "Bug" entry (file+headline org-default-notes-file "Inbox")
         "** TODO %?   :bug:\n   %i\n   %a\n   %t")
        ("i" "Idea" entry (file+headline org-default-notes-file "New Ideas")
         "** %?\n   %i\n   %a\n   %t"))))
  :custom-face
  ((org-level-1 . '((t (:foreground "#859900"))))
   (org-level-2 . '((t (:foreground "#859900"))))
   (org-level-3 . '((t (:foreground "#859900"))))
   (org-level-4 . '((t (:foreground "#859900"))))
   (org-level-5 . '((t (:foreground "#859900"))))
   (org-level-6 . '((t (:foreground "#859900"))))
   (org-level-7 . '((t (:foreground "#859900"))))
   (org-level-8 . '((t (:foreground "#859900"))))
   (org-link . '((t (:foreground "#839496" :weight normal)))))
  :preface
  (defun my-open-agenda ()
    (interactive)
    (find-file "~/Nextcloud/memo/agenda.org"))

  (defun my-open-standup-meeting ()
    (interactive)
    (find-file "~/Nextcloud/memo/standup-meeting.org"))

  (defun my-open-cheat-sheet ()
    (interactive)
    (find-file "~/Nextcloud/memo/cheat-sheet.org"))

  (defun insert-next-date ()
    (let* ((time (decode-time (current-time))))
      (setf (elt time 3) (+ (elt time 3) 1))
      (format-time-string "%Y-%m-%d(%a)" (apply 'encode-time time))))

  (defun insert-this-date ()
    (let* ((time (decode-time (current-time))))
      (format-time-string "%Y-%m-%d(%a)" (apply 'encode-time time))))

  (defun insert-this-date-to-current-position ()
    (interactive)
    (insert (insert-this-date)))
  :mode "\\.org$"
  :hook ((org-mode-hook . org-modern-mode)
         (org-agenda-finalize-hook . org-modern-agenda))
  ;; :chord (("op" . org-remember))
  :bind (("C-c a" . org-agenda)
         ("C-z a" . my-open-agenda)
         ("C-z s" . my-open-standup-meeting)
         ("C-z c" . my-open-cheat-sheet)
         ("C-z t" . insert-this-date-to-curent-position))
  :config
  (require 'ox-md)
  ;;; start https://ladicle.com/post/20200625_123915/
  (defconst okkez/org-journal-dir "~/Nextcloud/org/journal/")
  (defconst okkez/org-journal-file-format (concat okkez/org-journal-dir "%Y-%m-%d.org"))

  (defvar org-code-capture--store-file "")
  (defvar org-code-capture--store-header "")

  ;; This function is used in combination with a coding template of org-capture.
  (defun org-code-capture--store-here ()
    "Register current subtree as a capture point."
    (interactive)
    (setq org-code-capture--store-file (buffer-file-name))
    (setq org-code-capture--store-header (nth 4 (org-heading-components))))

  ;; This function is used with a capture-template for (function) type.
  ;; Look for headline that registered at `org-code-capture--store-header`.
  ;; If the matching subtree is not found, create a new Capture tree.
  (defun org-code-capture--find-store-point ()
    "Find registered capture point and move the cursor to it."
    (let ((filename (if (string= "" org-code-capture--store-file)
                        (format-time-string okkez/org-journal-file-format)
                      org-code-capture--store-file)))
      (set-buffer (org-capture-target-buffer filename)))
    (goto-char (point-min))
    (unless (derived-mode-p 'org-mode)
      (error
       "Target buffer \"%s\" for org-code-capture--find-store-file should be in Org mode"
       (current-buffer))
      (current-buffer))
    (if (re-search-forward org-code-capture--store-header nil t)
        (goto-char (point-at-bol))
      (goto-char (point-max))
      (or (bolp) (insert "\n"))
      (insert "* Capture\n")
      (beginning-of-line 0))
    (org-end-of-subtree))
  ;;; end https://ladicle.com/post/20200625_123915/
  )


(provide 'init)

;; Local Variables:
;; indent-tabs-mode: nil
;; End:

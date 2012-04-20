;; el-get は deb で入れるので自動インストールしない
(require 'el-get)

;; el-get-list-packages で f でレシピを開く
(defun el-get-current-recipe ()
  "get recipe name of current line"
  (save-excursion
    (beginning-of-line)
    (buffer-substring
     (progn (skip-chars-forward " \t") (point))
     (progn (skip-chars-forward "^ \t") (point)))))

(defun el-get-find-recipe-at-line ()
  "find recipe of current line"
  (interactive)
  (let ((package (el-get-current-recipe)))
    (el-get-find-recipe-file package)))

(add-hook
 'el-get-package-menu-mode-hook
 '(lambda ()
    (define-key el-get-package-menu-mode-map "f" 'el-get-find-recipe-at-line)))

;; システムのレシピを上書きできる
;; システムに入ってないレシピも記述する
(setq el-get-sources
      '((:name rinari
               :description "Rinari Is Not A Rails IDE"
               :type git
               :url "https://github.com/eschulte/rinari.git"
               :load-path ("." "util" "util/jump")
               :compile ("\\.el$" "util")
               :features rinari)
        (:name yasnippet
               :website "https://github.com/capitaomorte/yasnippet"
               :description "YASnippet is a template system for Emacs."
               :type git
               :url "https://github.com/capitaomorte/yasnippet.git"
               :features "yasnippet"
               :prepare (lambda ()
                          ;; Set up the default snippets directory
                          ;;
                          ;; Principle: don't override any user settings
                          ;; for yas/snippet-dirs, whether those were made
                          ;; with setq or customize.  If the user doesn't
                          ;; want the default snippets, she shouldn't get
                          ;; them!
                          (unless (or (boundp 'yas/snippet-dirs) (get 'yas/snippet-dirs 'customized-value))
                            (setq yas/snippet-dirs
                                  (list (concat el-get-dir (file-name-as-directory "yasnippet") "snippets")))))
               :post-init (lambda ()
                            ;; Trick customize into believing the standard
                            ;; value includes the default snippets.
                            ;; yasnippet would probably do this itself,
                            ;; except that it doesn't include an
                            ;; installation procedure that sets up the
                            ;; snippets directory, and thus doesn't know
                            ;; where those snippets will be installed.  See
                            ;; http://code.google.com/p/yasnippet/issues/detail?id=179
                            (put 'yas/snippet-dirs 'standard-value
                                 ;; as cus-edit.el specifies, "a cons-cell
                                 ;; whose car evaluates to the standard
                                 ;; value"
                                 (list (list 'quote
                                             (list (concat el-get-dir (file-name-as-directory "yasnippet") "snippets"))))))
               ;; byte-compile load vc-svn and that fails
               ;; see https://github.com/dimitri/el-get/issues/200
               :compile nil)
        (:name yasnippets-rails
               :description "yasnippets-rails"
               :depends yasnippet
               :type git
               :url "https://github.com/eschulte/yasnippets-rails.git"
               :complile nil)
        (:name sass-mode
               :description "Major mode for editing Sass files"
               :type git
               :url "https://github.com/nex3/sass-mode.git"
               :features sass-mode
               :depends haml-mode
               :post-init (lambda ()
                            (add-to-list 'auto-mode-alist
                                         '("\\.scss$" . sass-mode))))
        (:name grep-edit
               :description "Edit grep result"
               :type http
               :url "http://www.bookshelf.jp/elc/grep-edit.el")
        (:name japanese-holidays
               :description "Japanese Holidays"
               :type http
               :url "http://www.meadowy.org/meadow/netinstall/export/799/branches/3.00/pkginfo/japanese-holidays/japanese-holidays.el")
        (:name js2-mode
               :description "A major mode for JavaScript"
               :type git
               :url "https://github.com/mooz/js2-mode.git")
        (:name key-chord
               :description "map pairs of simultaneously pressed keys to commands"
               :type emacswiki
               :features "key-chord")
        (:name recentf-ext
               :description "Recentf extension"
               :type emacswiki
               :features "recentf-ext")
        ))

;; 自分用パッケージリストの初期化
;; 設定ファイル名とレシピ名が一致するものは自動でパッケージリストに追加
(setq
 my-el-get-packages
 (remove-if-not '(lambda (pkg)
                   (el-get-recipe-filename pkg))
                my-emacs-misc-config))

;; 設定ファイル名とレシピ名が一致しないものは自分で追加
(mapcar '(lambda (elem)
           (add-to-list 'my-el-get-packages elem))
        '(ruby-electric
          sass-mode
          yasnippets-rails
          japanese-holidays
          grep-edit
          color-theme-solarized
          key-chord
          recentf-ext
          ))

(el-get 'sync my-el-get-packages)


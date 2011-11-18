;; el-get は deb で入れるので自動インストールしない
(require 'el-get)

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
        ))

;; 自分用パッケージリストの初期化
;; 設定ファイル名とレシピ名が一致するものは自動でパッケージリストに追加
(setq
 my-el-get-packages
 (remove-if-not '(lambda (pkg)
                   (el-get-recipe-filename pkg))
                my-emacs-misc-config))

;; 設定ファイル名とレシピ名が一致しないものは自分で追加
(add-to-list 'my-el-get-packages 'ruby-electric)
(add-to-list 'my-el-get-packages 'sass-mode)
(add-to-list 'my-el-get-packages 'yasnippets-rails)

(el-get 'sync my-el-get-packages)


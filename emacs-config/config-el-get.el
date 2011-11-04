;; el-get は deb で入れるので自動インストールしない
(require 'el-get)

;; システムのレシピを上書きできる
;; システムに入ってないレシピも記述する
(setq el-get-sources
      '((:name ruby-electric
               :description "Electric commands editing for ruby files"
               :type elpa
               :post-init nil)
        (:name rinari
               :description "Rinari Is Not A Rails IDE"
               :type git
               :url "https://github.com/eschulte/rinari.git"
               :load-path ("." "util" "util/jump")
               :compile ("\\.el$" "util")
               :features rinari)
        (:name yasnippets-rails
               :description "yasnippets-rails"
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

(el-get 'sync my-el-get-packages)


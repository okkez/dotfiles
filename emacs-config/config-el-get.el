;; el-get は deb で入れるので自動インストールしない
(require 'el-get)

;; additional recipes path
(add-to-list 'el-get-recipe-path
             (concat (file-name-directory load-file-name) "recipes"))

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
          color-theme-solarized
          recentf-ext
          ))

(el-get 'sync my-el-get-packages)


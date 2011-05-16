;;; http://github.com/znz/dot-emacs/raw/master/init.el.d/50rd-mode.el
(require 'static)
(static-when (locate-library "rd-mode")
  ;; るりまの
  ;; http://jp.rubyist.net/svn/rurema/doctree/trunk/
  ;; の中の refm/api/src/ 以下の拡張子がないファイルも
  ;; rd-mode にする。
  (add-to-list 'auto-mode-alist '("/refm/api/src/[^.]+\\'" . rd-mode))
  (defvar rd-method-list-face 'font-lock-function-name-face)
  (defvar rd-rurema-comment-face 'font-lock-comment-face)
  (defvar rd-rurema-keyword-face 'font-lock-keyword-face)
  (defvar rd-rurema-builtin-face 'font-lock-builtin-face)
  (defvar rd-rurema-param-face 'font-lock-variable-name-face)
  (defvar rd-rurema-todo-face 'font-lock-warning-face)
  (defun my-rd-mode-hook-function ()
    ;; http://redmine.ruby-lang.org/wiki/rurema/ReferenceManualFormatDigest
    ;; リンク
    (add-to-list
     'rd-font-lock-keywords
     `(,(concat
         "\\[\\["
         "\\(?:"
         ;; クラス [[c:String]]、[[c:File::Stat]] など
         ;; 定数 [[m:File::SEPARATOR]] など
         "[cm]:[A-Z][A-Za-z_0-9:]*"
         "\\|"
         ;; クラスメソッド [[m:String.new]]
         ;; モジュール関数 [[m:Math.#sin]] (「.#」なのに注意)
         "m:[A-Z][A-Za-z_:]*\\.#?[a-z_]+"
         "\\|"
         ;; インスタンスメソッド
         ;; [[m:String#dump]]、![[m:String#[] ]]など ([]の場合のみ空白必須なのに注意)
         "m:[A-Z][A-Za-z_0-9:]*#\\(\\[\\] \\|[^][ ]+\\)"
         "\\|"
         ;; グローバル変数 [[m:$~]] など
         "m:\\$.+"
         "\\|"
         ;; ライブラリ [[lib:jcode]] など
         "lib:[^][ ]+"
         "\\|"
         ;; ruby-list [[ruby-list:12345]] など
         "ruby-\\(list\\|dev\\|ext\\|talk\\|core\\):[0-9]+"
         "\\|"
         ;; man [[man:tr(1)]] など
         "man:[^()]+([0-9])"
         "\\|"
         ;; RFC [[RFC:2822]] など
         "\\(RFC\\|rfc\\):[0-9]+"
         "\\|"
         ;; URL [[url:http://i.loveruby.net]]
         "url:[^][ ]+"
         "\\)"
         "\\]\\]") 0 rd-link-face t))
    ;; クラス、モジュールの説明の見出し(typoがあれば色でわかる)
    (add-to-list
     'rd-font-lock-keywords
     `(,(concat
         "^== \\("
         (regexp-opt
          '("Class Methods"
            "Singleton Methods"
            "Private Singleton Methods"
            "Protected Singleton Methods"
            "Instance Methods"
            "Private Instance Methods"
            "Protected Instance Methods"
            "Module Functions"
            "Constants"
            "Special Variables"))
         "\\)$")
       (0 rd-heading2-face)
       (1 rd-rurema-builtin-face t)
       ))
    ;; クラス、モジュールの冒頭、ファイル全体の冒頭
    (add-to-list
     'rd-font-lock-keywords
     `(,(concat
         "^\\("
         (regexp-opt
          '("alias"
            "extend"
            "include"
            "require"))
         "\\)\\s +\\([A-Za-z0-9_:]+\\)")
       (1 rd-rurema-builtin-face)
       (2 rd-rurema-param-face)))
    ;; メソッドの引数の情報、発生する例外
    (add-to-list
     'rd-font-lock-keywords
     `(,(concat
         "^\\(@"
         (regexp-opt
          '("param"
            "raise"))
         "\\)\\s +\\([A-Za-z0-9_:]+\\)")
       (1 rd-rurema-builtin-face)
       (2 rd-rurema-param-face)))
    ;; 返り値の情報、他に参照すべきメソッドなど
    (add-to-list
     'rd-font-lock-keywords
     `(,(concat
         "^@"
         (regexp-opt
          '("return"
            "see"))
         ) 0 rd-rurema-builtin-face))
    ;; メソッドシグネチャ
    (add-to-list 'rd-font-lock-keywords
                 '("^--- .*$" 0 rd-method-list-face))
    ;; BitClust のコメント
    (add-to-list 'rd-font-lock-keywords
                 '("^#@#.*$" 0 rd-rurema-comment-face))
    ;; BitClust への命令
    (add-to-list
     'rd-font-lock-keywords
     `(,(concat
         "^#@"
         (regexp-opt
          '("include"
            "since"
            "end"
            "else"
            "until"
            "if"))
         ".*$") 0 rd-rurema-keyword-face))
    ;; 書きかけの印
    (add-to-list 'rd-font-lock-keywords
                 '("^#@todo.*$" 0 rd-rurema-todo-face))
    (setq imenu-generic-expression '((nil "^[=+-]+.+" 0)))
    )
  (add-hook 'rd-mode-hook #'my-rd-mode-hook-function))

;;; Local Variables:
;;; mode: emacs-lisp
;;; coding: utf-8
;;; indent-tabs-mode: nil
;;; End:

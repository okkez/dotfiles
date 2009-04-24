;; prefix key
(defvar my-prefix "\C-z" "*Prefix key for my favorite.")
(defvar my-map (make-sparse-keymap) "*Keymap for `my-prefix' commands.")
(define-key global-map my-prefix my-map)

;; 改行でインデントする
(global-set-key "\C-m" 'newline-and-indent)

;; バッファ全体をインデントする
(global-set-key "\C-x\C-i"
                '(lambda ()
                   (interactive)
                   (indent-region (point-min) (point-max) nil)))

;; other-window を逆回りにする
(global-set-key "\C-x\p"
                '(lambda ()
                   (interactive)
                   (other-window -1)))

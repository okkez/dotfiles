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

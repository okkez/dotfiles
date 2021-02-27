;; prefix key
(defvar my-prefix "\C-z" "*Prefix key for my favorite.")
(defvar my-map (make-sparse-keymap) "*Keymap for `my-prefix' commands.")
(define-key global-map my-prefix my-map)

;; 改行でインデントする
(global-set-key "\C-m" 'newline-and-indent)

;; バッファ全体をインデントする
(global-set-key (kbd "C-x C-i")
                '(lambda ()
                   (interactive)
                   (indent-region (point-min) (point-max) nil)))

;; other-window を逆回りにする
(global-set-key (kbd "C-x p")
                '(lambda ()
                   (interactive)
                   (other-window -1)))

;; ウィンドウを n 等分に分割する
(defun split-window-vertically-n (num_wins)
  (interactive "p")
  (if (= num_wins 2)
      (split-window-vertically)
    (progn
      (split-window-vertically
       (- (window-height) (/ (window-height) num_wins)))
      (split-window-vertically-n (- num_wins 1)))))
(defun split-window-horizontally-n (num_wins)
  (interactive "p")
  (if (= num_wins 2)
      (split-window-horizontally)
    (progn
      (split-window-horizontally
       (- (window-width) (/ (window-width) num_wins)))
      (split-window-horizontally-n (- num_wins 1)))))

(defun other-window-or-split ()
  (interactive)
  (when (one-window-p)
    (if (>= (window-body-width) 270)
        (split-window-horizontally-n 3)
      (split-window-horizontally)))
  (other-window 1))
(global-set-key (kbd "<C-tab>") 'other-window-or-split)

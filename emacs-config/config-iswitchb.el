(iswitchb-mode 1)

(add-hook 'iswitchb-define-mode-map-hook
	  'iswitchb-my-keys)

(defun iswitchb-my-keys ()
  "Add my keybindings for iswitchb."
  (define-key iswitchb-mode-map [right] 'iswitchb-next-match)
  (define-key iswitchb-mode-map [left] 'iswitchb-prev-match)
  (define-key iswitchb-mode-map "\C-f" 'iswitchb-next-match)
  (define-key iswitchb-mode-map " " 'iswitchb-next-match)
  (define-key iswitchb-mode-map "\C-b" 'iswitchb-prev-match)
  )

(defun iswitchb-possible-new-buffer (buf)
  "Possibly create and visit a new buffer called BUF."
  (interactive)
  (message (format
	    "No buffer matching `%s', "
	    buf))
  (sit-for 1)
  (call-interactively 'find-file buf))

(defun iswitchb-buffer (arg)
  "Switch to another buffer.

The buffer name is selected interactively by typing a substring.  The
buffer is displayed according to `iswitchb-default-method' -- the
default is to show it in the same window, unless it is already visible
in another frame.
For details of keybindings, do `\\[describe-function] iswitchb'."
  (interactive "P")
  (if arg
      (call-interactively 'switch-to-buffer)
    (setq iswitchb-method iswitchb-default-method)
    (iswitchb)))

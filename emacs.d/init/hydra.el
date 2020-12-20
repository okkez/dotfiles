(el-get-bundle hydra-posframe)

(el-get-bundle hydra
  (defhydra hydra-zoom ()
    "zoom"
    ("g" text-scale-increase "in")
    ("l" text-scale-decrease "out"))

  (defhydra hydra-window (:color red :hint nil)
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

  (defhydra hydra-counsel (:hint nil :exit t)
    "
 Describe^^               Ring^^           Other^^
----------------------------------------------------------
 [_f_] describe-function  [_y_] yank-pop   [_c_] org-capture
 [_b_] describe-binds     [_m_] mark-ring  [_u_] unicord-char
 [_v_] describe-variable  [_r_] recentf    [_e_] colors-emacs
 [_F_] describe-face      [_R_] register   [_w_] colors-web
 [_a_] apropos"
      ("b" counsel-descbinds)
      ("f" counsel-describe-function)
      ("v" counsel-describe-variable)
      ("F" counsel-describe-face)
      ("a" counsel-apropos)
      ("y" counsel-yank-pop)
      ("m" counsel-mark-ring)
      ("r" counsel-recentf)
      ("R" counsel-register)
      ("u" counsel-unicode-char)
      ("c" counsel-org-capture)
      ("e" counsel-colors-emacs)
      ("w" counsel-colors-web))

  (defhydra hydra-avy (:exit t :hint nil)
    "
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

  (with-eval-after-load-feature 'key-chord
    (key-chord-define-global "gg" 'hydra-avy/body)
    (key-chord-define-global "cx" 'hydra-counsel/body)
    (key-chord-define-global "ww" 'hydra-window/body)
    (key-chord-define-global "zz" 'hydra-zoom/body))

  (hydra-posframe-mode 1))

(el-get-bundle hydra-posframe
  :url "https://github.com/Ladicle/hydra-posframe.git"
  :features hydra-posframe)

(el-get-bundle hydra
  (with-eval-after-load-feature 'hydra-posframe
    (hydra-posframe-mode 1))

  (defhydra hydra-zoom ()
    "zoom"
    ("g" text-scale-increase "in")
    ("l" text-scale-decrease "out"))

  (defhydra hydra-counsel (:hint nil :exit t)
    "
Counsel: describ-_f_unction     find-_L_ibrary   _u_nicode-char
         _d_escbinds            _l_ocate         _y_ank-pop
         describ-_v_ariable     _a_g             _m_ark-ring
         _i_nfo-lookup-symbol   _g_it-grep       org-_c_apture
         a_p_ropos              _r_g             _s_k
         "
    ("d" counsel-descbinds)
    ("y" counsel-yank-pop)
    ("m" counsel-mark-ring)
    ("f" counsel-describe-function)
    ("v" counsel-describe-variable)
    ("p" counsel-apropos)
    ("L" counsel-find-library)
    ("i" counsel-info-lookup-symbol)
    ("u" counsel-unicode-char)
    ("g" counsel-git-grep)
    ("i" counsel-git)
    ("a" counsel-ag)
    ("r" counsel-rg)
    ("l" counsel-locate)
    ("s" counsel-sk)
    ("c" counsel-org-capture))
  (defhydra hydra-window (:color red :hint nil)
    "
Window: _v_sprit  _h_sprit  _o_ther  _s_wap  e_x_change  _a_ce-window del_0_:_1_
Frame: _n_ew  _m_ove  _d_el"
    ("v" split-window-right)
    ("h" split-window-below)
    ("o" other-window-or-split)
    ("s" window-swap-states)
    ("x" window-toggle-division)
    ("a" ace-window :exit t)
    ("0" delete-window :exit t)
    ("1" delete-other-windows :exit t)
    ;; Common setting with hydra-work
    ("_" delete-other-windows :exit t)
    ("n" new-frame)
    ("m" other-frame)
    ("d" delete-frame :exit t))
  (with-eval-after-load-feature 'key-chord
    (key-chord-define-global "cc" 'hydra-counsel/body)
    (key-chord-define-global "ww" 'hydra-window/body)
    (key-chord-define-global "zz" 'hydra-zoom/body))
  )

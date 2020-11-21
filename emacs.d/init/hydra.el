(el-get-bundle hydra-posframe
  :url "https://github.com/Ladicle/hydra-posframe.git"
  :features hydra-posframe)

(el-get-bundle hydra
  (with-eval-after-load-feature 'hydra
    (hydra-posframe-enable))

  (defhydra hydra-zoom (global-map "<f2>")
    "zoom"
    ("g" text-scale-increase "in")
    ("l" text-scale-decrease "out"))

  (with-eval-after-load-feature 'key-chord
    (key-chord-define-global
     "cc"
     (defhydra hydra-counsel (:hint nil :exit t)
       "
Counsel: describ-_f_unction   _i_nfo-lookup-symbol    _d_escbinds
        _y_ank-pop            _l_ocate                _a_g
         describ-_v_ariable   find-_L_ibrary          _u_nicode-char
         _m_ark-ring          _g_it-grep              _r_g"
       ("d" counsel-descbinds)
       ("y" counsel-yank-pop)
       ("m" counsel-mark-ring)
       ("f" counsel-describe-function)
       ("v" counsel-describe-variable)
       ("L" counsel-find-library)
       ("i" counsel-info-lookup-symbol)
       ("u" counsel-unicode-char)
       ("g" counsel-git-grep)
       ("i" counsel-git)
       ("a" counsel-ag)
       ("r" counsel-rg)
       ("l" counsel-locate)))

    (key-chord-define-global
     "ww"
     (defhydra hydra-window (:color red :hint nil)
   "
Window: _v_sprit  _h_sprit  _o_ther  _s_wap  e_x_change  del_0_:_1_
Frame: _n_ew  _m_ove  _d_el"
   ("v" split-window-right)
   ("h" split-window-below)
   ("o" other-window-or-split)
   ("s" window-swap-states)
   ("x" window-toggle-division)
   ("0" delete-window :exit t)
   ("1" delete-other-windows :exit t)
   ;; Common setting with hydra-work
   ("_" delete-other-windows :exit t)
   ("n" new-frame)
   ("m" other-frame)
   ("d" delete-frame :exit t)))
  )

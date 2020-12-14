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

  (with-eval-after-load-feature 'key-chord
    (key-chord-define-global "cx" 'hydra-counsel/body)
    (key-chord-define-global "ww" 'hydra-window/body)
    (key-chord-define-global "zz" 'hydra-zoom/body))

  (hydra-posframe-mode 1))

(el-get-bundle dumb-jump
  (add-hook 'xref-backend-functions #'dumb-jump-xref-activate)

  (setq dumb-jump-default-project "")
  (setq dumb-jump-prefer-searcher 'rg)

  (defhydra hydra-dumb-jump (:color blue :columns 3)
    "Dumb Jump"
    ("j" dumb-jump-go "Go")
    ("o" dumb-jump-go-other-window "Other window")
    ("e" dumb-jump-go-prefer-external "Go external")
    ("x" dumb-jump-go-prefer-external-other-window "Go external other window")
    ("i" dumb-jump-go-prompt "Prompt")
    ("l" dumb-jump-quick-look "Quick look")
    ("b" dumb-jump-back "Back"))

  (with-eval-after-load-feature 'key-chord
    (key-chord-define-global "dj" 'hydra-dumb-jump/body))
  )

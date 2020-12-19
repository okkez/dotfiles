(el-get-bundle smart-jump
  (smart-jump-setup-default-registers)
  (add-hook 'xref-backend-functions #'dumb-jump-xref-activate)

  (custom-set-variables
   '(dumb-jump-default-project "")
   '(dumb-jump-prefer-searcher 'rg))

  (with-eval-after-load-feature 'hydra
    (defhydra hydra-dumb-jump (:color blue :columns 3)
      "Dumb Jump"
      ("j" dumb-jump-go "Go")
      ("o" dumb-jump-go-other-window "Other window")
      ("e" dumb-jump-go-prefer-external "Go external")
      ("x" dumb-jump-go-prefer-external-other-window "Go external other window")
      ("i" dumb-jump-go-prompt "Prompt")
      ("l" dumb-jump-quick-look "Quick look")
      ("b" dumb-jump-back "Back")))

  (with-eval-after-load-feature 'key-chord
    (key-chord-define-global "dj" 'hydra-dumb-jump/body))
  )

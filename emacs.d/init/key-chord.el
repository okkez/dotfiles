(el-get-bundle zk-phi/key-chord
  :features key-chord
  (setq key-chord-two-keys-delay 0.15
        key-chord-safety-interval-backward 0.1
        key-chord-safety-interval-forward  0.25)
  (key-chord-mode 1)
  (key-chord-define-global "jk" 'view-mode))

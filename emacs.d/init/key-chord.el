(el-get-bundle key-chord
  :url https://github.com/zk-phi/key-chord.git
  :features key-chord
  (require 'key-chord)
  (setq key-chord-two-keys-delay 0.15
        key-chord-safety-interval-backward 0.1
        key-chord-safety-interval-forward  0.25)
  (key-chord-mode 1)
  (key-chord-define-global "jk" 'view-mode))

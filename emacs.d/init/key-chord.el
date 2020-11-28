(el-get-bundle key-chord
  :url https://github.com/zk-phi/key-chord.git
  :features key-chord
  (require 'key-chord)
  (setq key-chord-two-keys-delay 0.04)
  (key-chord-mode 1)
  (key-chord-define-global "jk" 'view-mode))

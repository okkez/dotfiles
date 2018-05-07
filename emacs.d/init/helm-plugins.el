(el-get-bundle helm-gtags
  (require 'helm-gtags))
(add-hook 'c-mode-hook 'helm-gtags-mode)
(add-hook 'helm-gtags-mode-hook
          '(lambda ()
             (local-set-key (kbd "M-.") 'helm-gtags-find-tag)
             (local-set-key (kbd "M-,") 'helm-gtags-find-rtag)
             (local-set-key (kbd "M-?") 'helm-gtags-find-symbol)
             (local-set-key (kbd "M-*") 'helm-gtags-pop-stack)))

(el-get-bundle helm-swoop
  (require 'helm-swoop)
  (global-set-key (kbd "M-o") 'helm-swoop))
(el-get-bundle helm-ag
  (require 'helm-ag)
  (global-set-key (kbd "M-g .") 'helm-ag)
  (global-set-key (kbd "M-g ,") 'helm-ag-pop-stack)
  (global-set-key (kbd "C-M-s") 'helm-ag-this-file))

(el-get-bundle helm-ls-git
  (require 'helm-ls-git)
  (global-set-key (kbd "C-:") 'helm-ls-git-ls)
  (custom-set-variables
   '(helm-ls-git-show-abs-or-relative 'relative)))

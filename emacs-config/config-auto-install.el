(require 'auto-install)
(setq auto-install-directory "~/.elisp/repos/")
(condition-case nil
    (auto-install-update-emacswiki-package-name t)
  (error (message "couldn't update package name, ignore error...")))
(auto-install-compatibility-setup)

; -*- mode: emacs-lisp; lexical-binding: t; -*-

(defconst my:default-gc-cons-threshold gc-cons-threshold)
(setq gc-cons-threshold (* 128 1024 1024))
(defun my:set-gc-cons-threshold ()
  (setq gc-cons-threshold my:default-gc-cons-threshold))
(add-hook 'emacs-startup-hook 'my:set-gc-cons-threshold)

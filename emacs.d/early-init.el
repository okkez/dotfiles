; -*- mode: emacs-lisp; lexical-binding: t; -*-

;; GTK3 子フレーム(posframe / vertico-posframe)の再描画漏れ対策。
;; Hyprland など非リパアレント型(タイル型)のコンポジタ下では描画が
;; 抜けて「文字が出ない」ことがあるため resize-mode を指定する。
;; フレーム生成前に設定する必要があるので early-init で設定する。
(setq x-gtk-resize-child-frames 'resize-mode)

(defconst my:default-gc-cons-threshold gc-cons-threshold)
(setq gc-cons-threshold (* 128 1024 1024))
(defun my:set-gc-cons-threshold ()
  (setq gc-cons-threshold my:default-gc-cons-threshold))
(add-hook 'emacs-startup-hook 'my:set-gc-cons-threshold)

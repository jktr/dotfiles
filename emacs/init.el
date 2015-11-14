;;; UI

;; elements
(when (fboundp 'menu-bar-mode) (menu-bar-mode -1))
(when (fboundp 'tool-bar-mode) (tool-bar-mode -1))
(when (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))
(setq inhibit-startup-screen t)

;; color
(add-to-list 'default-frame-alist '(foreground-color . "#C2C2C2"))
(add-to-list 'default-frame-alist '(background-color . "#000000"))

;; controls

(require 'mouse)
(xterm-mouse-mode t)


;;; Packages & Modes

;; repos
(require 'package)
(add-to-list 'package-archives'
	     ("melpa-stable". "http://stable.melpa.org/packages/") t)
(package-initialize)

;; clojure mode
(require 'clojure-mode)


;;; Editing Style
(setq require-final-newline t)

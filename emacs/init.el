
(require 'package)
(add-to-list 'package-archives'
	     ("melpa-stable". "http://stable.melpa.org/packages/") t)
(package-initialize)

;; clojure support
(require 'clojure-mode)

;; mouse-support
(require 'mouse)
(xterm-mouse-mode t)

;; ;; use xclip to copy/paste in emacs-nox
;; (unless window-system
;;   (when (getenv "DISPLAY")
;;     (defun xclip-cut-function (text &optional push)
;;       (with-temp-buffer
;; 	(insert text)
;; 	(call-process-region (point-min) (point-max)
;; 			     "xclip" nil 0 nil "-i" "-selection" "clipboard")))
;;     (defun xclip-paste-function ()
;;       (let ((xclip-output (shell-command-to-string "xclip -o -selection clipboard")))
;; 	(unless (string= (car kill-ring) xclip-output)
;; 	  xclip-output)))
;;     (setq interprogram-cut-function 'xclip-cut-function)
;;     (setq interprogram-paste-function 'xclip-paste-function)
;;     ))

;; misc
(setq require-final-newline t)

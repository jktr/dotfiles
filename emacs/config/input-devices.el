;;; input-devices.el
;;; special input device configurations

;; allow mouse use
(require 'mouse)
(xterm-mouse-mode t)

;; disable accelerating scoll - far less jumpy now
(setq mouse-wheel-progressive-speed nil) 

;;; auto-complete.el
;;; see http://auto-complete.org/doc/manual.html

;; provide ac dicts - defaults to  ~/.dict
;(add-to-list 'ac-dictionary-directories "~/.dict")

;; auto configuration
(require 'auto-complete-config)
(ac-config-default)

;; AC keybind
(define-key ac-mode-map (kbd "M-TAB") 'auto-complete)

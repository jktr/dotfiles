;;; mutt.el
;;; nicities when using mutt to compose email

(add-to-list 'auto-mode-alist '("^/tmp/mutt-.*" . message-mode))
(add-to-list 'auto-mode-alist '("^/tmp/neomutt-.*" . message-mode))

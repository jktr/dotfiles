;;; rainbow-delimiters.el
;;; add rainbow parens


;; require
(require 'rainbow-delimiters)

;; add to most modes (v24+)
(add-hook 'prog-mode-hook 'rainbow-delimiters-mode)

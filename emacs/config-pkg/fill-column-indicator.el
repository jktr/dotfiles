;;; fill-column-indicator.el
;;; enable 80 cols delimiter

(require 'fill-column-indicator)

(setq fci-rule-width 1)
(setq fci-rule-color "#C2C2C2")
(setq fci-rule-column 80)

;; enable for most mode
(add-hook 'prog-mode-hook 'fci-mode)

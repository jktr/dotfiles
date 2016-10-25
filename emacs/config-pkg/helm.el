;;; helm.el

(require 'helm)
(require 'helm-config) ; does autoconfig

;; use helm superset bindings
(global-set-key (kbd "M-x") 'helm-M-x)
(global-set-key (kbd "C-x C-f") 'helm-find-files)

;; global enable
(helm-mode 1)

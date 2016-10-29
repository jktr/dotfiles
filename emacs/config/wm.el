;;; wm.el
;;; configure ui components and frame/window-related keybinds

;; ui elements
(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)
(setq column-number-mode  1)
(setq inhibit-startup-screen t)

;; resize windows
(global-set-key (kbd "M-S-<left>")  'shrink-window-horizontally)
(global-set-key (kbd "M-S-<right>") 'enlarge-window-horizontally)
(global-set-key (kbd "M-S-<down>")  'shrink-window)
(global-set-key (kbd "M-S-<up>")    'enlarge-window)

;; move windows
(global-set-key (kbd "M-<left>")  'windmove-left)
(global-set-key (kbd "M-<right>") 'windmove-right)
(global-set-key (kbd "M-<up>")    'windmove-up)
(global-set-key (kbd "M-<down>")  'windmove-down)

;; disable suspend keybind
(global-unset-key (kbd "C-z"))

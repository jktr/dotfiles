;;; wm.el
;;; configure ui components and frame/window-related keybinds

;; ui elements
(when (fboundp 'menu-bar-mode)   (menu-bar-mode -1))
(when (fboundp 'tool-bar-mode)   (tool-bar-mode -1))
(when (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))
(setq column-number-mode  1)
(setq inhibit-startup-screen t)

;; let the WM (if graphical) manage windows
;(setq pop-up-frames 'graphic-only)

;; move between windows
;(global-set-key (kbd "C-c h") 'windmove-left)
;(global-set-key (kbd "C-c j") 'windmove-down)
;(global-set-key (kbd "C-c k") 'windmove-up)
;(global-set-key (kbd "C-c l") 'windmove-right)

;; resize windows
;(global-set-key (kbd "C-c C-h") 'shrink-window-horizontally)
;(global-set-key (kbd "C-c C-j") 'shrink-window)
;(global-set-key (kbd "C-c C-k") 'enlarge-window)
;(global-set-key (kbd "C-c C-l") 'enlarge-window-horizontally)

;; disable suspend keybind
;;   * next to massively overloaded C-x
;;   * wrecks havok when running a tiling window manager
;;   * server's running anyways, so C-x-5 doesn't loose any work
(global-unset-key (kbd "C-z"))

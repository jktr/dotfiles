;;; cider.el
;;; Clojure REPL configurations
;;; largely taken from https://github.com/flyingmachine/emacs-for-clojure/blob/master/customizations/setup-clojure.el

;; -- hooks --

;; add docs
;(add-hook 'cider-mode-hook 'cider-turn-on-eldoc-mode)

;; enable paredit in your REPL
(add-hook 'cider-repl-mode-hook 'paredit-mode)

;; -- history --
(setq cider-repl-history-file "~/.emacs.d/cider-history")
;; Wrap when navigating history.
(setq cider-repl-wrap-history t)

;; -- customize --

;; open repl buffer when ready
(setq cider-repl-pop-to-buffer-on-connect t)

;; on error, show message and causing buffer
;(setq cider-show-error-buffer t)
;(setq cider-auto-select-error-buffer t)


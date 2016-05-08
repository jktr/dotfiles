;;; clojure.el

(require 'clojure-mode)

;; -- hooks --

;; enable paredit
(add-hook 'clojure-mode-hook 'enable-paredit-mode)

;; handle camel case intelligently
(add-hook 'clojure-mode-hook 'subword-mode)

;; enable REPL
(add-hook 'clojure-mode-hook
          (lambda () (setq inferior-lisp-program "lein repl")))


;; -- startup --

;; use clojure-mode for other clojure-style files
(add-to-list 'auto-mode-alist '("\\.edn$" . clojure-mode))
(add-to-list 'auto-mode-alist '("\\.clj.*$" . clojure-mode))


;; -- customization --

(custom-set-variables
 '(clojure-indent-style :align-arguments))
 

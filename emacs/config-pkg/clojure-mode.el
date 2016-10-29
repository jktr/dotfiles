;;; clojure-mode.el

(require 'clojure-mode)

;; activate hooks
(mapc (apply-partially 'add-hook 'clojure-mode-hook)
      '(enable-paredit-mode
        subword-mode ;; move across camel-case
        (lambda () (setq inferior-lisp-program "lein repl"))
        ))

(setq clojure-indent-style :align-arguments)

;; use clojure-mode for other clojure-style files
(add-to-list 'auto-mode-alist '("\\.edn$" . clojure-mode))
(add-to-list 'auto-mode-alist '("\\.clj.*$" . clojure-mode))

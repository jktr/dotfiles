;;; paredit.el
;;; enable ParEdit

(autoload 'enable-paredit-mode "paredit"
  "Turn on pseudo-structural editing of Lisp code." t)

(mapc (lambda (hook) (add-hook hook #'enable-paredit-mode))
      '(emacs-lisp-mode-hook
        eval-expression-minitbuffer-setup-hook
        lisp-mode-hook
        lisp-interaction-mode-hook
        scheme-mode-hook
        clojure-mode
        ))
      

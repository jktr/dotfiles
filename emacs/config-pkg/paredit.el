;;; paredit.el
;;; enable ParEdit

(autoload 'enable-paredit-mode "paredit"
  "Turn on pseudo-structural editing of Lisp code." t)

;; enable paredit automatically, for builtin modes only
;; other modes should do this in their config file
(mapc (lambda (hook) (add-hook hook #'enable-paredit-mode))
      '(emacs-lisp-mode-hook
        eval-expression-minitbuffer-setup-hook
        ielm-mode-hook
        lisp-mode-hook
        lisp-interaction-mode-hook
        scheme-mode-hook
        ))

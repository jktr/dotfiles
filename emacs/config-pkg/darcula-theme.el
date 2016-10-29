;;; darcula-theme.el
;;; load color theme

; apply theme to new frames, even if running as daemon
; https://stackoverflow.com/questions/18904529/after-emacs-deamon-i-can-not-see-new-theme-in-emacsclient-frame-it-works-fr/34697306

(let ((setup-theme-for-frame (lambda (frame)
                               (load-theme 'darcula t))))
  (if (daemonp)
      (add-hook 'after-make-frame-functions setup-theme-for-frame)
    (funcall setup-theme-for-frame nil)))

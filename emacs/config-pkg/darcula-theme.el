;;; darcula-theme.el
;;; load color theme

; apply theme to new frames, even if running as daemon
; https://stackoverflow.com/questions/18904529/after-emacs-deamon-i-can-not-see-new-theme-in-emacsclient-frame-it-works-fr/34697306

(if (daemonp)
    (add-hook 'after-make-frame-functions
        (lambda (frame)
            (with-selected-frame frame
                (load-theme 'darcula t))))
    (load-theme 'darcula t))

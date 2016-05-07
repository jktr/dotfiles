;;; font.el
;;; customize general font defaults

;; set font size after frame is made
(if (daemonp)
    (add-hook 'after-make-frame-functions
        (lambda (frame)
            (with-selected-frame frame
              (set-face-attribute 'default nil :height 95))))
  (set-face-attribute 'default nil :height 95))


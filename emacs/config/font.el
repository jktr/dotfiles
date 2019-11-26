;;; font.el
;;; customize general font defaults

(let ((setup-font-for-frame (lambda (frame)
                              (set-face-attribute
                               'default frame
                               :height 95
                               ))))
  (if (daemonp)
      (add-hook 'after-make-frame-functions setup-font-for-frame)
    (funcall setup-font-for-frame nil)))

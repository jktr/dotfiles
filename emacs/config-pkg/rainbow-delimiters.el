;;; rainbow-delimiters.el
;;; add rainbow parens

;; require
(require 'rainbow-delimiters)

;; add to most modes
(add-hook 'prog-mode-hook 'rainbow-delimiters-mode)

;; customize colors
(custom-set-faces
 '(rainbow-delimiters-depth-1-face ((t (:foreground "#DDDDDD"))))
 '(rainbow-delimiters-depth-2-face ((t (:foreground "#7d7650"))))
 '(rainbow-delimiters-depth-3-face ((t (:foreground "#632E36"))))
 '(rainbow-delimiters-depth-4-face ((t (:foreground "#794ea3"))))
 '(rainbow-delimiters-depth-5-face ((t (:foreground "#384474"))))
 '(rainbow-delimiters-depth-6-face ((t (:foreground "#3D9970"))))
 '(rainbow-delimiters-depth-7-face ((t (:foreground "#2ECC40"))))
 '(rainbow-delimiters-depth-8-face ((t (:foreground "#39CCCC"))))
 '(rainbow-delimiters-depth-9-face ((t (:foreground "#0074D9"))))
 '(rainbow-delimiters-unmatched-face ((t (:foreground "#FC3912")))))

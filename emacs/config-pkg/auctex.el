;;; auctex.el

(mapc (apply-partially 'add-hook 'LaTeX-mode-hook)
      '(visual-line-mode
        LaTeX-math-mode
        turn-on-reftex
        auto-complete-mode
        flyspell-mode))

(setq-default
 preview-scale-function 1.5
 TeX-master nil)

(setq
 preview-auto-cache-preamble t
 TeX-auto-save t
 TeX-parse-self t
 TeX-PDF-mode t
 LaTeX-math-list '((" " LaTeX-math-partial)))

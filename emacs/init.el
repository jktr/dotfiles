;;; init.el
;;; initialize emacs configuration, and load package/configs

;; helpers

(defun load-config (conf-dir conf-name)
  (load (concat conf-dir "/" (symbol-name conf-name))))

(defun load-config-with-pkg-install (conf-dir pkg-name)
  (unless (package-installed-p pkg-name)
    (package-install pkg-name))
  (load-config conf-dir pkg-name))

;; setup repo
(require 'package)
(mapc (apply-partially 'add-to-list 'package-archives)
      '(("melpa-stable" . "http://stable.melpa.org/packages/")
        ("marmalade"    . "http://marmalade-repo.org/packages/")))
(setq package-user-dir "~/.emacs.d/elpa/")
(package-initialize)


;; require packages
(mapc (apply-partially 'load-config-with-pkg-install
                       "~/.emacs.d/config-pkg")
      '(rainbow-delimiters
        darcula-theme
        fill-column-indicator ; 80 cols rule
        ))


;; require configs for external packages
(mapc (apply-partially 'load-config
                       "~/.emacs.d/config-extern")
      '(clojure
        auctex))


;; load other configs
(mapc (apply-partially 'load-config
                       "~/.emacs.d/config")
      '(wm ; navigation & components
        color
        font
        syntax ; whitespace & encoding
        input-devices
        ))


;; clean up helpers
(fmakunbound 'load-config)
(fmakunbound 'load-config-with-pkg-install)

;;; init.el
;;; initialize emacs configuration, and load package/configs

;; helpers

(defun load-config (conf-dir conf-name)
  (load (concat conf-dir "/" conf-name)))

(defun load-config-with-pkg-install (conf-dir pkg-name)
  (unless (package-installed-p pkg-name)
    (package-install pkg-name))
  (load-config conf-dir pkg-name))


;; setup repos
(require 'package)
(add-to-list 'package-archives
	     '("melpa-stable" . "http://stable.melpa.org/packages/"))
(setq package-user-dir "~/.emacs.d/elpa/")
(package-initialize)


;; require packages
(mapc (apply-partially 'load-config-with-pkg-install
                       "~/.emacs.d/config-pkg")
      '())


;; require configs for external packages
(mapc (apply-partially 'load-config
                       "~/.emacs.d/config-extern")
      '("clojure"))


;; load other configs
(mapc (apply-partially 'load-config
                       "~/.emacs.d/config")
      '("syntax"
	"wm"
	"color"
        "input-devices"))


;; clean up helpers
(fmakunbound 'load-config)
(fmakunbound 'load-config-with-pkg-install)

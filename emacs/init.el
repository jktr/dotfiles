;;; init.el
;;; initialize emacs configuration, and load package/configs

;; helpers

(defun load-config (conf-dir conf-name)
  (load (concat conf-dir "/" (symbol-name conf-name)))) 

(defun load-configs (conf-dir &rest configs)
  (mapc (apply-partially 'load-config conf-dir) configs))
       
(defun load-package (conf-dir pkg)
  (unless (package-installed-p pkg)
    (package-install pkg))
  (load-config conf-dir pkg))

(defun load-packages (conf-dir &rest pkgs)
  (mapc (apply-partially 'load-package conf-dir) pkgs))


;; setup repos

(require 'package)
(mapc (apply-partially 'add-to-list 'package-archives)
      '(("melpa-stable" . "http://stable.melpa.org/packages/")
        ("marmalade"    . "http://marmalade-repo.org/packages/")))
(setq package-user-dir "~/.emacs.d/elpa/")
(package-initialize)
(when (not package-archive-contents)
  (package-refresh-contents))


;; set up basic configuration for emacs

(load-configs "~/.emacs.d/config"
              'wm ; navigation & components
              'color
              'font
              'syntax ; whitespace & encoding
              'input-devices
;              'backup
              )


;; set up repo-based packages, downloading as needed
(load-packages "~/.emacs.d/config-pkg"
  ;; autocomplete
               'auto-complete
               'which-key
  ;; appearance
               'darcula-theme
               'rainbow-delimiters
               'rainbow-mode
  ;; markdown
               'markdown-mode
  ;; lisp
               'paredit
  ;; clojure
               'clojure-mode
               'clojure-mode-extra-font-locking
               'cider ; clj* repl
               )


;; set up externally installed packages

(load-configs "~/.emacs.d/config-extern"           
             'auctex  ; from distro package manager
             'rainbow ; shipped with emacs
             )


;; clean up helpers

(mapc 'fmakunbound
      '(load-config
        load-configs
        load-package
        load-packages))


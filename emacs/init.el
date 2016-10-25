;;; init.el
;;; initialize emacs configuration, and load package/configs

;; helpers

(defun ensure-repos (&rest repos)
  (require 'package)
  (mapc (apply-partially 'add-to-list 'package-archives) repos)
  (setq package-user-dir "~/.emacs.d/elpa/")
  (package-initialize)
  (unless package-archive-contents
    (package-refresh-contents)))

(defun ensure-config-dirs (&rest dirs)
  (mapc (lambda (dir)
          (mapc 'load (directory-files dir 't "\\.el$"))) dirs))

(defun ensure-package-dirs (&rest dirs)
  (mapc (lambda (dir)
          (mapc (lambda (file)
                  (let ((pkg (intern (file-name-base file))))
                    (unless (package-installed-p pkg)
                      (package-install pkg))
                    (load-file file)))
                (directory-files dir 't "\\.el$")))
        dirs))

;; init

(ensure-config-dirs
 "~/.emacs.d/config"
 "~/.emacs.d/config-extern")

(ensure-repos
 '("melpa-stable" . "http://stable.melpa.org/packages/")
 '("marmalade"    . "http://marmalade-repo.org/packages/")
)

(ensure-package-dirs
 "~/.emacs.d/config-pkg")


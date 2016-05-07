;;; backup.el
;;; sane backup settings
;;; see https://www . emacswiki.org/emacs/BackupDirectory

;; autosave policy - store in /tmp
(setq auto-save-file-name-transforms
      `((".*" ,temporary-file-directory t)))

;; backups policy 
(setq
   ; store backups in /tmp
   backup-directory-alist '(("." . ,temporary-file-directory))
   ; handle symlinks correctly
   backup-by-copying      t
   ; delete old backup versions silently
   delete-old-versions    t)

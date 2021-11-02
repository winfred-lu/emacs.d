;; versioned backups
(setq vc-make-backup-files t
      version-control t        ; use version numbers for backups
      kept-new-versions 6
      kept-old-versions 2
      delete-old-versions t    ; don't ask to delete excess backup versions
      backup-by-copying t      ; don't clobber symlinks
      backup-directory-alist
      `((".*" . "~/.emacs.d/backups"))  ; don't litter my fs tree
      auto-save-file-name-transforms
      `((".*" "~/.emacs.d/autosaves/" t))
      )
(setq bookmark-save-flag 1)

;; remove the prompt for killing emacsclient buffers
(remove-hook 'kill-buffer-query-functions 'server-kill-buffer-query-function)

;; make buffer names unique
(use-package uniquify
  :defer 10
  :config
  (setq uniquify-buffer-name-style (quote forward)))

(use-package browse-kill-ring
  :commands browse-kill-ring
  :bind (("C-x k" . browse-kill-ring)))

;; dired settings
(autoload 'dired-jump "dired" t nil)
(add-hook 'dired-load-hook
          (lambda ()
            (load "dired-x")
            ))
(add-hook 'dired-mode-hook
          (lambda ()
            (dired-omit-mode 1)
            ))

;; search TAGS recursively each parent directory
(defun jds-find-tags-file ()
  "recursively searches each parent directory for a file named 'TAGS' and returns the
path to that file or nil if a tags file is not found. Returns nil if the buffer is
not visiting a file"
  (progn
    (defun find-tags-file-r (path)
      "find the tags file from the parent directories"
      (let* ((parent (file-name-directory path))
             (possible-tags-file (concat parent "TAGS")))
        (cond
         ((file-exists-p possible-tags-file) (throw 'found-it possible-tags-file))
         ((string= "/TAGS" possible-tags-file) (error "no tags file found"))
         (t (find-tags-file-r (directory-file-name parent))))))

    (if (buffer-file-name)
        (catch 'found-it
          (find-tags-file-r (buffer-file-name)))
      (error "buffer is not visiting a file"))))

(defun jds-set-tags-file-path ()
  "calls `jds-find-tags-file' to recursively search up the directory tree to find
a file named 'TAGS'. If found, set 'tags-table-list' with that path as an argument
otherwise raises an error."
  (interactive)
  (setq tags-table-list (cons (jds-find-tags-file) tags-table-list)))

;; delay search the TAGS file after open the source file
(add-hook 'emacs-startup-hook
          '(lambda () (jds-set-tags-file-path)))

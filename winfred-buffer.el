;; backups and autosaves
(setq backup-directory-alist `((".*" . "~/.d.emacs.d/backups"))
      auto-save-file-name-transforms `((".*" "~/.d.emacs.d/autosaves/\\1" t))
      require-final-newline t)

;; bookmarks file and autosaving
(setq bookmark-default-file "~/.d.emacs.d/bookmarks"
      bookmark-save-flag 1)

;; make buffer names unique
(require 'uniquify)
(setq uniquify-buffer-name-style (quote forward))

;;;;;;

(autoload 'dired-jump "dired" t nil)

;;;;;;

(setq ido-enable-flex-matching t
      ido-everywhere t)
(ido-mode t)
(loop for b in '("\\*Backtrace" "\\*Bookmark"
		 "\\*Buffer" "\\*Completions" "\\*Customize" "\\*Help"
                 "\\*Ibuffer"
                 "\\*Messages" "\\*cscope" "\\*etags-select" "\\*grep"
                 "\\*magit" "\\*scratch")
      do (add-to-list 'ido-ignore-buffers b))
(loop for d in '("\\`auto" "\\`backups/" "\\`CVS/")
      do (add-to-list 'ido-ignore-directories d))
(loop for f in '("tags" "\\`cscope." "\\.dep$")
      do (add-to-list 'ido-ignore-files f))

;;;;;;

(defun show-buffer-full-name ()
  "Show the full path file name in the minibuffer."
  (interactive)
  (message (buffer-file-name)))

;;;;;;

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


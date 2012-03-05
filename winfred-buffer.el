;; backups and autosaves
(setq backup-directory-alist `((".*" . "~/.emacs.d/backups"))
      auto-save-file-name-transforms `((".*" "~/.emacs.d/autosaves/\\1" t))
      require-final-newline t)

;;;;;;

;; buff-menu+ for buffer switching
(require 'buff-menu+)

;; buff-menu+ sort by mode
(setq Buffer-menu-sort-column 5)

;; show buffer menu in the current window
(add-to-list 'same-window-buffer-names "*Buffer List*")

;;;;;;

(ido-mode t)
(setq ido-enable-flex-matching t)
(add-to-list 'ido-ignore-buffers "\\*Customize")
(add-to-list 'ido-ignore-buffers "\\*Buffer")
(add-to-list 'ido-ignore-files "TAGS")

;; mini buffer switching
;(iswitchb-mode 1)

;; '|' as the delimiter
;(setq iswitchb-delim " | ")

;; Ignore all non-file buffers excluding those listed in `inc-buffers'
;(defun iswitchb-ignore-non-file (name)
;  (let ((inc-buffers '("*info*" "*scratch*"))
;        (exc-files '("TAGS")))
;    (or (member name exc-files)
;        (and (not (member name inc-buffers))
;             (eq 42 (aref name 0))
;             (eq 42 (aref name (- (length name) 1)))))))
;(setq iswitchb-buffer-ignore '("^ " iswitchb-ignore-non-file))

;; Keep the size of iswitchb minibuffer more manageable.
;(add-hook 'iswitchb-minibuffer-setup-hook
;          '(lambda () (set (make-local-variable 'max-mini-window-height) 3)))

;(defun iswitchb-exclude-nonmatching()
;  "Make iswitchb work on only the currently matching names."
;  (interactive)
;  (setq iswitchb-buflist iswitchb-matches)
;  (setq iswitchb-rescan t)
;  (delete-minibuffer-contents))

;;;;;;

(defun switch-to-previous-buffer ()
  "Switch to previous buffer."
  (interactive)
  (switch-to-buffer (other-buffer (current-buffer) 1)))

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


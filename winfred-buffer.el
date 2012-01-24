;; backups and autosaves
(setq backup-directory-alist `((".*" . "~/.emacs.d/backups")))
(setq auto-save-file-name-transforms `((".*" "~/.emacs.d/autosaves/\\1" t)))
(setq require-final-newline t)

;;;;;;

;; buff-menu+ for buffer switching
(require 'buff-menu+)

;; buff-menu+ sort by mode
(setq Buffer-menu-sort-column 5)

;; show buffer menu in the current window
(add-to-list 'same-window-buffer-names "*Buffer List*")

;;;;;;

;; mini buffer switching
(iswitchb-mode 1)

;; '|' as the delimiter
(setq iswitchb-delim " | ")

;; Ignore all non-file buffers excluding those listed in `exc-files'
(defun iswitchb-ignore-non-file (name)
  (let ((exc-files '("*info*" "*scratch*")))
    (and (not (member name exc-files))
         (eq 42 (aref name 0))
         (eq 42 (aref name (- (length name) 1))))))
(setq iswitchb-buffer-ignore '("^ " iswitchb-ignore-non-file))

;; Keep the size of iswitchb minibuffer more manageable.
(add-hook 'iswitchb-minibuffer-setup-hook
          '(lambda () (set (make-local-variable 'max-mini-window-height) 3)))

(defun iswitchb-exclude-nonmatching()
  "Make iswitchb work on only the currently matching names."
  (interactive)
  (setq iswitchb-buflist iswitchb-matches)
  (setq iswitchb-rescan t)
  (delete-minibuffer-contents))

;;;;;;

(defun switch-to-previous-buffer ()
  "Switch to previous buffer."
  (interactive)
  (switch-to-buffer (other-buffer (current-buffer) 1)))

(defun show-buffer-full-name ()
  "Show the full path file name in the minibuffer."
  (interactive)
  (message (buffer-file-name)))

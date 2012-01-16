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

;; ignore buffers
(add-to-list 'iswitchb-buffer-ignore "^ ")
(add-to-list 'iswitchb-buffer-ignore "*Buffer List*")
(add-to-list 'iswitchb-buffer-ignore "*Completions*")
(add-to-list 'iswitchb-buffer-ignore "*Customize\*")
(add-to-list 'iswitchb-buffer-ignore "*Egg\*")
(add-to-list 'iswitchb-buffer-ignore "*grep*")
(add-to-list 'iswitchb-buffer-ignore "*GTAGS\*")
(add-to-list 'iswitchb-buffer-ignore "*info*")
(add-to-list 'iswitchb-buffer-ignore "*Help*")
(add-to-list 'iswitchb-buffer-ignore "*Messages*")

;; Keep the size of iswitchb minibuffer more manageable.
(add-hook 'iswitchb-minibuffer-setup-hook
	  '(lambda () (set (make-local-variable 'max-mini-window-height) 3)))

;;;;;;

(defun switch-to-previous-buffer ()
  "Switch to previous buffer."
  (interactive)
  (switch-to-buffer (other-buffer (current-buffer) 1)))

(defun show-buffer-full-name ()
  "Show the full path file name in the minibuffer."
  (interactive)
  (message (buffer-file-name)))

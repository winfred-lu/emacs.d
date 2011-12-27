;; buff-menu+ for buffer switching
(require 'buff-menu+)

;; buff-menu+ sort by mode
(setq Buffer-menu-sort-column 5)

;;;;;;

;; mini buffer switching
(iswitchb-mode 1)

;; '|' as the delimiter
(setq iswitchb-delim " | ")

;; ignore buffers
(add-to-list 'iswitchb-buffer-ignore "^ ")
(add-to-list 'iswitchb-buffer-ignore "*Completions*")

;; Keep the size of iswitchb minibuffer more manageable.
(add-hook 'iswitchb-minibuffer-setup-hook
	  '(lambda () (set (make-local-variable 'max-mini-window-height) 3)))

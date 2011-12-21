;;; buffer switching (frame)
(global-set-key (kbd "C-x C-b") 'buffer-menu)

;;; mini buffer switching
(iswitchb-mode 1)
;(setq iswitchb-buffer-ignore '("^ " "*Buffer"))
(setq iswitchb-delim " | ")

;; Keep the size of iswitchb minibuffer more manageable.
(add-hook 'iswitchb-minibuffer-setup-hook
	  '(lambda () (set (make-local-variable 'max-mini-window-height) 3)))

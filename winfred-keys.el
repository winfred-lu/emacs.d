;;;;;; global key bindings (modeless) ;;;;;;

;; F11 to toggle whitespace-mode on/off
(global-set-key [(f11)] 'whitespace-mode)

;; auto indentation after RET
;(global-set-key (kbd "RET") 'newline-and-indent)

;; undo the evil's remapping C-e to evil-scroll-line-down
(define-key evil-insert-state-map "\C-e" 'end-of-line)

;; functions frequently used
(global-set-key "\C-ca" 'org-agenda)
(global-set-key "\C-xg" 'magit-status)

;;;;;; local key bindings (modeless) ;;;;;;

;; key bindings for html-mode
(add-hook 'html-mode-hook
	  (lambda ()
	    (local-set-key (kbd "C-c o") 'browse-url-at-point)))

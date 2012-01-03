;;;; global key bindings ;;;;

;; F11 to toggle whitespace-mode on/off
(global-set-key [(f11)] 'whitespace-mode)

;; auto indentation after RET
;(global-set-key (kbd "RET") 'newline-and-indent)

;; functions frequently used
(global-set-key "\C-ca" 'org-agenda)
(global-set-key "\C-xg" 'magit-status)

;;;; local key bindings ;;;;

;; key bindings for html-mode
(add-hook 'html-mode-hook
	  (lambda ()
	  (local-set-key (kbd "C-c o") 'browse-url-at-point)))

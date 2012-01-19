;;;;;; global key bindings (modeless) ;;;;;;

;; F11 to toggle whitespace-mode on/off
(global-set-key [(f11)] 'whitespace-mode)

;; auto indentation after RET
;(global-set-key (kbd "RET") 'newline-and-indent)

;; undo evil's key bindings
(define-key evil-insert-state-map "\C-e" 'end-of-line)
(define-key evil-normal-state-map "\C-e" 'end-of-line)
(define-key evil-normal-state-map "\M-." 'find-tag)

;; functions frequently used
(global-set-key "\C-ca" 'org-agenda)
(global-set-key "\C-xg" 'egg-status)

;;;;;; local key bindings (modeful) ;;;;;;

;; key bindings for html-mode
(add-hook 'html-mode-hook
	  '(lambda ()
	     (local-set-key (kbd "C-c o") 'browse-url-at-point)))

(add-hook 'iswitchb-define-mode-map-hook
	  '(lambda ()
	     (define-key iswitchb-mode-map "\C-o" 'iswitchb-exclude-nonmatching)
	     (define-key iswitchb-mode-map "\M-h" 'iswitchb-prev-match)
	     (define-key iswitchb-mode-map "\M-j" 'iswitchb-next-match)
	     (define-key iswitchb-mode-map "\M-k" 'iswitchb-prev-match)
	     (define-key iswitchb-mode-map "\M-l" 'iswitchb-next-match)
	     (define-key iswitchb-mode-map ",bf" 'iswitchb-find-file)))
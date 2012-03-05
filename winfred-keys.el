;;;;;; global key bindings (modeless) ;;;;;;

;; F11 to toggle whitespace-mode on/off
(global-set-key [(f11)] 'whitespace-mode)

;; auto indentation after RET
;(global-set-key (kbd "RET") 'newline-and-indent)

;; undo evil's key bindings
(define-key evil-insert-state-map "\C-e" 'end-of-line)
(define-key evil-normal-state-map "\C-e" 'end-of-line)

;; yank at motion state
(define-key evil-motion-state-map "y" 'evil-yank)

;; functions frequently used
(global-set-key "\C-ca" 'org-agenda)
(global-set-key "\C-xg" 'magit-status)

;;;;;; local key bindings (modeful) ;;;;;;

(add-hook 'html-mode-hook
          '(lambda ()
             (local-set-key (kbd "C-c o") 'browse-url-at-point)))

(add-hook 'ido-setup-hook
          '(lambda ()
             (define-key ido-completion-map "\M-h" 'ido-prev-match)
             (define-key ido-completion-map "\M-l" 'ido-next-match)
             (define-key ido-completion-map "\C-n" 'ido-toggle-ignore)))


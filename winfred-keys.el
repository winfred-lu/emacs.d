;;;;;; global key bindings (modeless) ;;;;;;

;; F11 to toggle whitespace-mode on/off
(global-set-key [(f11)] 'whitespace-mode)

;; auto indentation after RET
;(global-set-key (kbd "RET") 'newline-and-indent)

;; undo evil's key bindings
(define-key evil-insert-state-map "\C-e" 'end-of-line)
(define-key evil-normal-state-map "\C-e" 'end-of-line)
(define-key evil-insert-state-map "\C-y" 'yank)

;; yank at motion state
(define-key evil-motion-state-map "y" 'evil-yank)

;; functions frequently used
(global-set-key "\C-ca" 'org-agenda)
(global-set-key "\C-xg" 'magit-status)

;;;;;; local key bindings (modeful) ;;;;;;

(add-hook 'cscope-list-entry-hook
          '(lambda ()
             (define-key cscope-list-entry-keymap "j" 'evil-next-visual-line)
             (define-key cscope-list-entry-keymap "k" 'evil-previous-visual-line)
             (define-key cscope-list-entry-keymap "q" 'delete-window)
             (define-key cscope-list-entry-keymap "\C-f" 'evil-scroll-page-down)
             (define-key cscope-list-entry-keymap "\C-b" 'evil-scroll-page-up)
             (define-key cscope-list-entry-keymap (kbd "RET") 'cscope-select-entry-other-window)
             (define-key cscope-list-entry-keymap "," 'wf-evil-comma-map)))

(add-hook 'html-mode-hook
          '(lambda ()
             (local-set-key (kbd "C-c o") 'browse-url-at-point)))

(add-hook 'ido-setup-hook
          '(lambda ()
             (define-key ido-completion-map "\M-h" 'ido-prev-match)
             (define-key ido-completion-map "\M-l" 'ido-next-match)
             (define-key ido-completion-map "\C-n" 'ido-toggle-ignore)))


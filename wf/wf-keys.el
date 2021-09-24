(global-set-key [(f7)] 'recompile)
(global-set-key [(f9)] 'set-mark-command)
(global-set-key [(f11)] 'whitespace-mode)
(global-set-key [(f12)] (lambda()(interactive)(switch-to-buffer "*scratch*")))

(define-prefix-command 'wf-minor-mode-map)
(define-key wf-minor-mode-map "a" 'artist-mode)
(define-key wf-minor-mode-map "h" 'hl-line-mode)
(define-key wf-minor-mode-map "s" 'flyspell-mode)
(define-key wf-minor-mode-map "v" 'visual-line-mode)
(define-key wf-minor-mode-map "w" 'whitespace-mode)

;; functions frequently used
(global-set-key "\C-ca" 'org-agenda)
(global-set-key "\C-xg" 'magit-status)
(global-set-key "\C-xk" 'browse-kill-ring)
(global-set-key "\C-xm" 'wf-minor-mode-map)
(global-set-key "\C-c\C-o" 'browse-url-at-point)
(global-set-key "\C-x\C-b" 'ibuffer)
(global-set-key "\C-x\C-r" 'wf-sudo-find-file)

(add-hook 'cscope-list-entry-hook
          '(lambda ()
             (evil-emacs-state)
             (define-key cscope-list-entry-keymap "j" 'evil-next-visual-line)
             (define-key cscope-list-entry-keymap "k" 'evil-previous-visual-line)
             (define-key cscope-list-entry-keymap "q" 'delete-window)
             (define-key cscope-list-entry-keymap "\C-f" 'evil-scroll-page-down)
             (define-key cscope-list-entry-keymap "\C-b" 'evil-scroll-page-up)
             (define-key cscope-list-entry-keymap (kbd "RET") 'cscope-select-entry-other-window)
             (define-key cscope-list-entry-keymap "," 'wf-evil-comma-map)))

(add-hook 'ido-setup-hook
          '(lambda ()
             (define-key ido-completion-map "\M-h" 'ido-prev-match)
             (define-key ido-completion-map "\M-l" 'ido-next-match)
             (define-key ido-completion-map "\C-n" 'ido-toggle-ignore)))

(add-hook 'org-mode-hook
          '(lambda ()
             (define-key org-mode-map "\C-cl" 'org-store-link)))

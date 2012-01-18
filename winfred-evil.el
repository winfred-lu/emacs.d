;; Evil
(require 'evil)
(evil-mode 1)

(evil-set-initial-state 'Custom-mode 'normal)
(evil-set-initial-state 'gtags-select-mode 'emacs)
(evil-set-initial-state 'grep-mode 'emacs)

;; jj as escape to return to normal mode
(define-key evil-insert-state-map "j" #'cofi/maybe-exit)
(evil-define-command cofi/maybe-exit ()
  :repeat change
  (interactive)
  (let ((modified (buffer-modified-p)))
    (insert "j")
    (let ((evt (read-event (format "Insert %c to exit insert state" ?j)
	       nil 0.5)))
      (cond
       ((null evt) (message ""))
       ((and (integerp evt) (char-equal evt ?j))
    (delete-char -1)
    (set-buffer-modified-p modified)
    (push 'escape unread-command-events))
       (t (setq unread-command-events (append unread-command-events
			  (list evt))))))))

;;;;;; global key bindings (modeful) ;;;;;;

;; moving with visual line (like gj,gk in vim)
(define-key evil-normal-state-map "j" 'evil-next-visual-line)
(define-key evil-normal-state-map "k" 'evil-previous-visual-line)
(define-key evil-visual-state-map "j" 'evil-next-visual-line)
(define-key evil-visual-state-map "k" 'evil-previous-visual-line)

;; buffer switching related bindings
(define-key evil-normal-state-map ",bb" 'switch-to-previous-buffer)
(define-key evil-normal-state-map ",bl" 'list-buffers)
(define-key evil-normal-state-map ",bs" 'iswitchb-buffer)
(define-key evil-normal-state-map ",bf" 'ido-find-file)
(define-key evil-normal-state-map ",bn" 'show-buffer-full-name)

;; buffer switching at evil motion mode
(define-prefix-command 'wf-evil-comma-map)
(define-key wf-evil-comma-map "," 'evil-repeat-find-char-reverse)
(define-key wf-evil-comma-map "bb" 'switch-to-previous-buffer)
(define-key wf-evil-comma-map "bl" 'list-buffers)
(define-key wf-evil-comma-map "bs" 'iswitchb-buffer)
(define-key wf-evil-comma-map "bf" 'ido-find-file)
(define-key wf-evil-comma-map "bn" 'show-buffer-full-name)
(define-key evil-motion-state-map "," 'wf-evil-comma-map)

;;;;;; local key bindings (modeful) ;;;;;;

;; key bindings for cc-mode
(eval-after-load 'cc-mode
  '(progn
     (evil-define-key 'insert c-mode-map (kbd "RET") 'newline-and-indent)))

;; key bindings for custom-mode
(eval-after-load "cus-edit"
  '(progn
     (evil-define-key 'normal custom-mode-map (kbd "TAB") 'widget-forward)
     (evil-define-key 'normal custom-mode-map "q" 'Custom-buffer-done)))

;; key bindings for egg-mode
(eval-after-load "egg"
  '(progn
     (evil-define-key 'normal egg-status-buffer-mode-map "q" 'egg-quit-buffer)
     (evil-define-key 'normal egg-status-buffer-mode-map "c" 'egg-commit-log-edit)))

(eval-after-load "lisp"
  '(progn
     (evil-define-key 'insert emacs-lisp-mode-map (kbd "RET") 'newline-and-indent)))

;; key bindings for gtags (FIXME)
(eval-after-load "gtags"
  '(progn
     (evil-define-key 'normal gtags-mode-map "\C-]" 'gtags-find-tag-from-here)
     (evil-define-key 'normal gtags-mode-map "\C-t" 'gtags-pop-stack)
     (evil-define-key 'normal gtags-mode-map ",gl" 'gtags-find-file)
     (evil-define-key 'normal gtags-mode-map ",gg" 'gtags-find-with-grep)
     (evil-define-key 'normal gtags-mode-map ",gI" 'gtags-find-with-idutils)
     (evil-define-key 'normal gtags-mode-map ",gs" 'gtags-find-symbol)
     (evil-define-key 'normal gtags-mode-map ",gr" 'gtags-find-rtag)
     (evil-define-key 'normal gtags-mode-map ",gt" 'gtags-find-tag)
     (evil-define-key 'normal gtags-mode-map ",gv" 'gtags-visit-rootdir)))

;; key bindings for Help-mode
(eval-after-load 'help-mode
  '(progn
     (evil-define-key 'motion help-mode-map (kbd "TAB") 'forward-button)))

;; key bindings for Info-mode
(eval-after-load "Info"
  '(progn
     (evil-define-key 'motion Info-mode-map (kbd "TAB") 'Info-next-reference)))

;; key bindings for org-mode
(eval-after-load "org"
  '(progn
    (evil-define-key 'normal org-mode-map "$" 'org-end-of-line)
    (evil-define-key 'normal org-mode-map "\C-cl" 'org-store-link)
    (evil-define-key 'normal org-mode-map "\C-ca" 'org-agenda)
    (evil-define-key 'normal org-mode-map "T" 'org-todo)
    (evil-define-key 'normal org-mode-map "-" 'org-cycle-list-bullet)
    (evil-define-key 'normal org-mode-map (kbd "TAB") 'org-cycle)
    (evil-define-key 'normal org-mode-map "\M-l" 'org-metaright)
    (evil-define-key 'normal org-mode-map "\M-h" 'org-metaleft)
    (evil-define-key 'normal org-mode-map "\M-k" 'org-metaup)
    (evil-define-key 'normal org-mode-map "\M-j" 'org-metadown)
    (evil-define-key 'normal org-mode-map "\M-L" 'org-shiftmetaright)
    (evil-define-key 'normal org-mode-map "\M-H" 'org-shiftmetaleft)
    (evil-define-key 'normal org-mode-map "\M-K" 'org-shiftmetaup)
    (evil-define-key 'normal org-mode-map "\M-J" 'org-shiftmetadown)
    (evil-define-key 'insert org-mode-map "\M-l" 'org-metaright)
    (evil-define-key 'insert org-mode-map "\M-h" 'org-metaleft)
    (evil-define-key 'insert org-mode-map "\M-k" 'org-metaup)
    (evil-define-key 'insert org-mode-map "\M-j" 'org-metadown)
    (evil-define-key 'normal org-mode-map "o"
      (lambda () (interactive)
	(org-end-of-line)
	(evil-open-below 0)))
    (evil-define-key 'normal org-mode-map "O"
      (lambda () (interactive)
	(org-end-of-line)
	(org-insert-heading)
	(evil-append nil)))))
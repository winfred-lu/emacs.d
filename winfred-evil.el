;; Evil
(require 'evil)
(evil-mode 1)

;; imap jj to ESC
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

;; switch to previous buffer (able to switch in-between)
(defun switch-to-previous-buffer ()
  (interactive)
  (switch-to-buffer (other-buffer (current-buffer) 1)))
(define-key evil-normal-state-map ",bb" 'switch-to-previous-buffer)
(define-key evil-normal-state-map ",be" 'list-buffers)

;;;;;; local key bindings (modeful) ;;;;;;

;; key bindings for cc-mode
(eval-after-load 'cc-mode
  '(progn
    (evil-define-key 'normal c-mode-map "[[" 'c-beginning-of-defun)
    (evil-define-key 'normal c-mode-map "][" 'c-end-of-defun)))

;; key bindings for org-mode
(eval-after-load "org"
  '(progn
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
    (evil-define-key 'normal org-mode-map "O"
      (lambda () (interactive)
	(end-of-line)
	(org-insert-heading)
	(evil-append nil)))))

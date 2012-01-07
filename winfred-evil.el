;; Evil
(require 'evil)
(evil-mode 1)

(evil-set-initial-state 'Custom-mode 'normal)

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

;; function switch to previous buffer, buffer switching related bindings
(defun switch-to-previous-buffer ()
  (interactive)
  (switch-to-buffer (other-buffer (current-buffer) 1)))
(define-key evil-normal-state-map ",bb" 'switch-to-previous-buffer)
(define-key evil-normal-state-map ",bl" 'list-buffers)
(define-key evil-normal-state-map ",bs" 'iswitchb-buffer)
(define-key evil-normal-state-map ",bf" 'ido-find-file)

;;;;;; local key bindings (modeful) ;;;;;;

;; key bindings for cc-mode
(eval-after-load 'cc-mode
  '(progn
     (evil-define-key 'normal c-mode-map "[[" 'c-beginning-of-defun)
     (evil-define-key 'normal c-mode-map "][" 'c-end-of-defun)))

;; key bindings for custom-mode
(eval-after-load "cus-edit"
  '(progn
     (evil-define-key 'normal custom-mode-map (kbd "TAB") 'widget-forward)))

;; key bindings for egg-mode
(eval-after-load "egg"
  '(progn
     (evil-define-key 'normal egg-status-buffer-mode-map "q" 'egg-quit-buffer)
     (evil-define-key 'normal egg-status-buffer-mode-map "c" 'egg-commit-log-edit)))

;; key bindings for Info-mode
(eval-after-load "Info"
  '(progn
     (evil-define-key 'motion Info-mode-map (kbd "TAB") 'Info-next-reference)))

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
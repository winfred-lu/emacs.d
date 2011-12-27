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

;; viper
;(setq viper-mode t)
;(require 'viper)

;; imap jj to ESC
;(defun viper-escape-if-next-char (c)
;  (self-insert-command 1)
;    (let ((next-key (read-event)))
;      (if (= c next-key)
;        (progn
;          (delete-backward-char 1)
;            (viper-mode))
;            (setq unread-command-events (list next-key)))))
;(defun viper-escape-if-next-char-is-j (arg)
;  (interactive "p")
;    (if (= arg 1)
;      (viper-escape-if-next-char ?j)
;        (self-insert-command arg)))
;(define-key viper-insert-basic-map (kbd "j") 'viper-escape-if-next-char-is-j)


;; key bindings for cc-mode
(define-key evil-normal-state-map "[[" 'c-beginning-of-defun)
(define-key evil-normal-state-map "][" 'c-end-of-defun)

;; key bindings of org file for evil normal mode
(define-key evil-normal-state-map "O" (lambda () (interactive)
		     (end-of-line)
		     (org-insert-heading)
		     (evil-append nil)
		     ))
(define-key evil-normal-state-map "T" 'org-todo)
(define-key evil-normal-state-map "-" 'org-cycle-list-bullet)
(define-key evil-normal-state-map (kbd "TAB") 'org-cycle)
(define-key evil-normal-state-map (kbd "M-l") 'org-metaright)
(define-key evil-normal-state-map (kbd "M-h") 'org-metaleft)
(define-key evil-normal-state-map (kbd "M-k") 'org-metaup)
(define-key evil-normal-state-map (kbd "M-j") 'org-metadown)
(define-key evil-normal-state-map (kbd "M-L") 'org-shiftmetaright)
(define-key evil-normal-state-map (kbd "M-H") 'org-shiftmetaleft)
(define-key evil-normal-state-map (kbd "M-K") 'org-shiftmetaup)
(define-key evil-normal-state-map (kbd "M-J") 'org-shiftmetadown)

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


;; normal mode key bindings for cc-mode
(eval-after-load 'cc-mode
  '(list
    (evil-define-key 'normal c-mode-map "[[" 'c-beginning-of-defun)
    (evil-define-key 'normal c-mode-map "][" 'c-end-of-defun)
    (message "hello!!")
    ))

;; normal mode key bindings for org-mode
(eval-after-load "org"
  '(list
    (evil-define-key 'normal org-mode-map "\C-cl" 'org-store-link)
    (evil-define-key 'normal org-mode-map "\C-ca" 'org-agenda)
    (evil-define-key 'normal org-mode-map "T" 'org-todo)
    (evil-define-key 'normal org-mode-map "-" 'org-cycle-list-bullet)
    (evil-define-key 'normal org-mode-map (kbd "TAB") 'org-cycle)
    (evil-define-key 'normal org-mode-map "\M-l" 'org-metaright)
    (evil-define-key 'normal org-mode-map "\M-l" 'org-metaright)
    (evil-define-key 'normal org-mode-map "\M-h" 'org-metaleft)
    (evil-define-key 'normal org-mode-map "\M-k" 'org-metaup)
    (evil-define-key 'normal org-mode-map "\M-j" 'org-metadown)
    (evil-define-key 'normal org-mode-map "\M-L" 'org-shiftmetaright)
    (evil-define-key 'normal org-mode-map "\M-H" 'org-shiftmetaleft)
    (evil-define-key 'normal org-mode-map "\M-K" 'org-shiftmetaup)
    (evil-define-key 'normal org-mode-map "\M-J" 'org-shiftmetadown)
    (evil-define-key 'normal org-mode-map "O"
      (lambda () (interactive)
	(end-of-line)
	(org-insert-heading)
	(evil-append nil)))
    ))

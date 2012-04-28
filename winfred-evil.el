(setq evil-move-cursor-back nil
      evil-cross-lines t)
(require 'evil)

(setq evil-normal-state-tag   (propertize "n" 'face '((:foreground "green")))
      evil-emacs-state-tag    (propertize "e" 'face '((:foreground "orange")))
      evil-insert-state-tag   (propertize "i" 'face '((:foreground "purple")))
      evil-motion-state-tag   (propertize "m" 'face '((:foreground "blue")))
      evil-operator-state-tag (propertize "o" 'face '((:foreground "yellow"))))
(evil-mode 1)

(loop for (mode . state) in '((calendar-mode . emacs)
                              (Custom-mode . normal)
                              (grep-mode . emacs)
                              (hexl-mode . emacs)
                              (Man-mode . emacs)
                              (cscope-list-entry-mode . emacs))
      do (evil-set-initial-state mode state))

;; kj as escape to return to normal mode
(define-key evil-insert-state-map "k" #'cofi/maybe-exit)
(evil-define-command cofi/maybe-exit ()
  :repeat change
  (interactive)
  (let ((modified (buffer-modified-p)))
    (insert "k")
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

(defun wf-define-evil-movements (map)
  (evil-define-key 'emacs map
    "," 'wf-evil-comma-map
    "j" 'evil-next-visual-line
    "k" 'evil-previous-visual-line
    "\C-f" 'evil-scroll-page-down
    "\C-b" 'evil-scroll-page-up))

;;;;;; global key bindings (modeless) ;;;;;;

;; moving with visual line (like gj,gk in vim)
(define-key evil-normal-state-map "j" 'evil-next-visual-line)
(define-key evil-normal-state-map "k" 'evil-previous-visual-line)
(define-key evil-visual-state-map "j" 'evil-next-visual-line)
(define-key evil-visual-state-map "k" 'evil-previous-visual-line)

(require 'ace-jump-mode)
(define-key evil-normal-state-map " " 'ace-jump-mode)
(define-key evil-operator-state-map " " 'ace-jump-char-mode)
;; make ace jump look like a single command to evil
(defadvice ace-jump-char-mode (after evil activate) (recursive-edit))
(defadvice ace-jump-done (after evil activate) (exit-recursive-edit))

(define-prefix-command 'wf-evil-comma-map)
(define-key wf-evil-comma-map "," 'evil-repeat-find-char-reverse)
(define-key wf-evil-comma-map "v" 'evil-buffer)
(define-key wf-evil-comma-map "h" 'list-buffers)
(define-key wf-evil-comma-map "b" 'ido-switch-buffer)
(define-key wf-evil-comma-map "f" 'ido-find-file)
(define-key wf-evil-comma-map "n" 'show-buffer-full-name)
(define-key wf-evil-comma-map "d" 'dired-jump)
(define-key wf-evil-comma-map "g" 'magit-status)
(define-key wf-evil-comma-map "k" 'kill-buffer-and-window)
(define-key wf-evil-comma-map "w" 'ace-jump-word-mode)
(define-key wf-evil-comma-map "c" 'ace-jump-char-mode)
(define-key wf-evil-comma-map "l" 'ace-jump-line-mode)
(define-key evil-normal-state-map "," 'wf-evil-comma-map)
(define-key evil-motion-state-map "," 'wf-evil-comma-map)

;; hide, unhide region at evil visual mode
(require 'hide-region)
(define-key evil-visual-state-map "zc"
  (lambda () (interactive) (hide-region-hide) (evil-normal-state)))
(define-key evil-visual-state-map "zo"
  (lambda () (interactive) (hide-region-unhide) (evil-normal-state)))

;; cscope key bindings at evil normal mode
(define-prefix-command 'wf-cscope-map)
(define-key wf-cscope-map "s" 'cscope-find-this-symbol)
(define-key wf-cscope-map "g" 'cscope-find-global-definition)
(define-key wf-cscope-map "c" 'cscope-find-functions-calling-this-function)
(define-key wf-cscope-map "d" 'cscope-find-called-functions)
(define-key wf-cscope-map "t" 'cscope-find-this-text-string)
(define-key wf-cscope-map "e" 'cscope-find-egrep-pattern)
(define-key wf-cscope-map "f" 'cscope-find-this-file)
(define-key wf-cscope-map "i" 'cscope-find-files-including-file)
(define-key wf-cscope-map "n" 'cscope-next-symbol)
(define-key wf-cscope-map "p" 'cscope-prev-symbol)
(define-key wf-cscope-map "u" 'cscope-pop-mark)
(define-key evil-normal-state-map "\C-_" 'wf-cscope-map)

;; etags-select
(define-key evil-normal-state-map "\C-]" 'etags-select-find-tag-at-point)
(define-key evil-normal-state-map "\M-." 'etags-select-find-tag)


;;;;;; local key bindings (modeful) ;;;;;;

(eval-after-load "calc"
  '(progn
     (evil-define-key 'emacs calc-mode-map "\C-w" 'evil-window-map)))

(eval-after-load "calendar"
  '(progn
     (evil-define-key 'emacs calendar-mode-map
       "j" 'calendar-forward-week
       "k" 'calendar-backward-week
       "h" 'calendar-backward-day
       "l" 'calendar-forward-day
       "K" 'org-agenda-action)))

;; key bindings for custom-mode
(eval-after-load "cus-edit"
  '(progn
     (evil-define-key 'normal custom-mode-map (kbd "TAB") 'widget-forward)
     (evil-define-key 'normal custom-mode-map "q" 'Custom-buffer-done)))

(eval-after-load "etags-select"
  '(progn
     (wf-define-evil-movements etags-select-mode-map)
     (evil-define-key 'emacs etags-select-mode-map (kbd "RET") 'etags-select-goto-tag)))

(eval-after-load "lisp"
  '(progn
     (evil-define-key 'insert emacs-lisp-mode-map (kbd "RET") 'evil-ret)))

(eval-after-load "gnus"
  '(progn
     (evil-define-key 'emacs gnus-group-mode-map "," 'wf-evil-comma-map)
     (evil-define-key 'emacs gnus-summary-mode-map "," 'wf-evil-comma-map)
     (evil-define-key 'emacs gnus-article-mode-map "," 'wf-evil-comma-map)))

(eval-after-load "grep"
  '(progn
     (wf-define-evil-movements grep-mode-map)))

;; key bindings for Help-mode
(eval-after-load 'help-mode
  '(progn
     (evil-define-key 'motion help-mode-map (kbd "TAB") 'forward-button)))

(eval-after-load "magit"
  '(progn
     (wf-define-evil-movements magit-status-mode-map)
     (wf-define-evil-movements magit-commit-mode-map)
     (wf-define-evil-movements magit-log-mode-map)
     (evil-define-key 'emacs magit-status-mode-map "K" 'magit-discard-item)))

(eval-after-load "Man"
  '(progn
     (wf-define-evil-movements Man-mode-map)
     (evil-define-key 'emacs Man-mode-map "K" 'Man-kill)))

;; key bindings for org-mode
(eval-after-load "org"
  '(progn
     (evil-define-key 'normal org-mode-map
       "$" 'org-end-of-line
       "\C-cl" 'org-store-link
       "\C-ca" 'org-agenda
       "T" 'org-todo
       "-" 'org-cycle-list-bullet
       (kbd "TAB") 'org-cycle
       "\M-l" 'org-metaright
       "\M-h" 'org-metaleft
       "\M-k" 'org-metaup
       "\M-j" 'org-metadown
       "\M-L" 'org-shiftmetaright
       "\M-H" 'org-shiftmetaleft
       "\M-K" 'org-shiftmetaup
       "\M-J" 'org-shiftmetadown
       "o" (lambda () (interactive) (org-end-of-line) (evil-open-below 0))
       "O" (lambda () (interactive) (org-end-of-line) (org-insert-heading)
             (evil-append nil)))
     (evil-define-key 'insert org-mode-map
       "\M-l" 'org-metaright
       "\M-h" 'org-metaleft
       "\M-k" 'org-metaup
       "\M-j" 'org-metadown)))


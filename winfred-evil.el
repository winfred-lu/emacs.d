(setq evil-cross-lines t)
(add-to-list 'load-path (concat user-emacs-directory
                                "vendor/evil/lib"))
(require 'evil)
(require 'evil-nerd-commenter)

(setq evil-normal-state-tag   (propertize "n" 'face '((:foreground "green")))
      evil-emacs-state-tag    (propertize "e" 'face '((:foreground "orange")))
      evil-insert-state-tag   (propertize "i" 'face '((:foreground "purple")))
      evil-motion-state-tag   (propertize "m" 'face '((:foreground "blue")))
      evil-visual-state-tag   (propertize "v" 'face '((:foreground "yellow")))
      evil-operator-state-tag (propertize "o" 'face '((:foreground "red")))
      evil-replace-state-tag  (propertize "r" 'face '((:foreground "red"))))
(evil-mode 1)

(dolist (x '((calendar-mode . emacs)
             (cscope-list-entry-mode . emacs)
             (Custom-mode . normal)
             (grep-mode . emacs)
             (hexl-mode . emacs)
             (picture-mode . emacs)))
  (evil-set-initial-state (car x) (cdr x)))

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

(defmacro wf-define-evil-movements (keymap &rest bindings)
  (declare (indent defun))
  `(evil-define-key 'emacs ,keymap
     "j"    (lookup-key evil-motion-state-map "j")
     "k"    (lookup-key evil-motion-state-map "k")
     "\C-f" (lookup-key evil-motion-state-map "\C-f")
     "\C-b" (lookup-key evil-motion-state-map "\C-b")
     ","    'wf-evil-comma-map
     ,@bindings))

;;;;;; key bindings regardless of major mode ;;;;;;

;; undo evil's key bindings
(define-key evil-insert-state-map "\C-e" 'end-of-line)
(define-key evil-normal-state-map "\C-e" 'end-of-line)
(define-key evil-insert-state-map "\C-y" 'yank)
(define-key evil-motion-state-map "y" 'evil-yank)

;; moving with visual line
(define-key evil-normal-state-map "j" 'evil-next-visual-line)
(define-key evil-normal-state-map "k" 'evil-previous-visual-line)
(define-key evil-normal-state-map "gj" 'evil-next-line)
(define-key evil-normal-state-map "gk" 'evil-previous-line)

(require 'ace-jump-mode)
(define-key evil-normal-state-map " " 'ace-jump-mode)
(define-key evil-operator-state-map " " 'ace-jump-char-mode)
;; make ace jump look like a single command to evil
(defadvice ace-jump-char-mode (after evil activate) (recursive-edit))
(defadvice ace-jump-done (after evil activate) (exit-recursive-edit))

(define-prefix-command 'wf-evil-comma-map)
(define-key wf-evil-comma-map "," 'evil-repeat-find-char-reverse)
(define-key wf-evil-comma-map "b" 'ido-switch-buffer)
(define-key wf-evil-comma-map "ci" 'evilnc-comment-or-uncomment-lines)
(define-key wf-evil-comma-map "cc" 'evilnc-comment-or-uncomment-to-the-line)
(define-key wf-evil-comma-map "cl" 'calc)
(define-key wf-evil-comma-map "d" 'dired-jump)
(define-key wf-evil-comma-map "e" 'wf-sudo-find-file)
(define-key wf-evil-comma-map "f" 'ido-find-file)
(define-key wf-evil-comma-map "g" 'magit-status)
(define-key wf-evil-comma-map "h" 'ibuffer)
(define-key wf-evil-comma-map "k" 'kill-buffer)
(define-key wf-evil-comma-map "l" 'ace-jump-line-mode)
(define-key wf-evil-comma-map "m" 'idomenu)
(define-key wf-evil-comma-map "n" 'evil-show-file-info)
(define-key wf-evil-comma-map "p" 'pdb)
(define-key wf-evil-comma-map "q" 'kill-buffer-and-window)
(define-key wf-evil-comma-map "r" 'browse-kill-ring)
(define-key wf-evil-comma-map "s" 'ispell-word)
(define-key wf-evil-comma-map "t" 'visit-tags-table)
(define-key wf-evil-comma-map "v" 'evil-buffer)
(define-key wf-evil-comma-map "w" 'ace-jump-word-mode)
(define-key wf-evil-comma-map "y" 'python-shell)
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

;; etags-select instead of evil-jump-to-tag
(define-key evil-normal-state-map "\C-]" 'etags-select-find-tag-at-point)
(define-key evil-normal-state-map "\M-." 'etags-select-find-tag)


;;;;;; key bindings according to major mode ;;;;;;

(add-hook 'bookmark-bmenu-mode-hook
          '(lambda ()
             (wf-define-evil-movements bookmark-bmenu-mode-map
               "J" 'bookmark-bmenu-this-window
               "K" 'bookmark-bmenu-delete)))

(eval-after-load "browse-kill-ring"
  '(progn
     (evil-define-key 'emacs browse-kill-ring-mode-map
       "j" 'browse-kill-ring-forward
       "k" 'browse-kill-ring-previous
       "\C-f" (lookup-key evil-motion-state-map "\C-f")
       "\C-b" (lookup-key evil-motion-state-map "\C-b")
       "," 'wf-evil-comma-map)))

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
       "K" 'org-agenda-action
       "\C-f" 'calendar-scroll-left-three-months
       "\C-b" 'calendar-scroll-right-three-months
       "\C-w" 'evil-window-map
       "," 'wf-evil-comma-map)))

(eval-after-load "cus-edit"
  '(progn
     (evil-make-overriding-map custom-mode-map 'normal t)))

(eval-after-load "dired"
  '(progn
     (evil-define-key 'normal dired-mode-map (kbd "^")
       (lambda () (interactive) (find-alternate-file "..")))
     (evil-define-key 'normal dired-mode-map (kbd "RET")
       `dired-find-file)))

(eval-after-load "etags-select"
  '(progn
     (wf-define-evil-movements etags-select-mode-map
                               (kbd "RET") 'etags-select-goto-tag)))

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

(eval-after-load 'help-mode
  '(progn
     (evil-define-key 'motion help-mode-map (kbd "TAB") 'forward-button)))

(eval-after-load "ibuffer"
  '(progn (wf-define-evil-movements ibuffer-mode-map
                                    "J" 'ibuffer-jump-to-buffer
                                    "K" 'ibuffer-do-kill-lines
                                    "<" 'ibuffer-toggle-sorting-mode)))

(eval-after-load 'info
  '(progn
     (evil-define-key 'motion Info-mode-map "," 'wf-evil-comma-map)))

(eval-after-load "magit"
  '(progn
     (wf-define-evil-movements magit-status-mode-map
                               "K" 'magit-discard-item)
     (wf-define-evil-movements magit-commit-mode-map)
     (wf-define-evil-movements magit-log-mode-map)))

(eval-after-load "Man"
  '(progn
     (evil-make-overriding-map Man-mode-map 'normal t)
     (evil-define-key 'normal Man-mode-map
       "k" (lookup-key evil-motion-state-map "k"))))

;; key bindings for org-mode
(eval-after-load "org"
  '(progn
     (evil-define-key 'normal org-mode-map
       "$" 'org-end-of-line
       "T" 'org-todo
       "-" 'org-cycle-list-bullet
       (kbd "TAB") 'org-cycle
       (kbd "RET") 'org-open-at-point
       "\C-t" 'org-mark-ring-goto
       "zm" 'hide-body
       "zr" 'show-all
       "zo" 'show-subtree
       "zO" 'show-all
       "zc" 'hide-subtree
       "zC" 'hide-all
       "\M-l" 'org-metaright
       "\M-h" 'org-metaleft
       "\M-k" 'org-metaup
       "\M-j" 'org-metadown
       "\M-L" 'org-shiftmetaright
       "\M-H" 'org-shiftmetaleft
       "\M-K" 'org-shiftmetaup
       "\M-J" 'org-shiftmetadown
       "\C-c\C-o" 'org-open-at-point
       "o" (lambda () (interactive) (org-end-of-line) (evil-open-below 0))
       "O" (lambda () (interactive) (org-end-of-line) (org-insert-heading)
             (evil-append nil)))
     (evil-define-key 'insert org-mode-map
       "\M-l" 'org-metaright
       "\M-h" 'org-metaleft
       "\M-k" 'org-metaup
       "\M-j" 'org-metadown)))

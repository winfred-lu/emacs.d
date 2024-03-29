(use-package evil
  :ensure t
  :demand t

  :init
  ;; colorful evil state character in mode line
  (setq evil-normal-state-tag   (propertize "n" 'face '((:foreground "green")))
        evil-emacs-state-tag    (propertize "e" 'face '((:foreground "orange")))
        evil-insert-state-tag   (propertize "i" 'face '((:foreground "purple")))
        evil-motion-state-tag   (propertize "m" 'face '((:foreground "blue")))
        evil-visual-state-tag   (propertize "v" 'face '((:foreground "yellow")))
        evil-operator-state-tag (propertize "o" 'face '((:foreground "red")))
        evil-replace-state-tag  (propertize "r" 'face '((:foreground "red"))))

  :custom
  (evil-cross-lines t "horizontal motion may move to other lines")

  :config
  (evil-mode 1)

  ;; Set evil initial sate for major modes
  (dolist (x '((calendar-mode . emacs)
               (compilation-mode . emacs)
               (cscope-list-entry-mode . emacs)
               (Custom-mode . normal)
               (grep-mode . emacs)
               (hexl-mode . emacs)
               (picture-mode . emacs)))
    (evil-set-initial-state (car x) (cdr x)))

  ;; evil-ret-and-indent all the time
  (define-key evil-insert-state-map [remap evil-ret] 'evil-ret-and-indent)

  (define-key evil-insert-state-map "\C-a" 'move-beginning-of-line)
  (define-key evil-insert-state-map "\C-e" 'move-end-of-line)

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

  ;; undo evil's key bindings
  (define-key evil-insert-state-map "\C-y" 'yank)
  (define-key evil-motion-state-map "y" 'evil-yank)

  ;; moving with visual line
  (define-key evil-normal-state-map "j" 'evil-next-visual-line)
  (define-key evil-normal-state-map "k" 'evil-previous-visual-line)
  (define-key evil-normal-state-map "gj" 'evil-next-line)
  (define-key evil-normal-state-map "gk" 'evil-previous-line)

  (define-prefix-command 'wf-evil-comma-map)
  (define-key wf-evil-comma-map "," 'evil-repeat-find-char-reverse)
  (define-key wf-evil-comma-map "b" 'ido-switch-buffer)
  (define-key wf-evil-comma-map "ca" 'calc)
  (define-key wf-evil-comma-map "cd" 'calendar)
  (define-key wf-evil-comma-map "ci" 'evilnc-comment-or-uncomment-lines)
  (define-key wf-evil-comma-map "cl" 'evilnc-quick-comment-or-uncomment-to-the-line)
  (define-key wf-evil-comma-map "d" 'dired-jump)
  (define-key wf-evil-comma-map "e" 'wf-sudo-find-file)
  (define-key wf-evil-comma-map "f" 'ido-find-file)
  (define-key wf-evil-comma-map "g" 'magit-status)
  (define-key wf-evil-comma-map "h" 'ibuffer)
  ; ,i taken by 'evilmi-select-items and 'evilmi-delete-items
  (define-key wf-evil-comma-map "k" 'kill-buffer)
  (define-key wf-evil-comma-map "l" 'evil-ace-jump-line-mode)
  (define-key wf-evil-comma-map "m" 'idomenu)
  (define-key wf-evil-comma-map "n" 'evil-show-file-info)
  (define-key wf-evil-comma-map "p" 'pdb)
  (define-key wf-evil-comma-map "q" 'kill-buffer-and-window)
  (define-key wf-evil-comma-map "r" 'browse-kill-ring)
  (define-key wf-evil-comma-map "s" 'ispell-word)
  (define-key wf-evil-comma-map "t" 'visit-tags-table)
  (define-key wf-evil-comma-map "v" 'evil-buffer)
  (define-key wf-evil-comma-map "w" 'evil-ace-jump-word-mode)
  (define-key wf-evil-comma-map "x" 'find-name-dired)
  (define-key wf-evil-comma-map "y" 'python-shell)
  (define-key evil-normal-state-map "," 'wf-evil-comma-map)
  (define-key evil-motion-state-map "," 'wf-evil-comma-map)

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

  ;; keybindings for depeding on major modes

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

  (eval-after-load "magit"
    '(progn
       (wf-define-evil-movements magit-status-mode-map
         "K" 'magit-discard)
       (wf-define-evil-movements magit-commit-mode-map)
       (wf-define-evil-movements magit-log-mode-map)))

  (eval-after-load "Man"
    '(progn
       (evil-make-overriding-map Man-mode-map 'normal t)
       (evil-define-key 'normal Man-mode-map
         "k" (lookup-key evil-motion-state-map "k"))))

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
         "\M-j" 'org-metadown)
       (delete '("\\.pdf\\'" . default) org-file-apps)
       (add-to-list 'org-file-apps '("\\.pdf\\'" . "evince %s"))
       (add-to-list 'org-file-apps '("\\.bmp\\'" . default))
       (add-to-list 'org-file-apps '("\\.gif\\'" . default))
       (add-to-list 'org-file-apps '("\\.jpg\\'" . default))
       (add-to-list 'org-file-apps '("\\.png\\'" . default))
       (add-to-list 'org-file-apps '("\\.tif\\'" . default))))
  )

(use-package evil-matchit
  :after evil
  :ensure t
  :defer t
  :config
  ;; Re-define keybinding for evil matchit mode
  (defun evilmi-customize-keybinding ()
    (evil-define-key 'normal evil-matchit-mode-map
      "%" 'evilmi-jump-items
      ",is" 'evilmi-select-items
      ",id" 'evilmi-delete-items
      ))

  ;; Evil global modes
  (global-evil-matchit-mode 1))

(use-package evil-nerd-commenter
  :after evil
  :commands evilnc-comment-or-uncomment-lines
  :bind (("M-;" . evilnc-comment-or-uncomment-lines))
  :config
  (evilnc-default-hotkeys))

(use-package ace-jump-mode
  :after evil
  :ensure t
  :defer t
  :init
  ;; To supress the warning: Package cl is deprecated
  (setq byte-compile-warnings '(not cl-functions obsolete))
  :config
  (define-key evil-motion-state-map (kbd "SPC") #'evil-ace-jump-word-mode)
  (define-key evil-normal-state-map (kbd "SPC") #'evil-ace-jump-word-mode)
  (define-key evil-operator-state-map (kbd "SPC") #'evil-ace-jump-char-mode))

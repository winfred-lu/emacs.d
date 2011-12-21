(setq load-path (cons "/usr/share/emacs/site-lisp/emacs-goodies-el" load-path))
(setq load-path (cons "~/.emacs.d/" load-path))

;;; color terminal
(add-to-list 'load-path "color-theme.el")
(require 'color-theme)
(color-theme-initialize)
(eval-after-load "color-theme" '(color-theme-ld-dark))

;;; viper
;(setq viper-mode t)
;(require 'viper)

;;; imap jj to ESC
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

;;; Evil
(add-to-list 'load-path "~/.emacs.d/evil")
(require 'evil)
(evil-mode 1)

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

; make evil work for org-mode!
(define-key evil-normal-state-map "O" (lambda ()
                     (interactive)
                     (end-of-line)
                     (org-insert-heading)
                     (evil-append nil)
                     ))

(define-key evil-normal-state-map "[[" 'c-beginning-of-defun)
(define-key evil-normal-state-map "[]" 'c-end-of-defun)

;;; org mod settings
(require 'org-install)
(add-to-list 'auto-mode-alist '("\\.org$" . org-mode))
(define-key global-map "\C-cl" 'org-store-link)
(define-key global-map "\C-ca" 'org-agenda)
(setq org-log-done t)
(setq org-agenda-include-diary t)
(setq org-agenda-files (list "~/org/work.org"
                             "~/org/home.org"))
(setq browse-url-browser-function (quote browse-url-generic))
(setq browse-url-generic-program "chromium-browser")

;; mobile org settings
(setq org-directory "~/org")
(setq org-mobile-inbox-for-pull "~/org/flagged.org")
(setq org-mobile-directory "~/Dropbox/org")

;;; buffer switching
(global-set-key (kbd "C-x C-b") 'buffer-menu)
(iswitchb-mode 1)
(setq iswitchb-buffer-ignore '("^ " "*Buffer"))
(setq iswitchb-delim " | ")

;;; c settings
(require 'cc-mode)
(setq c-default-style "linux"
      c-basic-offset 8)
(define-key c-mode-base-map (kbd "RET") 'newline-and-indent)

;;; magit
(require 'magit)

;;; auto pair
(require 'autopair)
(autopair-global-mode)

(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(auto-save-file-name-transforms (quote ((".*" "~/.emacs.d/autosaves/\\1" t))))
 '(backup-directory-alist (quote ((".*" . "~/.emacs.d/backups/"))))
 '(c-tab-always-indent nil)
 '(ediff-split-window-function (quote split-window-horizontally))
 '(vc-follow-symlinks nil))
(make-directory "~/.emacs.d/autosaves/" t)

(custom-set-faces
  ;; custom-set-faces was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 )

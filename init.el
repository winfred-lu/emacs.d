;; Winfred's Emacs Enrionment

(add-to-list 'load-path "~/.emacs.d")
;Add all top-level subdirectories of .emacs.d to the load path
(progn (cd "~/.emacs.d")
       (normal-top-level-add-subdirs-to-load-path))
;Keep third party libraries seperate in ~/.emacs.d/vendor
(add-to-list 'load-path "~/.emacs.d/vendor")
(progn (cd "~/.emacs.d/vendor")
       (normal-top-level-add-subdirs-to-load-path))

(load-library "winfred-visual")
(load-library "winfred-evil")
(load-library "winfred-misc")

;;; org mod settings
;(require 'org-install)
;(add-to-list 'auto-mode-alist '("\\.org$" . org-mode))
;(define-key global-map "\C-cl" 'org-store-link)
;(define-key global-map "\C-ca" 'org-agenda)
;(setq org-log-done t)
;(setq org-agenda-include-diary t)
;(setq org-agenda-files (list "~/org/work.org"
                             ;"~/org/home.org"))
;(setq browse-url-browser-function (quote browse-url-generic))
;(setq browse-url-generic-program "chromium-browser")

;; mobile org settings
;(setq org-directory "~/org")
;(setq org-mobile-inbox-for-pull "~/org/flagged.org")
;(setq org-mobile-directory "~/Dropbox/org")

;;; buffer switching
;(global-set-key (kbd "C-x C-b") 'buffer-menu)
;(iswitchb-mode 1)
;(setq iswitchb-buffer-ignore '("^ " "*Buffer"))
;(setq iswitchb-delim " | ")

;;; c settings
;(require 'cc-mode)
;(setq c-default-style "linux"
      ;c-basic-offset 8)
;(define-key c-mode-base-map (kbd "RET") 'newline-and-indent)

;;; magit
;(require 'magit)

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

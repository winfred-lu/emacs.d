;; org mod settings
(add-to-list 'auto-mode-alist '("\\.org$" . org-mode))
(setq org-log-done t)
(setq org-hide-leading-stars "hidestarts")
(setq org-agenda-files (list "~/org/work.org"
                             "~/org/home.org"))

;; mobile org settings
(setq org-directory "~/org")
(setq org-mobile-inbox-for-pull "~/org/flagged.org")
(setq org-mobile-directory "~/Dropbox/org")

(setq org-hide-emphasis-markers t)

;; org mode settings
(add-to-list 'auto-mode-alist '("\\.org$" . org-mode))
(setq org-agenda-files (file-expand-wildcards "~/org/*.org")
      org-hide-leading-stars "hidestars"
      org-hide-emphasis-markers t
      org-log-done t)

;; mobile org settings
(setq org-directory "~/org"
      org-mobile-inbox-for-pull "~/org/flagged.org"
      org-mobile-directory "~/Dropbox/org")

;; babel settings
(setq org-ditaa-jar-path "~/.emacs.d/ditaa.jar"
      org-plantuml-jar-path "/usr/share/plantuml/plantuml.jar"
      org-babel-results-keyword "results"
      org-confirm-babel-evaluate nil)

(defun bh/display-inline-images ()
  (condition-case nil
      (org-display-inline-images)
    (error nil)))
(add-hook 'org-babel-after-execute-hook 'bh/display-inline-images 'append)

;; active Babel languages
(if (fboundp 'org-babel-do-load-languages)
    (org-babel-do-load-languages 'org-babel-load-languages
                                 '((emacs-lisp . t)
                                   (ditaa . t)
                                   (gnuplot . t)
                                   (org . t)
                                   (plantuml . t)
                                   (python . t))))
(if (boundp 'add-to-list)
    (add-to-list 'org-src-lang-modes (quote ("plantuml" . fundamental))))

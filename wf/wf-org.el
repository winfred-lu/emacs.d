;; markdown-mode
(autoload 'markdown-mode "markdown-mode"
     "Major mode for editing Markdown files" t)
(add-to-list 'auto-mode-alist '("\\.markdown\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode))

;; load orgmode from directory ~/org-xx if it exists
(let ((my-org-d (car (file-expand-wildcards "~/org-*"))))
  (if my-org-d
      (setq load-path (cons (concat my-org-d "/lisp/") load-path)
            org-ditaa-jar-path (concat my-org-d "/contrib/scripts/ditaa.jar"))
    (setq org-ditaa-jar-path "~/.emacs.d/ditaa.jar")))
(use-package org-install
  :defer t)

;; org mode settings
(add-to-list 'auto-mode-alist '("\\.org$" . org-mode))
(setq org-agenda-files (file-expand-wildcards "~/org/*.org")
      org-hide-leading-stars "hidestars"
      org-hide-emphasis-markers t
      org-log-done t
      org-completion-use-ido t
      org-return-follows-link t)

;; mobile org settings
(setq org-directory "~/org"
      org-mobile-inbox-for-pull "~/org/flagged.org"
      org-mobile-directory "~/Dropbox/org")

;; babel settings
(setq org-plantuml-jar-path "/usr/share/plantuml/plantuml.jar"
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
                                   (python . t)
                                   (shell . t))))
(if (boundp 'add-to-list)
    (add-to-list 'org-src-lang-modes (quote ("plantuml" . fundamental))))

(setq org-export-htmlize-output-type 'css)
(setq org-src-fontify-natively t)

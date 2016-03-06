;; customized package list to check
(defvar wf-required-packages
  '(
    ace-jump-mode
    autopair
    browse-kill-ring
    color-theme
    etags-select
    evil
    evil-matchit
    evil-nerd-commenter
    idomenu
    magit
    yasnippet
    ) "a list of packages to ensure are installed")

;; function to check if all listed packages are installed
(require 'cl)
(defun wf-packages-installed ()
  (loop for p in wf-required-packages
        when (not (package-installed-p p)) do (return nil)
                  finally (return t)))

;; check & install missing packages if not all the listed packages are installed
(unless (wf-packages-installed)
  (message "%s" "Emacs is now refreshing package database...")
  (package-refresh-contents)
  (message "%s" " done.")
  (dolist (p wf-required-packages)
    (when (not (package-installed-p p))
      (package-install p)))
  )
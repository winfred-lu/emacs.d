;; customized packages to check and install
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
    hide-region
    idomenu
    magit
    xcscope
    yasnippet
    ) "a list of packages to ensure are installed")

;; fetch the available package lists
(unless package-archive-contents
  (package-refresh-contents))

;; check & install missing packages
(dolist (p wf-required-packages)
  (unless (package-installed-p p)
    (package-install p)))

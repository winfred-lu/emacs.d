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
    goto-chg            ; Evil requires `goto-last-change' and `goto-last-change-reverse' function for the corresponding motions g; g, as well as the last-change-register `.'
    helm
    hide-region
    idomenu
    magit
    smart-tab
    undo-tree           ; Evil requires undo-tree.el for linear undo and undo branches
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

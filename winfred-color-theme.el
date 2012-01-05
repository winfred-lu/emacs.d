;; c-u m-x list-faces-display
(defun color-theme-winfred ()
  "Color theme by Winfred (winfred.lu AT gmail.com), created 2011-12-21"
  (interactive)
  (color-theme-install
   '(color-theme-winfred
     ((background-color . "black")
      (background-mode . dark)
      (border-color . "black")
      (cursor-color . "black")
      (foreground-color . "LightGray")
      (mouse-color . "black"))
     ((blank-space-face . blank-space-face)
      (blank-tab-face . blank-tab-face)
      (list-matching-lines-face . bold)
      (Man-reverse-face . highlight)
      (Man-overstrike-face . ((t (:bold t :foreground "#d0a0c0"))))
      (Man-underline-face . ((t (:underline t :foreground "#a0d0d0"))))
      (view-highlight-face . highlight))
     (default ((t (nil))))
     (blank-space-face ((t (:background "LightGray"))))
     (blank-tab-face ((t (:background "green" :foreground "black"))))
     (bold ((t (:bold t))))
     (bold-italic ((t (:italic t :bold t))))

     (buffer-menu-star-buffer ((t (:foreground "#d0d050"))))
     (buffer-menu-directory-buffer ((t (:background "#402010" :foreground "#d0d020"))))
     (buffer-menu-modified-mark ((t (:foreground "#50d0d0"))))
     (buffer-menu-read-only-mark ((t (:foreground "#2020d0"))))
     (buffer-menu-buffer-name ((t (:foreground "#d0d020"))))
     (buffer-menu-mode ((t (:foreground "#d070d0"))))
     (buffer-menu-size ((t (:foreground "#50d0d0"))))
     (buffer-menu-time ((t (:foreground "#5070d0"))))
     (buffer-menu-file-name ((t (:foreground "#50d050"))))

     (ediff-current-diff-face-A ((t (:background "pale green" :foreground "firebrick"))))
     (ediff-current-diff-face-Ancestor ((t (:background "VioletRed" :foreground "Black"))))
     (ediff-current-diff-face-B ((t (:background "Yellow" :foreground "DarkOrchid"))))
     (ediff-current-diff-face-C ((t (:background "indianred" :foreground "white"))))
     (ediff-even-diff-face-A ((t (:background "light gray" :foreground "Black"))))
     (ediff-even-diff-face-Ancestor ((t (:background "Gray" :foreground "White"))))
     (ediff-even-diff-face-B ((t (:background "Gray" :foreground "White"))))
     (ediff-even-diff-face-C ((t (:background "light gray" :foreground "Black"))))
     (ediff-fine-diff-face-A ((t (:background "sky blue" :foreground "Navy"))))
     (ediff-fine-diff-face-Ancestor ((t (:background "Green" :foreground "Black"))))
     (ediff-fine-diff-face-B ((t (:background "cyan" :foreground "Black"))))
     (ediff-fine-diff-face-C ((t (:background "Turquoise" :foreground "Black"))))
     (ediff-odd-diff-face-A ((t (:background "Gray" :foreground "White"))))
     (ediff-odd-diff-face-Ancestor ((t (:background "light gray" :foreground "Black"))))
     (ediff-odd-diff-face-B ((t (:background "light gray" :foreground "Black"))))
     (ediff-odd-diff-face-C ((t (:background "Gray" :foreground "White"))))

     (font-lock-constant-face ((t (:foreground "#e0e090"))))
     (font-lock-comment-face ((t (:italic t :foreground "#707070"))))
     (font-lock-keyword-face ((t (:foreground "#90c0e0"))))
     (font-lock-preprocessor-face ((t (:italic t :foreground "#a0e0d0"))))
     (font-lock-string-face ((t (:foreground "#e0e0a0"))))
     (font-lock-variable-name-face ((t (:foreground "#90a0f0"))))
     (font-lock-function-name-face ((t (:italic t :foreground "#e0a0c0"))))
     (font-lock-type-face ((t (:foreground "#a0d0e0"))))
     (font-lock-warning-face ((t (:bold t :foreground "#e07060"))))

     (highlight ((t (:background "dark slate blue" :foreground "#90a0f0"))))
     (isearch ((t (:background "#a05050" :foreground "#50a0a0"))))
     (ispell-face ((t (:bold t :background "#f0b070" :foreground "#90e080"))))
     (italic ((t (:italic t))))

     (magit-log-sha1 ((t (:foreground "#cf6a4c"))))
     (magit-log-head-label-local ((t (:foreground "#3387cc"))))
     (magit-log-head-label-remote ((t (:foreground "#65b042"))))
     (magit-branch ((t (:foreground "#e9c062"))))
     (magit-section-title ((t (:foreground "#9b859d"))))
     (magit-item-highlight ((t (:background "#1f1f1f"))))
     (magit-diff-add ((t (:foreground "PaleGreen3"))))
     (magit-diff-del ((t (:foreground "salmon"))))

     (menu ((t (:background "#304020" :foreground "navajo white"))))
     (modeline ((t (:background "dark slate blue" :foreground "LightGray"))))
     (modeline-mousable ((t (:background "light goldenrod" :foreground "dim gray"))))
     (modeline-mousable-minor-mode ((t (:background "dim gray" :foreground "light goldenrod"))))

     (org-level-1 ((t (:foreground "#e09090"))))
     (org-level-2 ((t (:foreground "#e0a080"))))
     (org-level-3 ((t (:foreground "#e0e090"))))
     (org-level-4 ((t (:foreground "#b0e0a0"))))
     (org-level-5 ((t (:foreground "#a0d0e0"))))
     (org-level-6 ((t (:foreground "#a0a0e0"))))
     (org-level-7 ((t (:foreground "#e0a0d0"))))
     (org-level-8 ((t (:foreground "#808080"))))

     (region ((t (:background "dark slate gray"))))
     (secondary-selection ((t (:background "dark slate blue" :foreground "light goldenrod"))))
     (show-paren-match-face ((t (:background "turquoise" :foreground "black"))))
     (show-paren-mismatch-face ((t (:background "purple" :foreground "white"))))
     (underline ((t (:underline t))))
     (zmacs-region ((t (:background "dark slate gray")))))))

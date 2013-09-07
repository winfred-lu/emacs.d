;; color-theme
(require 'color-theme)
(load-library "winfred-color-theme")
(color-theme-winfred)
;(tty-run-terminal-initialization (selected-frame) "rxvt")

;; Don't show the startup screen, menu bar, tool bar, and scroll bar
(setq inhibit-startup-message t)
(if (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))
(if (fboundp 'tool-bar-mode) (tool-bar-mode -1))
(if (fboundp 'menu-bar-mode) (menu-bar-mode -1))

(setq line-number-mode t)
(setq column-number-mode t)
(if (not indicate-empty-lines) (toggle-indicate-empty-lines))

;; Eighty column
(setq-default fill-column 80)
(setq sentence-end-double-space nil)

;; Disable '\' character in line wrapping
;(set-display-table-slot standard-display-table 'wrap ?\ )

;; Show the matching parens
(show-paren-mode t)
(setq show-paren-delay 0)

;; Visible bell
(setq visible-bell t)

;; Indent Tabs
(setq-default indent-tabs-mode nil)

;; Enable narrow-to-region
(put 'narrow-to-region 'disabled nil)

;; highlight FIXME comments
(add-hook 'c-mode-common-hook
          (lambda ()
            (font-lock-add-keywords
             nil
             '(("\\<\\(FIXME\\|TODO\\|BUG\\|XXX\\)\\>" 1 font-lock-warning-face t)))))
(let ((fixme-modes '(org-mode emacs-lisp-mode)))
  (mapc (lambda (mode)
          (font-lock-add-keywords
           mode
           '(("\\<\\(FIXME\\)\\>" 1 font-lock-warning-face t))))
        fixme-modes))

;; mode-line settings
(setq-default
 mode-line-format
 '("%e"
   ;; read-only or modified status
   (:eval (cond (buffer-read-only "RO ")
                ((buffer-modified-p) "** ")
                (t "   ")))
   mode-line-buffer-identification
   " "
   mode-line-position
   evil-mode-line-tag
   (vc-mode vc-mode)
   " "
   mode-line-modes
   mode-line-misc-info
   ))

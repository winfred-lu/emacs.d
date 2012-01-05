;; color-theme
(require 'color-theme)
(load-library "winfred-color-theme")
(color-theme-winfred)

;; Don't show the startup screen, menu bar, tool bar, and scroll bar
(setq inhibit-startup-message t)
(menu-bar-mode nil)
(tool-bar-mode nil)
(scroll-bar-mode nil)

;; Display line and column numbers
(setq line-number-mode t)
(setq column-number-mode t)

;; Line-wrapping
(setq-default fill-column 72)

;; Show the matching parens
(show-paren-mode t)
(setq show-paren-delay 0)

;; Visible bell
(setq visible-bell t)

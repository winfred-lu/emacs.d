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
(load-library "winfred-buffer")
(load-library "winfred-magit")
(load-library "winfred-misc")
(load-library "winfred-yasnippet")

;;; c settings
;(require 'cc-mode)
;(setq c-default-style "linux"
      ;c-basic-offset 8)
;(define-key c-mode-base-map (kbd "RET") 'newline-and-indent)

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

(require 'helm)
(require 'helm-config)

;; The default "C-x c" is quite close to "C-x C-c", which quits Emacs.
;; Changed to "C-c h". Note: We must set "C-c h" globally, because we
;; cannot change `helm-command-prefix-key' once `helm-config' is loaded.
(global-set-key (kbd "C-c h") 'helm-command-prefix)
(global-unset-key (kbd "C-x c"))

;; Uncomment if it is needed to rebind <tab> to run persistent action,
;; and to list actions using C-z instead since <tab> being used.
;(define-key helm-map (kbd "<tab>") 'helm-execute-persistent-action)
;(define-key helm-map (kbd "C-i") 'helm-execute-persistent-action)
;(define-key helm-map (kbd "C-z") 'helm-select-action)

(when (executable-find "curl")
  (setq helm-google-suggest-use-curl-p t))

;; find-files to skip files not interested
(setq helm-ff-skip-boring-files t
      helm-ff-file-name-history-use-recentf t
      helm-boring-file-regexp-list
      '("\\.git$" "\\.hg$" "\\.svn$" "\\.CVS" "\\.o$" "~$"
        "\\.elc$" "\\.pyc")
      )

(setq helm-buffers-fuzzy-matching t
      helm-recentf-fuzzy-match t
      helm-M-x-fuzzy-match t
      helm-apropos-fuzzy-match t
      )

;; Key bindings related to helm. They will overwrite some keys defined
;; previously in wf-keys.el or wf-evil.el
(global-set-key (kbd "C-h a")   'helm-apropos)
(global-set-key (kbd "C-h i")   'helm-info-emacs)
(global-set-key (kbd "C-h g")   'helm-info-gnus)
(global-set-key (kbd "C-x b")   'helm-mini)
(global-set-key (kbd "C-x C-b") 'helm-buffers-list)
(global-set-key (kbd "C-x C-f") 'helm-find-files)
(global-set-key (kbd "C-x r l") 'helm-filtered-bookmarks)
(global-set-key (kbd "M-x")     'helm-M-x)
(global-set-key (kbd "M-y")     'helm-show-kill-ring)

(define-key evil-normal-state-map "\C-]" 'helm-etags-select)

(helm-mode 1)

;; add our folder to the load-path
(add-to-list 'load-path (concat user-emacs-directory "wf"))

;; keep customize settings separately
(setq custom-file (concat user-emacs-directory "custom.el"))
(when (file-exists-p custom-file)
  (load custom-file))

;; temporarily reduce garbage collection during startup (speed up)
(defconst wf-original-gc-cons-threshold gc-cons-threshold
    "Initial value of `gc-cons-threshold' at start-up time.")
(setq gc-cons-threshold (* 128 1024 1024))
(add-hook 'after-init-hook
          (lambda () (setq gc-cons-threshold wf-original-gc-cons-threshold)))

;; add package sources
(unless (assoc-default "melpa" package-archives)
  (add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t))

;(load ""wf-proxy"")

;; ensure to install use-package
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(load "wf-visual")
(load "wf-evil")
(load "wf-buffer")
(load "wf-misc")
(load "wf-keys")
(load "wf-program")
(load "wf-org")
(load "wf-ido")

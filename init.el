;; add our folder to the load-path
(add-to-list 'load-path (concat user-emacs-directory "wf"))

;; temporarily reduce garbage collection during startup (speed up)
(defconst wf-original-gc-cons-threshold gc-cons-threshold
    "Initial value of `gc-cons-threshold' at start-up time.")
(setq gc-cons-threshold (* 128 1024 1024))
(add-hook 'after-init-hook
          (lambda () (setq gc-cons-threshold wf-original-gc-cons-threshold)))

;; add package sources
(unless (assoc-default "melpa" package-archives)
  (add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t))

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

(use-package yasnippet
  :hook ((c-mode . yas-minor-mode)
         (python-mode . yas-minor-mode)
         (sh-mode . yas-minor-mode)
         (emacs-lisp-mode . yas-minor-mode)))

(use-package magit
  :commands magit-status
  :ensure t
  :bind (("C-x g" . magit-status)))

(use-package xcscope :ensure t)

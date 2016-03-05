;; Winfred's Emacs Enrionment

;; Configure the load path
(add-to-list 'load-path (concat user-emacs-directory "wf"))
(let ((default-directory (concat user-emacs-directory
                                 (convert-standard-filename "vendor/"))))
  (normal-top-level-add-to-load-path '("."))
  (normal-top-level-add-subdirs-to-load-path))
; wf: strange evil/lib is not added to load-path
(add-to-list 'load-path (concat user-emacs-directory "vendor/evil/lib"))

;; temporarily reduce garbage collection during startup (speed up)
(defconst wf-original-gc-cons-threshold gc-cons-threshold
    "Initial value of `gc-cons-threshold' at start-up time.")
(setq gc-cons-threshold (* 128 1024 1024))
(add-hook 'after-init-hook
          (lambda () (setq gc-cons-threshold wf-original-gc-cons-threshold)))

;; Emacs 24: packages using MELPA
(when (>= emacs-major-version 24)
  (require 'package)
  (add-to-list 'package-archives
               '("melpa" . "http://melpa.milkbox.net/packages/") t)
  (package-initialize))

(load-library "wf-visual")
(load-library "wf-evil")
(load-library "wf-buffer")
(load-library "wf-misc")
(load-library "wf-keys")
(load-library "wf-program")
(load-library "wf-org")
(load-library "wf-yasnippet")

(require 'etags-select)
(require 'magit)
(require 'xcscope)

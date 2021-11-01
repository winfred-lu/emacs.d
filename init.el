;; Winfred's Emacs Enrionment

(when (< emacs-major-version 24)
  (message "Your Emacs is old. Please upgrade if possible"))

;; add our folder to the load-path
(add-to-list 'load-path (concat user-emacs-directory "wf"))

;; temporarily reduce garbage collection during startup (speed up)
(defconst wf-original-gc-cons-threshold gc-cons-threshold
    "Initial value of `gc-cons-threshold' at start-up time.")
(setq gc-cons-threshold (* 128 1024 1024))
(add-hook 'after-init-hook
          (lambda () (setq gc-cons-threshold wf-original-gc-cons-threshold)))

;; un-comment the next line to check and install listed packages on startup
;(load-library "wf-chk-pkgs")

(load-library "wf-visual")
(load-library "wf-evil")
(load-library "wf-buffer")
(load-library "wf-misc")
(load-library "wf-keys")
(load-library "wf-program")
(load-library "wf-org")
(load-library "wf-yasnippet")
;; Ido and Helm are incompatible. Choose either one.
;(load-library "wf-helm")
(load-library "wf-ido")

(require 'magit)
(require 'xcscope)

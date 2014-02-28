;; yasnippet settings
(require 'yasnippet)
(setq yas/trigger-key "`")
(yas/initialize)
(yas/load-directory (concat user-emacs-directory "snippets"))
(yas/global-mode 1)

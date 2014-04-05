;; yasnippet settings
(require 'yasnippet)
(yas/load-directory (concat user-emacs-directory "snippets"))

;; use minor mode instead of global mode
;(yas/global-mode 1)
(add-hook 'c-mode-common-hook '(lambda () (yas-minor-mode)))
(add-hook 'python-mode-hook '(lambda () (yas-minor-mode)))
(add-hook 'sh-mode-hook '(lambda () (yas-minor-mode)))

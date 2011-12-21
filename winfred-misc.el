;; magit (apt-get install magit)
(require 'magit)
(global-set-key "\C-xg" 'magit-status)

;; auto pair
(require 'autopair)
(autopair-global-mode)

;; Remove unnecessary trailing whitespace
(add-hook 'before-save-hook (lambda () (delete-trailing-whitespace)))

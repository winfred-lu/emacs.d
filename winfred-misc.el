;; auto pair
(require 'autopair)
(autopair-global-mode)

;; Remove unnecessary trailing whitespace
(add-hook 'before-save-hook (lambda () (delete-trailing-whitespace)))

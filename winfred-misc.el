;; Remove unnecessary trailing whitespace
(add-hook 'before-save-hook (lambda () (delete-trailing-whitespace)))

;; y-or-n
(defalias 'yes-or-no-p 'y-or-n-p)

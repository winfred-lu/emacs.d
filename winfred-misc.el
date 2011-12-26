;; Remove unnecessary trailing whitespace
(add-hook 'before-save-hook (lambda () (delete-trailing-whitespace)))

;; y-or-n
(defalias 'yes-or-no-p 'y-or-n-p)

;; auto pair
(require 'autopair)
(autopair-global-mode)

;; chromium as default browser
(setq browse-url-browser-function 'browse-url-generic
      browse-url-generic-program "chromium-browser")
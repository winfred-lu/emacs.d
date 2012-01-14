;; Remove unnecessary trailing whitespace
(add-hook 'before-save-hook (lambda () (delete-trailing-whitespace)))

;; y-or-n
(defalias 'yes-or-no-p 'y-or-n-p)

;; auto pair
(require 'autopair)
(autopair-global-mode)
(add-hook 'emacs-lisp-mode-hook
          #'(lambda ()
              (push '(?` . ?')
                    (getf autopair-extra-pairs :comment))
              (push '(?` . ?')
                    (getf autopair-extra-pairs :string))))

;; chromium as default browser
(setq browse-url-browser-function 'browse-url-generic
      browse-url-generic-program "chromium-browser")

;; to copy and paste between emacs and other apps
(setq x-select-enable-clipboard t)
(setq interprogram-paste-function 'x-cut-buffer-or-selection-value)

;; stop y-and-n before editing symlinks
(setq vc-follow-symlinks nil)
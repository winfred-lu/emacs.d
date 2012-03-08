;; Remove unnecessary trailing whitespace
(add-hook 'before-save-hook (lambda () (delete-trailing-whitespace)))

;; y-or-n
(defalias 'yes-or-no-p 'y-or-n-p)

;; auto pair
(require 'autopair)
;(autopair-global-mode)
(add-hook 'c-mode-common-hook #'(lambda () (autopair-mode)))
(add-hook 'emacs-lisp-mode-hook
          #'(lambda ()
              (autopair-mode)
              (push '(?` . ?')
                    (getf autopair-extra-pairs :comment))
              (push '(?` . ?')
                    (getf autopair-extra-pairs :string))))

;; chromium as default browser
(setq browse-url-browser-function 'browse-url-generic
      browse-url-generic-program "chromium-browser")

;; to copy and paste between emacs and other apps
(setq x-select-enable-clipboard t
      interprogram-paste-function 'x-cut-buffer-or-selection-value)

;; stop y-and-n before editing symlinks
(setq vc-follow-symlinks nil)


;; http://irreal.org/blog/?p=297  http://nflath.com/2009/08/easier-emacs/
(defun eval-and-replace ()
  "Replace the preceding sexp with its value."
  (interactive)
  (backward-kill-sexp)
  (condition-case nil
      (prin1 (eval (read (current-kill 0)))
             (current-buffer))
    (error (message "Invalid expression")
           (insert (current-kill 0)))))
(global-set-key "\C-ce" 'eval-and-replace)


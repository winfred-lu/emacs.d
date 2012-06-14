;; Remove unnecessary trailing whitespace
(add-hook 'before-save-hook (lambda () (delete-trailing-whitespace)))

;; y-or-n
(defalias 'yes-or-no-p 'y-or-n-p)

;; auto pair
(require 'autopair)
;(autopair-global-mode)
(add-hook 'c-mode-common-hook #'(lambda () (autopair-mode)))
(add-hook 'python-mode-hook #'(lambda () (autopair-mode)))
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

;; stop y-and-n before editing symlinks
(setq vc-follow-symlinks nil)

;; chinese input method: boshiamy and zozy
(setq default-input-method "chinese-liu5")
(defun switch-to-zozy ()
  (interactive)
  (activate-input-method "chinese-zozy"))
(global-set-key (kbd "<S-f7>") 'switch-to-zozy)
(defun switch-to-liu ()
  (interactive)
  (activate-input-method "chinese-liu5"))
(global-set-key (kbd "<C-f8>") 'switch-to-liu)

;; prints the major mode of current buffer
(defun major-mode (buf)
  (interactive "b")
  (with-current-buffer buf
    (message "major-mode of %s is %s" buf major-mode)))

;; http://irreal.org/blog/?p=297
;; http://nflath.com/2009/08/easier-emacs/
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

;; http://stackoverflow.com/questions/1242352/get-font-face-under-cursor-in-emacs
(defun what-face (pos)
  (interactive "d")
  (let ((face (or (get-char-property (point) 'read-face-name)
                  (get-char-property (point) 'face))))
    (if face (message "Face: %s" face) (message "No face at %d" pos))))


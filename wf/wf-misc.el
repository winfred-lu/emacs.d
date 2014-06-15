;; delete trailing white spaces before saving a buffer
(add-hook 'before-save-hook 'delete-trailing-whitespace)

(defun wf-toggle-delete-trailing-whitespace-before-save ()
  "Toggle to (not to) delete trailing white spaces before saving a buffer."
  (interactive)
  (defvar wf-del-trailing-ws-b4-save t)
  (setq wf-del-trailing-ws-b4-save
        (if wf-del-trailing-ws-b4-save nil t))
  (if wf-del-trailing-ws-b4-save
      (add-hook 'before-save-hook 'delete-trailing-whitespace)
    (remove-hook 'before-save-hook 'delete-trailing-whitespace))
  (message "delete-trailing-whitespace-before-save %s"
           (if wf-del-trailing-ws-b4-save "enabled" "disabled")))

;; highlight trailing spaces
(setq-default show-trailing-whitespace t)

;; y-or-n
(defalias 'yes-or-no-p 'y-or-n-p)

;; auto pair
(require 'autopair)
;(autopair-global-mode)
(add-hook 'c-mode-common-hook
          #'(lambda ()
              (autopair-mode)
              (push ?{
                    (cl-getf autopair-dont-pair :comment))))
(add-hook 'python-mode-hook
          #'(lambda ()
              (autopair-mode)
              (setq autopair-handle-action-fns
                    (list #'autopair-default-handle-action
                          #'autopair-python-triple-quote-action))))
(add-hook 'emacs-lisp-mode-hook
          #'(lambda ()
              (autopair-mode)
              (push '(?` . ?')
                    (cl-getf autopair-extra-pairs :comment))
              (push '(?` . ?')
                    (cl-getf autopair-extra-pairs :string))))

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

;; http://emacswiki.org/emacs/CopyAndPaste
(defun yank-to-x-clipboard ()
  (interactive)
  (if (region-active-p)
      (progn
        (shell-command-on-region (region-beginning) (region-end) "xsel -i")
        (message "Yanked region to clipboard!")
        (deactivate-mark))
    (message "No region active; can't yank to clipboard!")))

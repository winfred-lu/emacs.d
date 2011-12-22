;; c settings
(require 'cc-mode)
(setq c-default-style "linux"
      c-basic-offset 8)

;; local key bindins
(add-hook 'cc-mode-hook
	  (lambda ()
	    (local-set-key (kbd "RET") 'newline-and-indent)
	    ))

(define-key evil-normal-state-map "[[" 'c-beginning-of-defun)
(define-key evil-normal-state-map "][" 'c-end-of-defun)

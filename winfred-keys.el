;; F11 to toggle whitespace-mode on/off
(global-set-key [(f11)] 'whitespace-mode)

;; auto indentation after RET
(define-key global-map (kbd "RET") 'newline-and-indent)

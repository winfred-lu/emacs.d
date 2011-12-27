;; F11 to toggle whitespace-mode on/off
(global-set-key [(f11)] 'whitespace-mode)

;; auto indentation after RET
(define-key global-map (kbd "RET") 'newline-and-indent)

;; C-c C-o to lunch web browser for URL at point
(global-set-key "\C-c\C-o" 'browse-url-at-point)
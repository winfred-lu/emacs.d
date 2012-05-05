(global-set-key [(f11)] 'whitespace-mode)
(global-set-key [(f12)] (lambda()(interactive)(switch-to-buffer "*scratch*")))

(define-prefix-command 'wf-minor-mode-map)
(define-key wf-minor-mode-map "a" 'artist-mode)
(define-key wf-minor-mode-map "h" 'hl-line-mode)
(define-key wf-minor-mode-map "s" 'flyspell-mode)
(define-key wf-minor-mode-map "v" 'visual-line-mode)
(define-key wf-minor-mode-map "w" 'whitespace-mode)

;; functions frequently used
(global-set-key "\C-ca" 'org-agenda)
(global-set-key "\C-xg" 'magit-status)
(global-set-key "\C-xm" 'wf-minor-mode-map)
(global-set-key "\C-x\C-b" 'ibuffer)

;; ido with artist-mode
(defun artist-ido-select-operation (type)
  "Use ido to select a drawing operation in artist-mode"
  (interactive
   (list (ido-completing-read
          "Drawing operation: "
          (list "Pen" "Pen Line" "line" "straight line" "rectangle"
                "square" "poly-line" "straight poly-line" "ellipse"
                "circle" "text see-thru" "text-overwrite" "spray-can"
                "erase char" "erase rectangle" "vaporize line" "vaporize lines"
                "cut rectangle" "cut square" "copy rectangle" "copy square"
                "paste" "flood-fill"))))
  (artist-select-operation type))
(defun artist-ido-select-settings (type)
  "Use ido to select a setting to change in artist-mode"
  (interactive
   (list (ido-completing-read
          "Setting: "
          (list "Set Fill" "Set Line" "Set Erase" "Spray-size" "Spray-chars"
                "Rubber-banding" "Trimming" "Borders"))))
  (if (equal type "Spray-size")
      (artist-select-operation "spray set size")
    (call-interactively (artist-fc-get-fn-from-symbol
                         (cdr (assoc type '(("Set Fill" . set-fill)
                                            ("Set Line" . set-line)
                                            ("Set Erase" . set-erase)
                                            ("Rubber-banding" . rubber-band)
                                            ("Trimming" . trimming)
                                            ("Borders" . borders)
                                            ("Spray-chars" . spray-chars))))))))


(add-hook 'artist-mode-hook
          (lambda ()
            (define-key artist-mode-map "\C-c\C-o" 'artist-ido-select-operation)
            (define-key artist-mode-map "\C-c\C-s" 'artist-ido-select-settings)))

(add-hook 'cscope-list-entry-hook
          '(lambda ()
             (define-key cscope-list-entry-keymap "j" 'evil-next-visual-line)
             (define-key cscope-list-entry-keymap "k" 'evil-previous-visual-line)
             (define-key cscope-list-entry-keymap "q" 'delete-window)
             (define-key cscope-list-entry-keymap "\C-f" 'evil-scroll-page-down)
             (define-key cscope-list-entry-keymap "\C-b" 'evil-scroll-page-up)
             (define-key cscope-list-entry-keymap (kbd "RET") 'cscope-select-entry-other-window)
             (define-key cscope-list-entry-keymap "," 'wf-evil-comma-map)))

(add-hook 'html-mode-hook
          '(lambda ()
             (local-set-key (kbd "C-c o") 'browse-url-at-point)))

(add-hook 'ido-setup-hook
          '(lambda ()
             (define-key ido-completion-map "\M-h" 'ido-prev-match)
             (define-key ido-completion-map "\M-l" 'ido-next-match)
             (define-key ido-completion-map "\C-n" 'ido-toggle-ignore)))

(add-hook 'org-mode-hook
          '(lambda ()
             (define-key org-mode-map "\C-cl" 'org-store-link)))


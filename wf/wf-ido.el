(setq ido-enable-flex-matching t
      ido-everywhere t
      ido-max-directory-size 100000
      ido-file-extensions-order '(".c" ".py" ".el" ".org" ".sh"))
(ido-mode t)
(ido-everywhere t)

(put 'dired-do-rename 'ido nil)  ; since ido-everything doesn't work for me
(put 'dired-do-copy 'ido nil)    ; since ido-everything doesn't work for me

(defun wf-ido-ignore-buf (name)
  (with-current-buffer name (not buffer-file-name)))
(setq ido-ignore-buffers '("^ " wf-ido-ignore-buf))
(dolist (d '("\\`auto" "\\`backups/" "\\`CVS/"))
        (add-to-list 'ido-ignore-directories d))
(dolist (f '("tags" "\\`cscope." "\\.dep$" ".dropbox"))
        (add-to-list 'ido-ignore-files f))

(defun wf-sudo-find-file ()
  "Ido find file as root."
  (interactive)
  (let ((sudo-file-name (ido-read-file-name "Sudo find file: ")))
    (if (string-equal (subseq sudo-file-name 0 6) "/sudo:")
        (find-file sudo-file-name)
      (find-file (concat "/sudo:root@localhost:" sudo-file-name)))))

(defun wf-M-x-ido-select ()
  "Ido M-x mode."
  (interactive)
  (call-interactively
   (intern (ido-completing-read
            "M-x "
            (all-completions "" obarray 'commandp)))))

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
          '(lambda ()
             (define-key artist-mode-map "\C-c\C-o" 'artist-ido-select-operation)
             (define-key artist-mode-map "\C-c\C-s" 'artist-ido-select-settings)))

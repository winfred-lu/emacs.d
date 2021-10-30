(require 'idomenu)

;; electric pair mode
(add-hook 'emacs-lisp-mode-hook 'electric-pair-mode)
(add-hook 'c-mode-common-hook 'electric-pair-mode)
(add-hook 'python-mode-hook 'electric-pair-mode)

;; customized C indentation styles
(defun c-lineup-arglist-tabs-only (ignored)
  "Line up argument lists by tabs, not spaces"
  (let* ((anchor (c-langelem-pos c-syntactic-element))
         (column (c-langelem-2nd-pos c-syntactic-element))
         (offset (- (1+ column) anchor))
         (steps (floor offset c-basic-offset)))
    (* (max steps 1)
       c-basic-offset)))
(c-add-style "linux-tabs"
             '("linux"
               (indent-tabs-mode . t)
               (tab-width . 8)
               (c-offsets-alist
                (arglist-cont-nonempty c-lineup-gcc-asm-reg
                                       c-lineup-arglist-tabs-only))))
(c-add-style "linux-space"
             '("linux"
               (indent-tabs-mode . nil)
               (tab-width . 8)
               (c-offsets-alist
                (arglist-cont-nonempty c-lineup-gcc-asm-reg
                                       c-lineup-arglist-tabs-only))))
(c-add-style "ms-tabs"
             '("stroustrup"
               (indent-tabs-mode . t)
               (tab-width . 4)
               (c-offsets-alist
                (innamespace . -)
                (inline-open . 0)
                (inher-cont . c-lineup-multi-inher)
                (arglist-cont-nonempty . +)
                (template-args-cont . +))))
(c-add-style "ms-space"
             '("stroustrup"
               (indent-tabs-mode . nil)
               (tab-width . 4)
               (c-offsets-alist
                (innamespace . -)
                (inline-open . 0)
                (inher-cont . c-lineup-multi-inher)
                (arglist-cont-nonempty . +)
                (template-args-cont . +))))

;; ido with C indentation styles
(defun wf-ido-select-c-style (style)
  "Use ido to select a C indentation style"
  (interactive
   (list (ido-completing-read
          "C/l indentation style: "
          ;; (list "awk" "bsd" "cc-mode" "ellemtel" "gnu" "java"
          ;;       "k&r" "linux" "python" "stroustrup" "user" "whitesmith"
          ;;       "..."
          (mapcar 'car c-style-alist))))
  (c-set-style style))

;; default style settings
(setq c-default-style '((c-mode . "linux-tabs")
                        (c++-mode . "linux-tabs")
                        (java-mode . "java")
                        (awk . "awk")
                        (python-mode . "python")
                        (other . "bsd"))
      c-basic-offset 8
      c-tab-always-indent nil)

;; quickly compile and run
(defun wf-compile-and-run()
  "Compile and run single c/c++ file."
  (interactive)
  (let* ((src (file-name-nondirectory (buffer-file-name)))
         (exe (file-name-sans-extension src))
         (cmd (if (string= (file-name-extension src) "c") "cc " "c++ ")))
    (compile (concat cmd src " -o " exe " && ./" exe))))

;; misc C settings
(add-hook 'c-mode-common-hook 'turn-on-cwarn-mode)
(add-hook 'c-mode-common-hook
          (lambda ()
            (define-key c-mode-base-map "\C-c." 'wf-ido-select-c-style)
            (modify-syntax-entry ?_ "w" c-mode-syntax-table)
            (modify-syntax-entry ?_ "w" c++-mode-syntax-table)))

(add-to-list 'auto-mode-alist '("\\.\\(pde\\|ino\\)\\'" . c++-mode))

(autoload 'csharp-mode "csharp-mode" "Major mode for editing C# code." t)
(add-to-list 'auto-mode-alist '("\\.[cC][sS]\\'" . csharp-mode))

;; INF, _defconfig files
(add-to-list 'auto-mode-alist '("\\.[iI][nN][fFxX]\\'" . conf-mode))
(add-to-list 'auto-mode-alist '("_defconfig\\'" . conf-mode))

;; Batch scripts
(autoload 'dos-mode "dos" "Edit Dos scripts." t)
(add-to-list 'auto-mode-alist '("\\.[bB][aA][tT]\\'" . dos-mode))


;; settings for Python programming
(add-hook 'python-mode-hook
          (lambda ()
            (modify-syntax-entry ?_ "w" py-mode-syntax-table)))

;(require 'ipython)
;(setq python-python-command "ipython"
;      ipython-command "/usr/bin/ipython"
;      py-python-command-args '("--colors=Linux"))

(autoload 'python-mode "python-mode" "Python Mode." t)
(add-to-list 'auto-mode-alist '("\\.py\\'" . python-mode))
(add-to-list 'interpreter-mode-alist '("python" . python-mode))

(autoload 'pymacs-apply "pymacs")
(autoload 'pymacs-call "pymacs")
(autoload 'pymacs-eval "pymacs" nil t)
(autoload 'pymacs-exec "pymacs" nil t)
(autoload 'pymacs-load "pymacs" nil t)
;(pymacs-load "ropemacs" "rope-")
;(setq ropemacs-enable-autoimport t)

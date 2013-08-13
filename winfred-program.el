(require 'idomenu)

;; customized C indentation styles
(defun c-lineup-arglist-tabs-only (ignored)
  "Line up argument lists by tabs, not spaces"
  (let* ((anchor (c-langelem-pos c-syntactic-element))
         (column (c-langelem-2nd-pos c-syntactic-element))
         (offset (- (1+ column) anchor))
         (steps (floor offset c-basic-offset)))
    (* (max steps 1)
       c-basic-offset)))
(c-add-style "linux-kernel"
             '("linux"
               (indent-tabs-mode t)
               (c-offsets-alist
                (arglist-cont-nonempty c-lineup-gcc-asm-reg
                                       c-lineup-arglist-tabs-only))))
(c-add-style "microsoft"
             '("stroustrup"
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
          ;;       "linux-kernel" "microsoft")
          (append
           (mapcar 'car c-style-alist)
           (list "linux-kernel" "microsoft"))
          )))
  (c-set-style style))

;; default style settings
(setq c-default-style '((c-mode . "linux-kernel")
                        (c++-mode . "linux-kernel")
                        (java-mode . "java")
                        (awk . "awk")
                        (python-mode . "python")
                        (other . "bsd"))
      c-basic-offset 8
      c-tab-always-indent nil)

;; misc C settings
(add-hook 'c-mode-common-hook 'turn-on-cwarn-mode)
(add-hook 'c-mode-common-hook
          (lambda ()
            (define-key c-mode-base-map "\C-c." 'wf-ido-select-c-style)
            (modify-syntax-entry ?_ "w" c-mode-syntax-table)
            (modify-syntax-entry ?_ "w" c++-mode-syntax-table)))

(autoload 'csharp-mode "csharp-mode" "Major mode for editing C# code." t)
(add-to-list 'auto-mode-alist '("\\.cs$" . csharp-mode))

;; INF files
(add-to-list 'auto-mode-alist '("\\.[iI][nN][fFxX]\\'" . conf-mode))

;; Batch scripts
(autoload 'dos-mode "dos" "Edit Dos scripts." t)
(add-to-list 'auto-mode-alist '("\\.bat$" . dos-mode))


;; settings for Python programming
(add-hook 'python-mode-hook
          (lambda ()
            (modify-syntax-entry ?_ "w" py-mode-syntax-table)))

(require 'ipython)
(setq python-python-command "ipython"
      ipython-command "/usr/bin/ipython"
      py-python-command-args '("--colors=Linux"))

(autoload 'python-mode "python-mode" "Python Mode." t)
(add-to-list 'auto-mode-alist '("\\.py\\'" . python-mode))
(add-to-list 'interpreter-mode-alist '("python" . python-mode))

(autoload 'pymacs-apply "pymacs")
(autoload 'pymacs-call "pymacs")
(autoload 'pymacs-eval "pymacs" nil t)
(autoload 'pymacs-exec "pymacs" nil t)
(autoload 'pymacs-load "pymacs" nil t)
(pymacs-load "ropemacs" "rope-")
(setq ropemacs-enable-autoimport t)

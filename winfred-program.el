(require 'idomenu)

;; settings for C programming
;;   note: c-set-style, set-var c-basic-offset, set-var indent-tabs-mode
;;         set-var tab-width
(setq c-default-style '((c-mode . "linux")
                        (java-mode . "java")
                        (python-mode . "python")
                        (other . "gnu"))
      c-basic-offset 8
      c-tab-always-indent nil)
(add-hook 'c-mode-common-hook 'turn-on-cwarn-mode)
(add-hook 'c-mode-common-hook
          (lambda ()
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

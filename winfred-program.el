;(setq indent-tabs-mode nil)
;(set-default 'tab-width 8)

;; settings for C programming (c-set-style, set-variable c-basic-offset)
(setq c-default-style '((c-mode . "linux")
                        (java-mode . "java")
                        (python-mode . "python")
                        (other . "gnu"))
      c-basic-offset 8
      c-tab-always-indent nil)
(add-hook 'c-mode-common-hook 'turn-on-cwarn-mode)

(autoload 'csharp-mode "csharp-mode" "Major mode for editing C# code." t)
(setq auto-mode-alist
      (append '(("\\.cs$" . csharp-mode)) auto-mode-alist))

;; smart-tab
(use-package smart-tab-mode
  :init
  (add-to-list 'hippie-expand-try-functions-list
               'yas/hippie-try-expand) ;put yasnippet in hippie-expansion list
  (setq smart-tab-using-hippie-expand t)
  :config
  (global-smart-tab-mode 1))

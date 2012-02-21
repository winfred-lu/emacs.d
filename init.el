;; Winfred's Emacs Enrionment

(add-to-list 'load-path "~/.emacs.d")
;Add all top-level subdirectories of .emacs.d to the load path
(progn (cd "~/.emacs.d")
       (normal-top-level-add-subdirs-to-load-path))
;Keep third party libraries seperate in ~/.emacs.d/vendor
(add-to-list 'load-path "~/.emacs.d/vendor")
(progn (cd "~/.emacs.d/vendor")
       (normal-top-level-add-subdirs-to-load-path))

(load-library "winfred-visual")
(load-library "winfred-evil")
(load-library "winfred-buffer")
(load-library "winfred-misc")
(load-library "winfred-yasnippet")
(load-library "winfred-tabs")
(require 'egg)
(load-library "winfred-keys")
(load-library "winfred-cc-mode")
(load-library "winfred-org")
(require 'magit)
(require 'xcscope)

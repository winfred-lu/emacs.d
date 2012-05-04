;; Winfred's Emacs Enrionment

(add-to-list 'load-path "~/.emacs.d")
(progn (cd "~/.emacs.d")
       (normal-top-level-add-subdirs-to-load-path))
;; Keep third party libraries seperate in ~/.emacs.d/vendor
(add-to-list 'load-path "~/.emacs.d/vendor")
(progn (cd "~/.emacs.d/vendor")
       (normal-top-level-add-subdirs-to-load-path))

;; Use ELPA (emacs 24.x)
(if (>= emacs-major-version 24)
    (progn (require 'package)
           (package-initialize)
           (setq package-archives '(("ELPA" . "http://tromey.com/elpa/")
                                    ("gnu" . "http://elpa.gnu.org/packages/")))))

(load-library "winfred-visual")
(load-library "winfred-evil")
(load-library "winfred-buffer")
(load-library "winfred-misc")
(load-library "winfred-keys")
(load-library "winfred-cc-mode")
(load-library "winfred-org")
(require 'etags-select)
(require 'magit)
(require 'xcscope)

;; Winfred's Emacs Enrionment

;; Configure the load path
(add-to-list 'load-path user-emacs-directory)
(let ((default-directory (concat user-emacs-directory
                                 (convert-standard-filename "vendor/"))))
  (normal-top-level-add-to-load-path '("."))
  (normal-top-level-add-subdirs-to-load-path))

;; Use ELPA (emacs 24.x)
;; (if (>= emacs-major-version 24)
;;     (progn (require 'package)
;; 	   (package-initialize)
;; 	   (setq package-archives
;; 		 '(("ELPA" . "http://tromey.com/elpa/")
;; 		   ("gnu" . "http://elpa.gnu.org/packages/")
;; 		   ("marmalade" . "http://marmalade-repo.org/packages/")))))

(load-library "winfred-visual")
(load-library "winfred-evil")
(load-library "winfred-buffer")
(load-library "winfred-misc")
(load-library "winfred-keys")
(load-library "winfred-program")
(load-library "winfred-org")
(require 'etags-select)
(require 'magit)
(require 'xcscope)


;; Winfred's Emacs Enrionment

;; Configure the load path
(add-to-list 'load-path (concat user-emacs-directory "wf"))
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

(load-library "wf-visual")
(load-library "wf-evil")
(load-library "wf-buffer")
(load-library "wf-misc")
(load-library "wf-keys")
(load-library "wf-program")
(load-library "wf-org")

(require 'etags-select)
(require 'magit)
(require 'xcscope)

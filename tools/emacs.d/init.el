;;; init.el --- Entry point of GNU/Emacs configuration
;;; First edit date 2025/01/27

;;; Organised by such directory structure
;;; init.el -- This file, entry point
;;; lisp/
;;;      init-basic.el
;;;      init-keymaps.el
;;;      init-package.el
;;;      init-evil.el
;;; custom.el -- Auto Generated

;; All elisp files under emacs.d/lisp will be loaded
(add-to-list 'load-path (expand-file-name "lisp" user-emacs-directory))

;; Store the auto-generated custom config to `custom.el`
(setq custom-file (expand-file-name ".custom.el" user-emacs-directory))


(defvar xdg-data-home
  (or (getenv "XDG_DATA_HOME")
      (expand-file-name "~/.local/share")))

(defvar xdg-cache-home
  (or (getenv "XDG_CACHE_HOME")
      (expand-file-name "~/.local/cache")))

(defvar user-emacs-data (expand-file-name "emacs" xdg-data-home))
(defvar user-emacs-cache (expand-file-name "emacs" xdg-cache-home))

;; Load each modules
(require 'init-package) ; package manager should be loaded first
(require 'init-basic)
(require 'init-appearance) ; package manager should be loaded first
(require 'init-keymaps)
(require 'init-evil)
(require 'init-file)
(require 'init-edit)
(require 'init-org)
;; (require 'init-lsp) ; FIXME: See .emacs.d/lisp/init-lsp.el

;; Load `custom` file
(when (file-exists-p custom-file)
  (load custom-file))


;;; init.el end


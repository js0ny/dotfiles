;;; init.el --- Entry point of GNU/Emacs configuration
;;; First edit date 2025/01/27

;;; Organised by such directory structure
;;; init.el -- This file, entry point
;;; lisp/
;;;      init-*.el
;;; custom.el -- Auto Generated
;;; local.el -- Local variables

;; All elisp files under emacs.d/lisp will be loaded
(add-to-list 'load-path (expand-file-name "lisp" user-emacs-directory))

;; Store the auto-generated custom config to `custom.el`
(setq custom-file (expand-file-name ".custom.el" user-emacs-directory))


(defvar xdg-data-home
  (or (getenv "XDG_DATA_HOME")
      (expand-file-name "~/.local/share")))

(defvar xdg-cache-home
  (or (getenv "XDG_CACHE_HOME")
      (expand-file-name "~/.cache")))

(defvar xdg-state-home
  (or (getenv "XDG_STATE_HOME")
      (expand-file-name "~/.local/state/")))

(defvar user-emacs-data (expand-file-name "emacs" xdg-data-home))
(defvar user-emacs-cache (expand-file-name "emacs" xdg-cache-home))
(defvar user-emacs-state (expand-file-name "emacs" xdg-state-home))

;; Load each modules
(require 'init-package) ; package manager should be loaded first
(require 'init-basic)
(require 'init-appearance)
(require 'init-wayland)
(require 'init-keymaps)
(require 'init-evil)
(require 'init-counsel)
(require 'init-file)
(require 'init-edit)
(require 'init-calendar)
(require 'init-writer)
(require 'init-org)
(require 'init-markdown)
(require 'init-latex)
(require 'init-beancount)
(require 'init-treesitter)
(require 'init-scratch)
(require 'init-ai)


;; Load `custom` file
(when (file-exists-p custom-file)
  (load custom-file))


(when (file-exists-p (expand-file-name "local.el" user-emacs-directory))
  (load (expand-file-name "local.el" user-emacs-directory)))



;;; init.el end

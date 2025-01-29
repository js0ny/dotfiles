;;; init-basic.el

;; Disable startup message
(setq inhibit-startup-message t)

;; Use line number by default
(global-display-line-numbers-mode 1)
;; Vim-like relativenumber
(setq display-line-numbers-type 'relative)

;; Auto input pairred brackets
(electric-pair-mode 1)

;; https://book.emacs-china.org/#orgcfd105e Open with Emacs
(server-mode 1)

(when (display-graphic-p)
  (add-to-list 'default-frame-alist '(font . "JetBrainsMono NF")))

(use-package catppuccin-theme
  :config
  (setq catppuccin-flavor 'mocha) ; This looks like shit in terminal mode
  (load-theme 'catppuccin t))

(require 'recentf)
(recentf-mode 1)

;; Disable toobar and scrollbar
(tool-bar-mode -1)
(scroll-bar-mode -1)


;; Export module
(provide 'init-basic)

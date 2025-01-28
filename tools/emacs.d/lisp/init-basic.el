;;; init-basic.el

;; Disable startup message
(setq inhibit-startup-message t)

;; Use line number by default
(global-display-line-numbers-mode 1)
;; Vim-like relativenumber
(setq display-line-numbers-type 'relative)

;; https://book.emacs-china.org/#orgcfd105e Open with Emacs
(server-mode 1)

;; Export module
(provide 'init-basic)

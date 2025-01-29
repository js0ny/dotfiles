;;; init-lsp.el
;;; First edit on 2025/01/29
;;; Stores Language Server Protocol Configs
;;; FIXME: Cannot install `lsp-mode` plugin, this file will not be loaded by Emacs for now

(use-package lsp-mode
  :commands (lsp lsp-deferred)
  :hook (prog-mode . lsp-deferred))


;; (setq package-check-signature t)
(provide 'init-lsp)
;;; init-lsp.el ends

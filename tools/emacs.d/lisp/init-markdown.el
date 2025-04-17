(use-package yaml-mode :straight t)

(use-package markdown-mode
  :mode ("\\.md\\'" . markdown-mode)
  :init
  (setq markdown-fontify-code-blokcs-natively t)
  :custom
  (setq markdown-fontify-code-block-natively t)
  :hook ((markdown-mode . visual-line-mode)))

(provide 'init-markdown)
;;; init-markdown.el ends

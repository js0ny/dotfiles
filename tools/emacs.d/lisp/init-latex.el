
(use-package texfrag
  ;; :init
  ;; (texfrag-global-mode)
  :config
  (evil-define-key 'normal texfrag-mode-map
    (kbd "zL") #'texfrag-document)
  :hook (markdown-mode . texfrag-mode))

(provide 'init-latex)
;;; init-latex.el ends

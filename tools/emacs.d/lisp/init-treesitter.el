;;; init-treesitter.el tree-sitter integration for emacs
;;; Reference: https://emacs.liujiacai.net/post/038-hello-treesitter/
;;; Download: https://github.com/emacs-tree-sitter/tree-sitter-langs/releases/tag/0.12.268


(add-to-list 'treesit-extra-load-path (expand-file-name "tree-sitter" user-emacs-data))

(setq major-mode-remap-alist
      '((yaml-mode . yaml-ts-mode)
        (sh-mode . bash-ts-mode)
        (js-mode . js-ts-mode)
        (css-mode . css-ts-mode)
        (c-mode . c-ts-mode)
        (c++-mode . c++-ts-mode)
        (c-or-c++-mode . c-or-c++-ts-mode)
        (python-mode . python-ts-mode)
        (js-json-mode . json-ts-mode)))


(provide 'init-treesitter)

;;; init-keymaps.el

;; Once this is defined, `M-x open-init-file` will open this file
(defun open-org-config()
  (interactive) ;; Mark function as `interactive` that allows user to access by M-x open-init-file RET
  (find-file  "~/.dotfiles/tools/emacs.d/lisp/init-org.el"))

(provide 'init-keymaps)

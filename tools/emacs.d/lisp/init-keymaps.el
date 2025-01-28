;;; init-keymaps.el

;; Once this is defined, `M-x open-init-file` will open this file
(defun open-init-file()
  (interactive) ;; Mark function as `interactive` that allows user to access by M-x open-init-file RET
  (find-file  "~/.emacs.d/init.el"))
(defun reload-init()
  (interactive) 
  (load-file "~/.emacs.d/init.el"))

(provide 'init-keymaps)

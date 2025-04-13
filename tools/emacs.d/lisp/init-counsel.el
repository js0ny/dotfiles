;;; init-counsel.el
(defun js0ny/open-config-directory ()
  "Open `user-emacs-directory` using `counsel-find-file`."
  (interactive)
  (let ((default-directory user-emacs-directory))
    (counsel-find-file)))


(use-package counsel
  :demand t
  :init
  (counsel-mode 1)
  :config
  (global-set-key (kbd "C-x C-f") #'counsel-find-file)
  (global-set-key (kbd "M-x") #'counsel-M-x)
  (evil-leader/set-key
    "SPC" #'counsel-file-jump
    "/" #'counsel-rg
    ";" #'counsel-M-x
    "fc" #'js0ny/open-config-directory
    )
  )

(provide 'init-counsel)

;;; init-counsel.el ends

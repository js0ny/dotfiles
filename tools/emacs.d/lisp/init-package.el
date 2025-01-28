;;; init-package.el

;; Manual Install Packages (plugins): Options > Manage Emacs Packages (Don't use this)

(global-company-mode 1) ; Enable company

;; Ensure use-package is installed (use-package: lazy load plugin manager)
(unless (package-install 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

;; Plugins Here
;; Company - Complete Anything
(use-package company
  :ensure t
  :config
  (global-company-mode 1)
  (define-key company-active-map (kbd "C-n") 'company-select-next)
  (define-key company-active-map (kbd "C-p") 'company-select-previous))


(provide 'init-package)

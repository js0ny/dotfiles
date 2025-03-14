;;; init-package.el --- Package management setup using straight.el -*- lexical-binding: t -*-

(setq straight-base-dir (expand-file-name "straight" user-emacs-data))

;; Bootstrap straight.el
(defvar bootstrap-version)
(let ((bootstrap-file
       (expand-file-name
        "straight/repos/straight.el/bootstrap.el"
        (or (bound-and-true-p straight-base-dir)
            user-emacs-directory)))
      (bootstrap-version 7))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
        (url-retrieve-synchronously
         "https://raw.githubusercontent.com/radian-software/straight.el/develop/install.el"
         'silent 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))

;; Use straight.el with use-package
(straight-use-package 'use-package)
(setq straight-use-package-by-default t)  ;; Automatically use straight for all packages

;; Ensure gnu-elpa-keyring-update (equivalent to your previous keyring update logic)
(use-package gnu-elpa-keyring-update)


;; Which Key - Prompt available commands
(use-package which-key
  :ensure t
  :init
  (which-key-mode)
  :config
  (setq which-key-idle-delay 0.3))

;; Dashboard
(use-package dashboard
  ;; Open with :dashboard-open<CR>
  :after evil
  :bind (:map dashboard-mode-map
         ;; Navigation
         ("n" . dashboard-next-line)
         ("e" . dashboard-previous-line)
         ;; Buffer switching
         ("H" . previous-buffer)
         ("I" . next-buffer))
  :config
  (dashboard-setup-startup-hook)
  (setq dashboard-center-content t)
  ;; Use Emacs mode to use number to navigate dashboard
  )


(use-package wakatime-mode
  :ensure t
  :config
  (global-wakatime-mode))


(provide 'init-package)
;;; init-package.el ends here

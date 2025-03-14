;;; init-package.el

;; Initialise the package sources
(require 'package)
; Add sources
;; (setq gnutls-algorithm-priority "NORMAL:-VERS-TLS1.3")
(setq package-archives '(("melpa" . "https://melpa.org/packages/")
			 ("org" . "https://orgmode.org/elpa/")
			 ("gnu" . "https://elpa.gnu.org/packages/")))
;; Initialise the package management system
(package-initialize)

;; Ensure the package list is up-to-date
(unless package-archive-contents
  (package-refresh-contents))

;; Ensure use-package is installed
(unless (package-installed-p 'use-package)
; (package-refresh-contents) Move to above
  (package-install 'use-package))

;; Use `use-package` for plugin management
(eval-when-compile
  (require 'use-package))
(setq use-package-always-ensure t)

;; use-package offers many syntax sugar.
;; :bind -> bindkeys
;; :config -> `(progn do sth)
;; :init -> (progn do sth)
;; :after -> (when (featurep 'package)do sth)
;; :hook -> (add-hook 'some-hook #'some-mode)

;; This part initialse the GPG Keyring
; Disable signature first
(setq package-check-signature nil)

(use-package gnu-elpa-keyring-update)

; Re-enable signature
(setq package-check-signature 'allow-unsigned)


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

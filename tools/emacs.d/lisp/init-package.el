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

;; This part initialse the GPG Keyring
; Disable signature first
(setq package-check-signature nil)

(use-package gnu-elpa-keyring-update)

; Re-enable signature
(setq package-check-signature 'allow-unsigned)

;; Company - Complete Anything
(use-package company
  :ensure t
  :hook (after-init . global-company-mode) ; 在启动后自动启用 global-company-mode
  :bind (:map company-active-map           ; TODO: Seems does not work
	      ("C-n" . company-select-next)
	      ("C-p" . company-select-previous))
  :config
  (setq company-minimum-prefix-length 1   ; 设置最短补全前缀
        company-idle-delay 0.2))          ; 设置补全延迟（秒）

;; Which Key - Prompt available commands
(use-package which-key
  :ensure t
  :init
  (which-key-mode)
  :config
  (setq which-key-idle-delay 0.3))

;; Dashboard
(use-package dashboard
  ; Open with :dashboard-open<CR>
  :after evil
  :config
  (dashboard-setup-startup-hook)
  ; Use Emacs mode to use number to navigate dashboard
  (evil-set-initial-state 'dashboard-mode 'emacs)
  )
;(use-package dashboard
;  :ensure t
;  :init
;  (dashboard-setup-startup-hook)
;  :config
;  (setq dashboard-banner-logo-title "EMACS")
;  (setq dashboard-startup-banner 'official)
;  (setq dashboard-center-content t)
;  (setq dashboard-items '((recents . 5)
;			  (bookmark . 5))))
;


(provide 'init-package)
;;; init-package.el ends here

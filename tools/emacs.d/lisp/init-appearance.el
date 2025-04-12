;;; init-appearance.el

(when (display-graphic-p)
  (add-to-list 'default-frame-alist '(font . "Maple Mono NF CN")))

;; Set CJK Display Font
(dolist (charset '(kana han cjk-misc bopomofo))
  (set-fontset-font t charset (font-spec :family "Maple Mono NF CN")))

;; Icon Support
;; Once installed, Manually install the fonts required:
;; M-x all-the-icons-install-fonts
;; If under Microsoft Windows, the Installation Directory should be chosen
;; and right-click them to install the fonts
(use-package all-the-icons
  :if (display-graphic-p))


(use-package catppuccin-theme
  :config
  (setq catppuccin-flavor 'mocha) ; This looks like shit in terminal mode
  ;; (load-theme 'catppuccin t)
  )

(use-package doom-themes
  :ensure t
  :config
  ;; Global settings (defaults)
  (setq doom-themes-enable-bold t    ; if nil, bold is universally disabled
        doom-themes-enable-italic t) ; if nil, italics is universally disabled
  (load-theme 'doom-nord-aurora t)

  ;; Enable flashing mode-line on errors
  (doom-themes-visual-bell-config)

  ;; Enable custom neotree theme (nerd-icons must be installed!)
  ;; (doom-themes-neotree-config)

  ;; or for treemacs users
  (setq doom-themes-treemacs-theme "doom-nord-aurora") ; use "doom-colors" for less minimal icon theme
  (doom-themes-treemacs-config)
  ;; Corrects (and improves) org-mode's native fontification.
  (doom-themes-org-config))


;; Better mode line, see (L11) for Icon install
;; M-x nerd-icons-install-fonts
(use-package doom-modeline
  :ensure t
  :init (doom-modeline-mode 1))

(global-tab-line-mode) ; bufferline



(provide 'init-appearance)

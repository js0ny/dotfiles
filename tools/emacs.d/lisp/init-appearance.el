;;; init-appearance.el

;; Always set frame font
;; If don't set this, `emacs --daemon' will not set the font
;; for new graphical frames.
(add-to-list 'default-frame-alist '(font . "Maple Mono NF CN"))

;; Set CJK Display Font
(dolist (charset '(kana han cjk-misc bopomofo))
  (set-fontset-font t charset (font-spec :family "Maple Mono NF CN")))


;; Variable Pitch Font
;; Used in `variable-pitch-mode'
(set-face-attribute 'variable-pitch nil
                    :family "LXGW WenKai Screen"
                    :height 140            
                    :weight 'regular)


;; Icon Support
;; Once installed, Manually install the fonts required:
;; M-x all-the-icons-install-fonts
;; If under Microsoft Windows, the Installation Directory should be chosen
;; and right-click them to install the fonts
(use-package all-the-icons
  :if (display-graphic-p))


(defun js0ny/get-system-theme ()
  " Get the current system theme. Returns 'light' or 'dark'."
  ;; Default
  (let ((background 'dark))
    (if (string= system-type "darwin")
        (progn
          ;; Check if 'defaults' command is available
          (when (executable-find "defaults")
            ;; Check if the system is in dark mode
            (let ((apple-interface-style
                   (shell-command-to-string "defaults read -g AppleInterfaceStyle")))
              (when (string-match-p "Light" apple-interface-style)
                (setq background 'light)))))
      ;; Using systemd to check the current theme
      (when (executable-find "busctl")
        (let ((result
               (shell-command-to-string
                (concat "busctl --user call org.freedesktop.portal.Desktop "
                        "/org/freedesktop/portal/desktop "
                        "org.freedesktop.portal.Settings ReadOne ss "
                        "org.freedesktop.appearance color-scheme"))))
          ;; 结果格式为浅色模式是 "v u 0"，暗色模式是 "v u 1"
          ;; v u 0 -> light, v u 1 -> dark
          (when (string-match "u\\s+\\([0-9]\\)" result)
            (let ((color-scheme (match-string 1 result)))
              (when (string= color-scheme "0")
                (setq background 'light)))))))
    background))

(use-package catppuccin-theme
  :custom
  (catppuccin-flavor 'mocha)
  :config
  (if (string-equal (js0ny/get-system-theme) "light")
    (setq catppuccin-flavor 'latte)
    (setq catppuccin-flavor 'mocha))
  (load-theme 'catppuccin t))



;; (use-package doom-themes
;;   :ensure t
;;   :config
;;   ;; Global settings (defaults)
;;   :custom
;;   (doom-themes-enable-bold t)    ; if nil, bold is universally disabled
;;   (doom-themes-enable-italic t) ; if nil, italics is universally disabled
;;   ; (doom-themes-treemacs-theme "doom-nord-aurora") ; use "doom-colors" for less minimal icon theme
;;   :config
;;   (load-theme 'doom-nord-aurora t)

;;   ;; Enable flashing mode-line on errors
;;   (doom-themes-visual-bell-config)

;;   ;; Enable custom neotree theme (nerd-icons must be installed!)
;;   ;; (doom-themes-neotree-config)

;;   ;; or for treemacs users
;;   (doom-themes-treemacs-config)
;;   ;; Corrects (and improves) org-mode's native fontification.
;;   (doom-themes-org-config))


;; Better mode line, see (L11) for Icon install
;; M-x nerd-icons-install-fonts
(use-package doom-modeline
  :ensure t
  :init (doom-modeline-mode 1))

(global-tab-line-mode) ; bufferline

(use-package highlight-indent-guides
  :hook ((prog-mode yaml-mode org-mode) . highlight-indent-guides-mode)
  :init
  (setq highlight-indent-guides-method 'column)
  (setq highlight-indent-guides-responsive 'top)
  (setq highlight-indent-guides-auto-character-face-perc 5))



(provide 'init-appearance)

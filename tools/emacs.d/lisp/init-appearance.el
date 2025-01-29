;;; init-appearance.el

;; Set Font - JetBrains Mono Nerd Font
(when (display-graphic-p)
  (add-to-list 'default-frame-alist '(font . "JetBrainsMono NF")))

;; Set CJK Display Font - LXGW Wenkai Mono
(dolist (charset '(kana han cjk-misc bopomofo)) 
  (set-fontset-font t charset (font-spec :family "霞鹜文楷等宽"))) 

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
  (load-theme 'catppuccin t))


;; Better mode line, see (L7) Icon install
;; M-x nerd-icons-install-fonts
(use-package doom-modeline
  :ensure t
  :init (doom-modeline-mode 1))

(global-tab-line-mode) ; bufferline

(provide 'init-appearance)

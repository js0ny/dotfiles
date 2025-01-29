;;; init-edit.el

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

;; minibuffer 补全增强
(use-package vertico
  :init
  (vertico-mode))

;; 提供补全注解
(use-package marginalia
  :init
  (marginalia-mode))

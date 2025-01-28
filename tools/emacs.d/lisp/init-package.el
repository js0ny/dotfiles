;;; init-package.el

;; Ensure use-package is installed
(unless (package-installed-p 'use-package) ; 修正条件检查
  (package-refresh-contents)
  (package-install 'use-package))

;; Use `use-package` for plugin management
(eval-when-compile
  (require 'use-package))

;; Company - Complete Anything
(use-package company
  :ensure t
  :hook (after-init . global-company-mode) ; 在启动后自动启用 global-company-mode
  :bind (:map company-active-map           ; 自定义快捷键
              ("C-n" . company-select-next)
              ("C-p" . company-select-previous))
  :config
  (setq company-minimum-prefix-length 1   ; 设置最短补全前缀
        company-idle-delay 0.2))          ; 设置补全延迟（秒）

(provide 'init-package)
;;; init-package.el ends here

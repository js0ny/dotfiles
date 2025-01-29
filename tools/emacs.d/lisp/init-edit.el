;;; init-edit.el

;; Use UTF-8 & LF
(setq-default buffer-file-coding-system 'utf-8-unix)

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


;;; 设置语言环境为 UTF-8
;(set-language-environment "UTF-8")
;
;;; 强制使用 UTF-8
;(prefer-coding-system 'utf-8)
;(set-default-coding-systems 'utf-8)
;(set-terminal-coding-system 'utf-8)
;(set-keyboard-coding-system 'utf-8)
;
;;; Windows 系统特殊设置
;(when (eq system-type 'windows-nt)
;  (set-file-name-coding-system 'gbk)        ;; 文件名使用 GBK
;  (set-clipboard-coding-system 'utf-16le))  ;; 剪贴板使用 UTF-16LE
;
;(setq-default buffer-file-coding-system 'utf-8-unix)
;
;;; 设置行尾为 Unix 风格
;(add-hook 'find-file-hook 'find-file-check-line-endings)
;
;(defun dos-file-endings-p ()
;  (string-match "dos" (symbol-name buffer-file-coding-system)))
;
;(defun find-file-check-line-endings ()
;  (when (dos-file-endings-p)
;    (set-buffer-file-coding-system 'undecided-unix)
;    (set-buffer-modified-p nil)))

(setq-default buffer-file-coding-system 'utf-8-unix)

(provide 'init-edit)

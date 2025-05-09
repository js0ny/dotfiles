;;; init-basic.el

;; Disable startup message
(setq inhibit-startup-message t)

;; Use line number by default
(global-display-line-numbers-mode 1)
;; Vim-like relativenumber
;; fix: work for folded region (visual relative line instead of physical)
(use-package display-line-numbers
  :custom
  (display-line-numbers-type 'visual)
  (display-line-numbers-current-absolute t)
  :hook
  (prog-mode . display-line-numbers-mode))

(when (eq system-type 'darwin)
  (setq mac-option-modifier 'meta)
  (setq mac-command-modifier 'super))


;; https://book.emacs-china.org/#orgcfd105e Open with Emacs
;; (server-mode 1)

(setq use-short-answers t)

(require 'recentf)
(setq recentf-save-file (expand-file-name "recentf" user-emacs-data))
(recentf-mode 1)

;; Disable topbars
(tool-bar-mode -1)
(scroll-bar-mode -1)
(menu-bar-mode -1)

(use-package alert
  :commands (alert)
  :config
  (setq alert-default-style 'libnotify))

;; 设置 Emacs 备份和自动保存目录
(defvar user-backup-directory (expand-file-name "backups" user-emacs-data))
(defvar user-autosaves-directory (expand-file-name "autosaves" user-emacs-cache))

;; 创建目录（如果不存在）
(dolist (dir (list user-backup-directory user-autosaves-directory))
  (unless (file-exists-p dir)
    (make-directory dir t)
    (message "Creating directory: %s" dir)))

;; 配置备份文件目录
(setq backup-directory-alist `(("." . ,user-backup-directory)))

(setq project-list-file (expand-file-name "projects-list" user-emacs-data))

;; 配置自动保存文件目录
(setq auto-save-file-name-transforms
      `((".*" ,user-autosaves-directory t)))

;; 配置自动保存列表文件前缀
(setq auto-save-list-file-prefix
      (expand-file-name "auto-save-list/.saves-" user-autosaves-directory))

;; TRAMP 远程文件的备份设置
(setq tramp-backup-directory-alist (copy-tree backup-directory-alist))
(setq tramp-persistency-file-name (expand-file-name "tramp" user-emacs-state))


;; 备份设置（可选）
(setq backup-by-copying t      ; 使用复制而非重命名
      delete-old-versions t    ; 自动删除旧版本
      kept-new-versions 6      ; 保留的新版本数量
      kept-old-versions 2      ; 保留的旧版本数量
      version-control t)       ; 使用版本号

(setq transient-history-file (expand-file-name "transient/history.el" user-emacs-data))
(setq transient-values-file (expand-file-name "transient/values.el" user-emacs-data))
(setq transient-levels-file (expand-file-name "transient/levels.el" user-emacs-data))

;; Export module
(provide 'init-basic)

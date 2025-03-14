;;; init-basic.el

;; Disable startup message
(setq inhibit-startup-message t)

;; Use line number by default
(global-display-line-numbers-mode 1)
;; Vim-like relativenumber
;; fix: work for folded region (visual relative line instead of physical)
(use-package display-line-numbers
  :config
  (setq display-line-numbers-type 'visual)
  (setq display-line-numbers-current-absolute t)
  :hook
  (prog-mode . display-line-numbers-mode))

(defvar xdg-data-home
  (or (getenv "XDG_DATA_HOME")
      (expand-file-name "~/.local/share")))

(defvar xdg-cache-home
  (or (getenv "XDG_CACHE_HOME")
      (expand-file-name "~/.local/cache")))

(defvar user-emacs-data (expand-file-name "emacs" xdg-data-home))
(defvar user-emacs-cache (expand-file-name "emacs" xdg-cache-home))


;; https://book.emacs-china.org/#orgcfd105e Open with Emacs
;; (server-mode 1)


(require 'recentf)
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

(when (boundp 'project-list-file)
  (setq project-list-file (expand-file-name "projects-list" user-emacs-data)))

;; 配置自动保存文件目录
(setq auto-save-file-name-transforms
      `((".*" ,user-autosaves-directory t)))

;; 配置自动保存列表文件前缀
(setq auto-save-list-file-prefix
      (expand-file-name "auto-save-list/.saves-" user-autosaves-directory))

;; TRAMP 远程文件的备份设置
(setq tramp-backup-directory-alist (copy-tree backup-directory-alist))


;; 备份设置（可选）
(setq backup-by-copying t      ; 使用复制而非重命名
      delete-old-versions t    ; 自动删除旧版本
      kept-new-versions 6      ; 保留的新版本数量
      kept-old-versions 2      ; 保留的旧版本数量
      version-control t)       ; 使用版本号


;; Export module
(provide 'init-basic)

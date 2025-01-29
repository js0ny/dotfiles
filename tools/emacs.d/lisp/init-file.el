;;; init-file.el -- File Management configuration
;;; First edit at 2025/01/29

;; Dired

;; Dired Configuration
(with-eval-after-load 'dired
  (setq dired-recursive-deletes 'top) ;; Ask Before Delete Dir
  (setq dired-recursive-copies 'always) ;; Always Copy Dir
  (setq dired-dwim-target t)) ;; dwim for Do What I Mean - 当分屏显示两个 Buffer 时，复制或移动文件会自动将另一个 dired buffer 作为目标目录

;; Dired Keybindings - Colemak
(evil-define-key 'normal dired-mode-map
  "h" 'dired-up-directory
  "i" 'dired-find-file
  "n" 'dired-next-line
  "e" 'dired-previous-line)

;; This prevents Dired from opening more buffers
;; https://stackoverflow.com/q/1839313
(setq dired-kill-when-opening-new-dired-buffer t)

;; Treemacs - Sidebar File Tree
(use-package treemacs
    :ensure t
    :defer t
    :init
    (with-eval-after-load 'winum
        (define-key winum-keymap (kbd "M-0") #'treemacs-select-window))
    :bind
    (:map global-map
            ("M-0"       . treemacs-select-window)
            ("C-x t 1"   . treemacs-delete-other-windows)
            ("C-x t t"   . treemacs)
            ("C-x t d"   . treemacs-select-directory)
            ("C-x t B"   . treemacs-bookmark)
            ("C-x t C-t" . treemacs-find-file)
            ("C-x t M-t" . treemacs-find-tag)
            )
    )

(use-package treemacs-evil
  :after (treemacs evil)
  :ensure t
  :config
  ;; Evil treemacs state bindings
  (define-key evil-treemacs-state-map (kbd "n") #'treemacs-next-line)
  (define-key evil-treemacs-state-map (kbd "e") #'treemacs-previous-line)
  (define-key evil-treemacs-state-map (kbd "N") #'treemacs-next-neighbour)
  (define-key evil-treemacs-state-map (kbd "E") #'treemacs-previous-neighbour)
  (define-key evil-treemacs-state-map (kbd "H") #'treemacs-toggle-show-dotfiles)
  (define-key evil-treemacs-state-map (kbd "I") #'treemacs-hide-gitignored-files-mode)
  ;; Treemacs mode specific binding
  (evil-define-key 'treemacs treemacs-mode-map (kbd "i") #'treemacs-RET-action))


(provide 'init-file)

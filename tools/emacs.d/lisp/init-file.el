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
    :straight t
    :defer t
    :init
    (with-eval-after-load 'winum
        (define-key winum-keymap (kbd "M-0") #'treemacs-select-window))
    :bind
    (:map global-map
            ("M-0"       . treemacs-select-window)
            ("C-x t 1"   . treemacs-delete-other-windows)
            ;; ("C-x t t"   . treemacs)
            ("C-x t d"   . treemacs-select-directory)
            ("C-x t B"   . treemacs-bookmark)
            ("C-x t C-t" . treemacs-find-file)
            ("C-x t M-t" . treemacs-find-tag)
            )
    :config
    (setq treemacs-persist-file (expand-file-name "treemacs-persist" user-emacs-data)))


(use-package treemacs-nerd-icons
  :config
  (treemacs-load-theme "nerd-icons"))

(use-package treemacs-evil
  :after (treemacs evil)
  :ensure t
  :config
  ;; Evil treemacs state bindings
  (evil-define-key '(normal motion) evil-treemacs-state-map
        (kbd "n")    #'treemacs-next-line
        (kbd "e")    #'treemacs-previous-line
        (kbd "N")    #'treemacs-next-neighbour
        (kbd "E")    #'treemacs-previous-neighbour
        (kbd "H")    #'treemacs-toggle-show-dotfiles
        (kbd "I")    #'treemacs-hide-gitignored-files-mode
        (kbd "i")    #'treemacs-RET-action
        (kbd "a")    #'treemacs-create-file
        (kbd "A")    #'treemacs-create-dir
        (kbd "c")    #'treemacs-copy-file
        (kbd "x")    #'treemacs-move-file
        (kbd "d")    #'treemacs-delete-file
        (kbd "r")    #'treemacs-rename-file
        (kbd "q")    #'treemacs-quit
        (kbd "y")    #'treemacs-copy-relative-path-at-point
        (kbd "Y")    #'treemacs-copy-absolute-path-at-point
        (kbd "m")    #'treemacs-mark-or-unmark-path-at-point)

  ;; Treemacs mode specific binding
  (evil-define-key 'treemacs treemacs-mode-map (kbd "i") #'treemacs-RET-action))

(use-package dirvish)


;; magit - Git Client
(use-package magit
  :ensure t
  :after (evil-leader)
  :config
  (evil-leader/set-key
    "g" 'magit-status)
  )

(provide 'init-file)

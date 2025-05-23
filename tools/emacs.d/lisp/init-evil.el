;;; init-evil.el

;; Evil - Extensible VI Layer
;; (defvar evil-colemak-state-map (make-sparse-keymap))



(use-package evil
  :ensure t
  :config
  (evil-mode 1)
  ; Colemak Vim Arrow
  ; Motion - Emacs built-in read-only mode
  (evil-define-key '(normal visual operator motion) 'global
    ;; To see the keybindings, use <C-h> k then type the key
    "n" 'evil-next-line
    "e" 'evil-previous-line
    "i" 'evil-forward-char
    ;"l" 'evil-insert
    ;"L" 'evil-insert-0-line
    "k" 'evil-search-next
    "K" 'evil-search-previous
    "j" 'evil-forward-word-end
    "J" 'evil-forward-WORD-end
    "N" '(lambda () (interactive) (evil-next-line 5))       ; 5n
    "E" '(lambda () (interactive) (evil-previous-line 5))   ; 5e
    (kbd "C-w n") 'evil-window-down
    (kbd "C-w e") 'evil-window-up
    (kbd "C-w i") 'evil-window-right
    (kbd "C-w C-n") 'evil-window-down
    (kbd "C-w C-e") 'evil-window-up
    (kbd "C-w C-i") 'evil-window-right)
  (evil-define-key '(normal visual) 'global
                   "l" 'evil-insert
                   "L" 'evil-insert-0-line)
  (evil-define-key '(normal motion) 'global
    "H" #'tab-line-switch-to-prev-tab
    "I" #'tab-line-switch-to-next-tab)
  (evil-define-key '(visual operator) 'global
    "H" #'evil-beginning-of-line
    "I" #'evil-end-of-line)
  (evil-ex-define-cmd "bn" #'tab-line-switch-to-next-tab)
  (evil-ex-define-cmd "bp" #'tab-line-switch-to-prev-tab))

;; Text Objects Keymap - Use `l` for inner (swap i and l)
;; https://github.com/emacs-evil/evil/blob/master/evil-maps.el#L398-L421
(define-key evil-visual-state-map "l" evil-inner-text-objects-map)
(define-key evil-operator-state-map "l" evil-inner-text-objects-map)


;; Provides Vim-like Leader key <SPC>
(use-package evil-leader
  :after evil
  :config
  (global-evil-leader-mode)
  (evil-leader/set-leader "<SPC>")
  (evil-leader/set-key
    "ft" #'treemacs
    "bb" #'buffer-menu))

;; Evil Commentary: Use gc<action> to toggle comments
(use-package evil-commentary
  :after evil
  :config
  (evil-commentary-mode))

;; Evil Surround: Vim-surround Evil fork
(use-package evil-surround
  :after evil
  :config
  (global-evil-surround-mode 1))

(use-package evil-mc
  :config
  (global-evil-mc-mode 1))


;; Evil-goggles: Highlight-yank (and more)
(use-package evil-goggles
  :ensure t
  :config
  (evil-goggles-mode)

  ;; optionally use diff-mode's faces; as a result, deleted text
  ;; will be highlighed with `diff-removed` face which is typically
  ;; some red color (as defined by the color theme)
  ;; other faces such as `diff-added` will be used for other actions
  (evil-goggles-use-diff-faces))

(with-eval-after-load 'evil
  (evil-set-initial-state 'org-agenda-mode 'motion))

(provide 'init-evil)

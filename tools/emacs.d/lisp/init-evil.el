;;; init-evil.el

;; Evil - Extensible VI Layer
(defvar evil-colemak-state-map (make-sparse-keymap))

(use-package evil
  :ensure t
  :config
  (evil-mode 1)
  ; Colemak Vim Arrow
  (evil-define-key '(normal visual operator) 'global
    "n" 'evil-next-line
    "e" 'evil-previous-line
    "i" 'evil-forward-char
    "l" 'evil-insert
    "L" 'evil-insert-0-line
    "k" 'evil-search-next
    "K" 'evil-search-previous
    "j" 'evil-forward-word-end
    "J" 'evil-forward-WORD-end
    "N" '(lambda () (interactive) (evil-next-line 5))       ; 5n
    "E" '(lambda () (interactive) (evil-previous-line 5))   ; 5e
    ))

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
   "b" 'buffer-menu))

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


(provide 'init-evil)

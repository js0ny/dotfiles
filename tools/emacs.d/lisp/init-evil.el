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


(provide 'init-evil)

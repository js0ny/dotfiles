(map! :nv "l" 'evil-insert
      :nv "L" 'evil-insert-line
      :nv "k" 'evil-ex-search-next
      :nv "K" 'evil-ex-search-previous
      :nv "n" 'evil-next-line
      :nv "e" 'evil-previous-line
      :nv "i" 'evil-forward-char
      )

(evil-define-key '(normal visual operator) 'global
  ;; To see the keybindings, use <C-h> k then type the key
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
  "H" 'switch-to-prev-buffer
  "I" 'switch-to-next-buffer
  )

;; (evil-define-key evil-org-mode-map (kbd "I") 'evil-prev-buffer)
;;

(evil-define-key '(normal visual operator) evil-org-mode-map (kbd "I") 'evil-next-buffer)

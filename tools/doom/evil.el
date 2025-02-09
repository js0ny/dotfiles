(map!
 :nvm "l" 'evil-insert
 :nvm "L" 'evil-insert-line
 :nvm "k" 'evil-ex-search-next
 :nvm "K" 'evil-ex-search-previous
 :nvom "j" 'evil-forward-word-end
 :nvom "J" 'evil-forward-WORD-end
 :nvom "n" 'evil-next-line
 :nvom "e" 'evil-previous-line
 :nvom "i" 'evil-forward-char
 :nv "H" 'evil-prev-buffer
 :nv "I" 'evil-next-buffer
 :nvom "N" '(lambda () (interactive) (evil-next-line 5))       ; 5n
 :nvom "E" '(lambda () (interactive) (evil-previous-line 5))   ; 5e
 )

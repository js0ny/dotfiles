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
 :nvom "C-w n" 'evil-window-down
 :nvom "C-w e" 'evil-window-up
 :nvom "C-w i" 'evil-window-right
 )

;; Swap ; and :
(map! :leader
      ";" #'execute-extended-command
      ":" #'pp-eval-expression
      "f h" #'consult-recent-file
      "b D" #'kill-some-buffers
      "f c" #'doom/open-private-config
      "f C" #'editorconfig-find-current-editorconfig)

(map!
 :nvm "H" 'evil-prev-buffer
 :nvm "L" 'evil-next-buffer
 :nvom "J" '(lambda () (interactive) (evil-next-line 5))       ; 5j
 :nvom "K" '(lambda () (interactive) (evil-previous-line 5))   ; 5k
 )

;; Swap ; and :
(map! :leader
      ";" #'execute-extended-command
      ":" #'pp-eval-expression
      "f h" #'consult-recent-file
      "b D" #'kill-some-buffers
      "f c" #'doom/open-private-config
      "f C" #'editorconfig-find-current-editorconfig)

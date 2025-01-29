;;; init-org.el

(use-package org
  :ensure nil ;; Use Emacs built-in Org Mode
  :config
  (setq org-log-done 'time)
  (setq org-startup-indented nil)
  ;; Use inline image
  (setq org-startup-with-inline-images t)
  ;; Use LaTeX rendering
  (setq org-startup-with-latex-preview t)
  (setq org-image-actual-width 600)
  ;; Conceal on markup markers
  (setq org-hide-emphasis-markers t)
  (setq org-directory "~/OrgFiles")
  (setq org-agenda-files '("~/OrgFiles"))
  (setq org-pretty-entities t)
  (setq org-src-fontify-natively t)
  (setq org-src-tab-acts-natively t) ; Use TAB to indent inside source block
  (setq org-src-preserve-indentation t) ; Prevent from auto-indent
  (with-eval-after-load 'org
    (define-key org-mode-map (kbd "C-j") 'org-return-indent)
    (evil-define-key 'normal org-mode-map (kbd "TAB") 'org-cycle))
    (evil-define-key 'normal org-mode-map (kbd "SPC a") 'org-agenda-list) ; TODO: Here Simulates the leader
  )

(use-package org-bullets
  :after org
  :hook (org-mode . org-bullets-mode))

(use-package org-fragtog
  :after org
  :hook (org-mode . org-fragtog-mode))

;; Run source block with C-c C-c
;; Add supports for non-elisp langs
(use-package ob-python
  :ensure nil  ; Part of Org Mode
  :after org)

(use-package ob-C ;; C++ support is integrated in ob-C
  :ensure nil  ; Part of Org Mode
  :after org)

(org-babel-do-load-languages
 'org-babel-load-languages
 '( 
   (python . t) ; No need to declare C/C++/emacs-lisp since is integrated
   ))
;; Use clang as default C/C++ Compiler (Easier to install and configure in Windows)
(setq org-babel-C-compiler "clang")
(setq org-babel-C++-compiler "clang++")
;; Don't ask me again when running source block
(setq org-confirm-babel-evaluate nil)


(provide 'init-org)

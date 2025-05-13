
(use-package texfrag
  ;; :init
  ;; (texfrag-global-mode)
  :config
  (evil-define-key 'normal texfrag-mode-map
    (kbd "zL") #'texfrag-document)
  :hook (markdown-mode . texfrag-mode))

(use-package laas
  :hook (
	 (LaTeX-mode . laas-mode)
	 (org-mode . laas-mode))
  :config ; do whatever here
  (aas-set-snippets 'laas-mode
                    ;; set condition!
                    :cond #'texmathp ; expand only while in math
		    "nabl" "\\nabla"
		    "lg" "\\lg"
		    "hat" "\\hat"
		    ;; "iint" "\\iint"
		    ;; "int" "\\int"
		    "cdot" "\\cdot"
		    "dif" "\\mathrm{d}"
		    "pm" "\\pm"
		    "mp" "\\mp"
		    "sq" "\\sqrt"
                    ;; bind to functions!
		    "mk" (lambda () (interactive)
			      (yas-expand-snippet "\\( $1 \\)$0"))
		    "ppart" (lambda () (interactive)
			      (yas-expand-snippet "\\frac{\\partial $2}{\\partial $1} $0"))
		    "rm" (lambda () (interactive)
			      (yas-expand-snippet "\\mathrm{$1} $0"))
		    "sb" (lambda () (interactive)
			      (yas-expand-snippet "_{$1} $0"))
                    "Sum" (lambda () (interactive)
                            (yas-expand-snippet "\\sum_{$1}^{$2} $0"))
                    "Span" (lambda () (interactive)
                             (yas-expand-snippet "\\Span($1)$0"))
                    ;; add accent snippets
                    :cond #'laas-object-on-left-condition
                    "qq" (lambda () (interactive) (laas-wrap-previous-object "sqrt"))
		    :cond #'(lambda () (and (not (texmathp))
					    (looking-back "^" nil)))
		    "dm" '(yas "\\[\n$1\n\\]$0"))
  )

(provide 'init-latex)
;;; init-latex.el ends

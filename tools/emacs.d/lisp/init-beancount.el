;; (straight-use-package
;;  '(beancount
;;    :host github
;;    :repo "beancount/beancount-mode"
;;    :files ("*.el")))

(use-package beancount
  :mode (("\\.beancount\\'" . beancount-mode)
	 ("\\.bean\\'" . beancount-mode)))


(provide 'init-beancount)

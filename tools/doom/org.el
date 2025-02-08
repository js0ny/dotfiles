
;; For CJK users
;; Insert zero width space around the emphasis symbols, this might be useful for
;; languages that does not rely on space
(after! org
  (defun my/insert-emphasis-with-zws (char)
    (interactive "c")
    (insert ?\u200B char)
    (save-excursion (insert char ?\u200B)))

  (map! :map org-mode-map
        "C-c b" (lambda () (interactive) (my/insert-emphasis-with-zws ?*))
        "C-c i" (lambda () (interactive) (my/insert-emphasis-with-zws ?/))
        "C-c u" (lambda () (interactive) (my/insert-emphasis-with-zws ?_)))

  (map! :map evil-org-mode-map
      :nv "I" #'evil-next-buffer)


  (setq org-archive-location "~/OrgFiles/archive/%s_archive::")
    (setq org-default-notes-file "~/OrgFiles/tasks/inbox.org")
(setq org-capture-templates
      '(("t" "Task" entry (file+headline "~/OrgFiles/tasks/inbox.org" "Tasks")
         "* TODO %?\n  %U\n  %a\n  %i"
         :empty-lines 1)))
    )


(after! org-agenda
  (map! :map evil-org-agenda-mode-map
        :nv "n" #'org-agenda-next-line
        :nv "e" #'org-agenda-previous-line
        "gn" 'org-agenda-next-item
        "ge" 'org-agenda-previous-item
        :nv "i" #'evil-forward-char)
  (setq org-agenda-files (directory-files-recursively "~/OrgFiles/tasks/" "\\.org$"))
    )

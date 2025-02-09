;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/OrgFiles/")
(setq org-roam-directory  "~/OrgFiles/roam/")

(after! org
  ;; For CJK users
  ;; Insert zero width space around the emphasis symbols, this might be useful for
  ;; languages that does not rely on space
  (defun my/insert-emphasis-with-zws (char)
    (interactive "c")
    (insert ?\u200B char)
    (save-excursion (insert char ?\u200B)))

  ;; Directory
  (setq org-archive-location "~/OrgFiles/archive/%s_archive::")
  (setq org-default-notes-file "~/OrgFiles/tasks/inbox.org")

  ;; Initial Visibility
  (setq org-startup-folded "show2levels")

  ;; Log into drawer
  (setq org-log-into-drawer "LOGBOOK")

  ;;

  (setq org-todo-keywords '((sequence "TODO(t)" "NEXT(n)" "WAIT(w@/!)" "|" "DONE(d!)" "CANCELLED(c@)")
                            (sequence "[ ](T)" "[-](P)" "[?](Q)" "|" "[X](D)")))

  ;; Keymaps
  (map! :map org-mode-map
        "C-c b" (lambda () (interactive) (my/insert-emphasis-with-zws ?*))
        "C-c i" (lambda () (interactive) (my/insert-emphasis-with-zws ?/))
        "C-c u" (lambda () (interactive) (my/insert-emphasis-with-zws ?_))
        :nvom "N" 'org-next-visible-heading
        :nvom "E" 'org-previous-visible-heading)

  (setq org-capture-templates
        '(("t" "Task" entry (file+headline "~/OrgFiles/tasks/inbox.org" "Tasks")
           "* TODO %?\n  %U\n  %a\n  %i"
           :empty-lines 1)))

  )

(after! evil-org
  (map! :map evil-org-mode-map
        :n "L" 'evil-org-insert-line
        :n "I" 'evil-next-buffer
        )
  )

(after! org-agenda
  (setq org-agenda-files (directory-files-recursively "~/OrgFiles/tasks/" "\\.org$"))
  )

(map! :after org-agenda
      :map evil-org-agenda-mode-map
      :m "n" #'org-agenda-next-line
      :m "e" #'org-agenda-previous-line
      :m "gn" #'org-agenda-next-item
      :m "ge" #'org-agenda-previous-item
      :m "N" #'org-agenda-priority-up
      :m "E" #'org-agenda-priority-down
      :m "i" #'evil-forward-char)

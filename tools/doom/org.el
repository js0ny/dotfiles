;; If use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/OrgFiles/")
;; (setq org-roam-directory  "~/OrgFiles/roam/")

;;; org general

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

  (setq org-todo-keywords '((sequence "TODO(t)" "NEXT(n)" "WAIT(w@/!)" "|" "DONE(d@/!)" "CANCELLED(c@)")
                            ))

  (setq org-todo-keyword-faces
        '(("TODO" . (:foreground "red" :weight bold :background "yellow"))
          ("NEXT" . (:foreground "blue" :weight bold :background "lightgray"))
          ("WAIT" . (:foreground "orange" :weight bold))
          ("DONE" . (:foreground "grey" :weight bold :italic t))
          ("CANCELLED" . (:foreground "grey" :weight bold))
          ))

  ;; Keymaps
  (map! :map org-mode-map
        :desc "Bold with ZWS" "C-c b" (lambda () (interactive) (my/insert-emphasis-with-zws ?*))
        :desc "Italic with ZWS" "C-c i" (lambda () (interactive) (my/insert-emphasis-with-zws ?/))
        :desc "Underline with ZWS" "C-c u" (lambda () (interactive) (my/insert-emphasis-with-zws ?_))
        :desc "Code with ZWS" "C-c c" (lambda () (interactive) (my/insert-emphasis-with-zws ?~))
        :nvom "M-n" 'org-metadown
        :nvom "M-e" 'org-metaup)

  (setq org-capture-templates
        '(("t" "Task" entry (file+headline "~/OrgFiles/tasks/inbox.org" "Tasks")
           "* TODO %?\n  %U\n  %a\n  %i"
           :empty-lines 1)
          ("n" "Note" entry (file+headline "~/OrgFiles/tasks/inbox.org" "Notes"))
          ))

  ;; 处理 Zotero 链接
  (org-link-set-parameters
   "zotero"
   :follow (lambda (path) (browse-url (concat "zotero://" path)))
   :export (lambda (path desc format)
             (cond
              ((eq format 'html) (format "<a href=\"zotero://%s\">%s</a>" path (or desc path)))
              ((eq format 'latex) (format "\\href{zotero://%s}{%s}" path (or desc path)))
              (t path))))

  ;; 处理 Obsidian 链接
  (org-link-set-parameters
   "obsidian"
   :follow (lambda (path) (browse-url (concat "obsidian://" path)))
   :export (lambda (path desc format)
             (cond
              ((eq format 'html) (format "<a href=\"obsidian://%s\">%s</a>" path (or desc path)))
              ((eq format 'latex) (format "\\href{obsidian://%s}{%s}" path (or desc path)))
              (t path))))

  )

(after! evil-org
  (map! :map evil-org-mode-map
        :n "L" 'evil-org-insert-line
        :n "I" 'evil-next-buffer
        )
  )

;;; org-agenda

(after! org-agenda
  ;; (setq org-agenda-files (directory-files-recursively "~/OrgFiles/tasks/" "\\.org$"))
  (setq org-agenda-files (list (concat org-directory "tasks/")))
  )


(map! :after org-agenda
      :map evil-org-agenda-mode-map
      :m "n" #'org-agenda-next-line
      :m "e" #'org-agenda-previous-line
      :m "gn" #'org-agenda-next-item
      :m "ge" #'org-agenda-previous-item
      :m "N" #'org-agenda-priority-up
      :m "E" #'org-agenda-priority-down
      :m "i" #'evil-forward-char
      :m "," #'org-agenda-priority
      :m "x" #'org-agenda-todo
      :m "t" #'org-agenda-set-tags
      :m "w" #'org-save-all-org-buffers
      ;; d: date reschedule
      :m "ds" #'org-agenda-schedule
      :m "dd" #'org-agenda-deadline
      :m "$" #'org-agenda-archive
      :m "!" #'org-agenda-toggle-deadlines
      ;; c: clock
      :m "cp" #'org-pomodoro
      :m "vd" #'org-agenda-day-view
      :m "vw" #'org-agenda-week-view
      :m "vm" #'org-agenda-month-view
      :m "vy" #'org-agenda-year-view
      :m "v." #'org-agenda-reset-view
      :leader :desc "Org Agenda" "A" #'org-agenda)

(setq org-agenda-prefix-format '((agenda . " %i %-12:c%?-12t% s")
                                 (todo . " %i %-12:c %e")
                                 (tags . " %i %-12:c %e ")
                                 (search . " %i %-12:c %e ")))


;; https://github.com/AbstProcDo/Master-Emacs-From-Scratch-with-Solid-Procedures/blob/master/06.Emacs-as-Agenda-by-Org.org
;;Sunrise and Sunset
;;日出而作, 日落而息
(defun js0ny/diary-sunrise ()
  (let ((dss (diary-sunrise-sunset)))
    (with-temp-buffer
      (insert dss)
      (goto-char (point-min))
      (while (re-search-forward " ([^)]*)" nil t)
        (replace-match "" nil nil))
      (goto-char (point-min))
      (search-forward ",")
      (buffer-substring (point-min) (match-beginning 0)))))

(defun js0ny/diary-sunset ()
  (let ((dss (diary-sunrise-sunset))
        start end)
    (with-temp-buffer
      (insert dss)
      (goto-char (point-min))
      (while (re-search-forward " ([^)]*)" nil t)
        (replace-match "" nil nil))
      (goto-char (point-min))
      (search-forward ", ")
      (setq start (match-end 0))
      (search-forward " at")
      (setq end (match-beginning 0))
      (goto-char start)
      (capitalize-word 1)
      (buffer-substring start end))))

(after! (org-agenda cal-china-x)
  (setq org-agenda-format-date 'org-agenda-format-date-aligned)


  (defun org-agenda-format-date-aligned (date)
    "Format a DATE string for display in the daily/weekly agenda, or timeline.
      This function makes sure that dates are aligned for easy reading."
    (require 'cal-iso)
    (let* ((dayname (aref cal-china-x-days
                          (calendar-day-of-week date)))
           (day (cadr date))
           (month (car date))
           (year (nth 2 date))
           (cn-date (calendar-chinese-from-absolute (calendar-absolute-from-gregorian date)))
           (cn-month (cl-caddr cn-date))
           (cn-day (cl-cadddr cn-date))
           (cn-month-string (concat (aref cal-china-x-month-name
                                          (1- (floor cn-month)))
                                    (if (integerp cn-month)
                                        ""
                                      "(闰月)")))
           (cn-day-string (aref cal-china-x-day-name
                                (1- cn-day))))
      (format "%04d-%02d-%02d 周%s %s%s" year month
              day dayname cn-month-string cn-day-string))))


(setq org-agenda-time-grid (quote ((daily today require-timed)
                                   (300 600 900 1200 1500 1800 2100 2400)
                                   "......"
                                   "-----------------------------------------------------"
                                   )))

;; org-agenda-clockreport

(setq org-agenda-clockreport-parameter-plist '(:link t :maxlevel 3 :fileskip0 t :compact t :narrow 80))

;;; org-clock

;; org-pomodoro

(after! org-pomodoro
  (setq org-pomodoro-format "Pomo~%s")
  (setq org-pomodoro-short-break-format "摸~%s")
  (setq org-pomodoro-long-break-format "猛摸~%s")
  )


;;; org-babel

(if (not (eq system-type 'gnu/linux))
    (setq org-babel-C-compiler "clang"))


;;; org-export

;; icalendar

(setq org-icalendar-use-scheduled '(event-if-todo event-if-not-todo))
(setq org-icalendar-use-deadline '(event-if-todo event-if-not-todo))
(setq org-icalendar-combined-agenda-file "~/Dropbox/org.ics")


(use-package! org-pomodoro-music-controller
  :after org-pomodoro
  :config
  (customize-set-variable 'org-pomodoro-music-player-args '("--player=cider"))
  )

(use-package! org-pomodoro-telegram-notifier
  :after org-pomodoro
  )

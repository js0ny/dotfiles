;;; init-org.el

;; Use =M-x org-mode-restart= to take effects
;; After =M-x eval-buffer=

;; Org General

(use-package org
  :straight (:type built-in) ;; Tell straight to not install org
  :custom
  (org-log-done 'time)
  (org-startup-indented nil)
  ;; Use inline image
  (org-startup-with-inline-images t)
  (org-display-remote-inline-images 'cache) ; 预览网络图片

  ;; Use LaTeX rendering
  ;; (org-startup-with-latex-preview nil)
  (org-image-actual-width 600)
  ;; Conceal on markup markers
  (org-hide-emphasis-markers t)
  (org-directory "~/OrgFiles/")
  (org-agenda-files (list (concat org-directory "tasks/")))
  (org-persist-directory (expand-file-name "org-persist" user-emacs-data))
  (org-archive-location "~/OrgFiles/.archive/%s_archive::")
  (org-default-notes-file "~/OrgFiles/tasks/inbox.org")
  (org-id-locations-file (expand-file-name ".org-id-locations" org-directory))
  (org-startup-folded "show2levels")
  (org-log-into-drawer "LOGBOOK")
  (org-pretty-entities t)
  (org-src-fontify-natively t)
  (org-src-tab-acts-natively t) ; Use TAB to indent inside source block
  (org-src-preserve-indentation t) ; Prevent from auto-indent
  (org-startup-folded 'showall)
  :config
  (with-eval-after-load 'org
    (define-key org-mode-map (kbd "C-j") 'org-return-indent)
    (evil-define-key 'normal org-mode-map (kbd "TAB") 'org-cycle))
  (evil-define-key 'normal org-mode-map (kbd "SPC a") 'org-agenda-list) ; TODO: Here Simulates the leader
  (setq org-emphasis-alist
	'(("*" (bold :foreground "cyan" ))
	  ("/" (italic :foreground "green"))
	  ("_" underline)
	  ("=" (org-verbatim verbatim :background "maroon" :foreground "white"))
	  ("~" (org-code verbatim :background "maroon" :foreground "white"))
	  ("+" (:strike-through t))))

  (dolist (face '((org-level-1 . 1.6)
                  (org-level-2 . 1.4)
                  (org-level-3 . 1.2)
                  (org-level-4 . 1.1)
                  (org-level-5 . 1.0)
                  (org-level-6 . 1.0)
                  (org-level-7 . 1.0)
                  (org-level-8 . 1.0)))
    (set-face-attribute (car face) nil :height (cdr face))))



;; Org Styling

;; Set Org Styles


;; Org Preview

;; Better LaTeX preview

(setq org-latex-preview-ltxpng-directory (expand-file-name "emacs/org/latex" xdg-cache-home))
(setq org-preview-latex-default-process 'dvisvgm)
(setq org-format-latex-options (plist-put org-format-latex-options :scale 0.8))

;; org-appear: Show hidden emphasis markers
;; Just like Obsidian
(use-package org-appear
  :hook
  (org-mode . org-appear-mode))


(use-package org-latex-impatient
  :defer t
  :hook (org-mode . org-latex-impatient-mode)
  :init
  (setq org-latex-impatient-tex2svg-bin
        ;; location of tex2svg executable
        "~/.local/share/pnpm/tex2svg"))

(use-package org-fragtog
  :after org
  :hook (org-mode . org-fragtog-mode))

;; Pasting Images
;; Use =M-x org-download-clipboard= to paste image
;; Additional program required: magick
;; Windows: scoop install imagemagick
;; org-download config
(use-package org-download
  :ensure t
  :after org
  :config
  ;; Hardcoding the image dir
  (setq-default org-download-image-dir (expand-file-name ".attach" org-directory))

  (setq org-download-heading-lvl nil ; don't use heading when creating files
        org-download-timestamp "%Y%m%d-%H%M%S"
        org-download-screenshot-method "screencapture -i %s"  ; for macOS only
        org-download-backend 'curl) ; use curl to `download` image

  (org-download-enable)

  :bind (:map org-mode-map
         ("C-c d c" . org-download-clipboard)    ; 粘贴剪贴板内容
         ("C-c d s" . org-download-screenshot))) ; 截图


;; For CJK users
;; Insert zero width space around the emphasis symbols, this might be useful for
;; languages that does not rely on space
(defun js0ny/insert-emphasis-with-zws (char)
  (interactive "c")
  (insert ?\u200B char)
  (save-excursion (insert char ?\u200B)))

(global-set-key (kbd "C-c b") (lambda () (interactive) (js0ny/insert-emphasis-with-zws ?*)))
(global-set-key (kbd "C-c i") (lambda () (interactive) (js0ny/insert-emphasis-with-zws ?/)))

;; Pomodoro for org clock
(use-package org-pomodoro)

(use-package org-modern
  :ensure t
  :config
  ;; (setopt org-modern-star 'replace
  ;;         org-modern-replace-stars '("§")
  ;;         org-modern-hide-stars "§")
  (setopt org-modern-list '((?- . "•")))
  (setopt org-modern-timestamp '(" %Y-%m-%d " . " %H:%M "))
  (setopt org-modern-block-fringe nil)

;; https://github.com/neoheartbeats/.emacs.d/blob/main/lisp/init-org.el#L126C1-L159C47
  (defun sthenno/org-modern-spacing ()
    "Adjust line-spacing for `org-modern' to correct svg display."

    ;; FIXME: This may not set properly
    (setq-local line-spacing (cond ((eq major-mode #'org-mode) 0.20)
                                   (t nil))))
  (add-hook 'org-mode-hook #'sthenno/org-modern-spacing)


  ;; Hooks
  (add-hook 'org-mode-hook #'org-modern-mode))

;; WARNING: This package will cause infinite recursion when initialising org
;; Test on 2025-03-14 Emacs 30 and Arch Linux
;(use-package mixed-pitch
;  :hook
;  (text-mode . org-mode))

;; Org Agenda

(with-eval-after-load 'org-agenda
  (evil-define-key 'motion org-agenda-mode-map
    (kbd "n") #'org-agenda-next-line
    (kbd "e") #'org-agenda-previous-line
    (kbd "gn") #'org-agenda-next-item
    (kbd "ge") #'org-agenda-previous-item
    (kbd "N") #'org-agenda-priority-up
    (kbd "E") #'org-agenda-priority-down
    (kbd "i") #'evil-forward-char
    (kbd ",") #'org-agenda-priority
    (kbd "x") #'org-agenda-todo
    (kbd "t") #'org-agenda-set-tags
    (kbd "w") #'org-save-all-org-buffers
    (kbd "ds") #'org-agenda-schedule
    (kbd "dd") #'org-agenda-deadline
    (kbd "$") #'org-agenda-archive
    (kbd "!") #'org-agenda-toggle-deadlines
    (kbd "cp") #'org-pomodoro
    (kbd "vd") #'org-agenda-day-view
    (kbd "vw") #'org-agenda-week-view
    (kbd "vm") #'org-agenda-month-view
    (kbd "vy") #'org-agenda-year-view
    (kbd "v.") #'org-agenda-reset-view))

(evil-leader/set-key "A" #'org-agenda)

(setq org-agenda-prefix-format '((agenda . " %i %-12:c%?-12t% s")
                                 (todo . " %i %-12:c %e")
                                 (tags . " %i %-12:c %e ")
                                 (search . " %i %-12:c %e ")))


;; Org Babel

;; Run source block with C-c C-c
;; Add supports for non-elisp langs
(use-package ob-python
  :straight (:type built-in)  ; Part of Org Mode
  :after org)

(use-package ob-C ;; C++ support is integrated in ob-C
  :straight (:type built-in)  ; Part of Org Mode
  :after org)

(org-babel-do-load-languages
 'org-babel-load-languages
 '(
   (python . t) ; No need to declare C/C++/emacs-lisp since is integrated
   (shell . t)
   ))
;; Don't ask me again when running source block
;; Use clang as default C/C++ Compiler on macOS and Windows
(setq org-confirm-babel-evaluate nil)
(if (not (eq system-type 'gnu/linux))
    (setq org-babel-C-compiler "clang"))

(setq org-babel-default-header-args:C
      '((:includes . "<stdio.h> <stdlib.h> <string.h>")))

(setq org-babel-default-header-args:C++
      '((:includes . "<iostream> <vector>")))

;; Org Export

;; icalendar

(setq org-icalendar-use-scheduled '(event-if-todo event-if-not-todo))
(setq org-icalendar-use-deadline '(event-if-todo event-if-not-todo))
(setq org-icalendar-combined-agenda-file "~/Dropbox/org.ics")


;; Integrate Emacs Timer with System Notifications
;; 定义通知函数
(defun js0ny/org-clock-notification (title message &optional icon)
  "发送一个系统通知"
  (alert message
         :title title
         :icon icon
         :category 'org-clock))

;; 添加定时器检查函数
(defun js0ny/org-clock-check-timer ()
  "检查当前正在运行的 clock 是否到期"
  (when (org-clocking-p)
    (let* ((clocked-time (org-clock-get-clocked-time))
           (effort (org-duration-to-minutes
                    (or (org-entry-get (org-clock-is-active) "Effort")
                        "0")))
           (remaining (- effort clocked-time)))
      (when (and (> effort 0) (<= remaining 0))
        (js0ny/org-clock-notification
         "Org Clock 提醒"
         (format "任务 '%s' 的预计时间已到！"
                (org-clock-get-clock-string)))))))

;; 设置定时器，每分钟检查一次
(run-with-timer 0 60 #'js0ny/org-clock-check-timer)

;; 在 org-clock-in-hook 中添加检查
(add-hook 'org-clock-in-hook
          (lambda ()
            (let ((effort (org-entry-get (point) "Effort")))
              (when effort
                (js0ny/org-clock-notification
                 "开始计时"
                 (format "开始计时任务: %s\n预计用时: %s"
                        (org-get-heading t t t t)
                        effort))))))
(use-package org-node
  :after org
  :config (org-node-cache-mode))

(provide 'init-org)

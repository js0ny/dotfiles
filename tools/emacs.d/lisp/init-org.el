;;; init-org.el

;; Use =M-x org-mode-restart= to take effects
;; After =M-x eval-buffer=

(use-package org
  :ensure nil ;; Use Emacs built-in Org Mode
  :config
  (setq org-log-done 'time)
  (setq org-startup-indented t)
  ;; Use inline image
  (setq org-startup-with-inline-images t)
  (setq org-display-remote-inline-images 'cache) ; 预览网络图片

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


;; Set Org Styles
(setq org-emphasis-alist
  '(("*" (bold :foreground "cyan" ))
    ("/" (italic :foreground "green"))
    ("_" underline)
    ("=" (org-verbatim verbatim :background "maroon" :foreground "white"))
    ("~" (org-code verbatim :background "deep sky blue" :foreground "MidnightBlue"))
    ("+" (:strike-through t))))


;; Better LaTeX preview
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
   (shell . t)
   ))
;; Use clang as default C/C++ Compiler (Easier to install and configure in Windows)
(setq org-babel-C-compiler "clang")
(setq org-babel-C++-compiler "clang++")
;; Don't ask me again when running source block
(setq org-confirm-babel-evaluate nil)

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
  (setq-default org-download-image-dir "~/OrgFiles/Attachments")

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
(defun my/insert-emphasis-with-zws (char)
  (interactive "c")
  (insert ?\u200B char)
  (save-excursion (insert char ?\u200B)))

(global-set-key (kbd "C-c b") (lambda () (interactive) (my/insert-emphasis-with-zws ?*)))
(global-set-key (kbd "C-c i") (lambda () (interactive) (my/insert-emphasis-with-zws ?/)))

;; Pomodoro for org clock
(use-package org-pomodoro)

;; Org Styles Integration
(use-package org-modern
  :ensure t
  :after (org)
  :config
  (with-eval-after-load 'org (global-org-modern-mode))
;; https://github.com/minad/org-modern/issues/232
  (setq org-modern-fold-stars
      '(("▶" . "▼")
        ("▷" . "▽")
        ;; ("⯈" . "⯆")
        ("▷" . "▽")
        ("▹" . "▿")
        ("▸" . "▾"))
)
)

(use-package mixed-pitch
  :hook
  (text-mode . org-mode))

;; Integrate Emacs Timer with System Notifications
;; 定义通知函数
(defun my/org-clock-notification (title message &optional icon)
  "发送一个系统通知"
  (alert message
         :title title
         :icon icon
         :category 'org-clock))

;; 添加定时器检查函数
(defun my/org-clock-check-timer ()
  "检查当前正在运行的 clock 是否到期"
  (when (org-clocking-p)
    (let* ((clocked-time (org-clock-get-clocked-time))
           (effort (org-duration-to-minutes 
                    (or (org-entry-get (org-clock-is-active) "Effort")
                        "0")))
           (remaining (- effort clocked-time)))
      (when (and (> effort 0) (<= remaining 0))
        (my/org-clock-notification 
         "Org Clock 提醒"
         (format "任务 '%s' 的预计时间已到！"
                (org-clock-get-clock-string)))))))

;; 设置定时器，每分钟检查一次
(run-with-timer 0 60 #'my/org-clock-check-timer)

;; 在 org-clock-in-hook 中添加检查
(add-hook 'org-clock-in-hook
          (lambda ()
            (let ((effort (org-entry-get (point) "Effort")))
              (when effort
                (my/org-clock-notification 
                 "开始计时"
                 (format "开始计时任务: %s\n预计用时: %s" 
                        (org-get-heading t t t t)
                        effort))))))

(provide 'init-org)

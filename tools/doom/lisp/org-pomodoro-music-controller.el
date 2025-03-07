;;; org-pomodoro-music-controller.el --- Play music during org-pomodoro breaks -*- lexical-binding: t; -*-

;;; Commentary:
;;; Add music control to org-pomodoro breaks.

;;; Code:

(require 'org-pomodoro)

;; Variables

(defcustom org-pomodoro-music-player-command
  (cond
   ((eq system-type 'windows-nt) "clmcontrol")
   ((eq system-type 'darwin) "nowplaying-cli")
   ((eq system-type 'gnu/linux) "playerctl")
   (t "playerctl"))
  "Command to control the music player."
  :type 'string
  :group 'org-pomodoro)


(defcustom org-pomodoro-music-player-args nil
  "Arguments to pass to the music player command."
  :type '(repeat string)
  :group 'org-pomodoro)


(defun org-pomodoro-music-get-status ()
  "Get thestatus of the music player."
  (with-temp-buffer
    (let ((args (append org-pomodoro-music-player-args '("status"))))
      (apply #'call-process org-pomodoro-music-player-command nil t nil args)
      (string-trim (buffer-string)))))

(defun org-pomodoro-music-is-playing-p ()
  "Check if the music player is playing."
  (let ((status (org-pomodoro-music-get-status)))
    (string= status "Playing")))

(defun org-pomodoro-music-pause ()
  "Stop the music player."
  (let ((args (append org-pomodoro-music-player-args '("pause"))))
    (apply #'call-process org-pomodoro-music-player-command nil nil nil args)))

(defun org-pomodoro-music-play ()
  "Start the music player."
  (let ((args (append org-pomodoro-music-player-args '("play"))))
    (apply #'call-process org-pomodoro-music-player-command nil nil nil args)))

;; Defining Hooks
(defun org-pomodoro-music-break-started-hook ()
  "When a break start, pause the music player."
  (setq org-pomodoro-music-was-playing (org-pomodoro-music-is-playing-p))
  (when org-pomodoro-music-was-playing
    (org-pomodoro-music-pause)
    (message "休息开始，音乐已暂停")))

;; (defun org-pomodoro-music-break-finished-hook ()
;;   "When a break finishes, resume the music player."
;;   (when (and org-pomodoro-music-was-playing
;;              (not (org-pomodoro-music-is-playing-p)))
;;     (org-pomodoro-music-play)
;;     (message "休息结束，音乐已恢复播放"))
;;   (setq org-pomodoro-music-was-playing nil))

(defun org-pomodoro-music-started-hook ()
  "When a pomodoro start, play the music player."
  (unless (org-pomodoro-music-is-playing-p)
    (org-pomodoro-music-play)
    (message "番茄开始，音乐已开始播放"))
  )

;; Adding hooks
;; (add-hook 'org-pomodoro-break-started-hook #'org-pomodoro-music-break-started-hook)
;; (add-hook 'org-pomodoro-break-finished-hook #'org-pomodoro-music-break-finished-hook)

;; (add-hook 'org-pomodoro-long-break-started-hook #'org-pomodoro-music-break-started-hook)
;; (add-hook 'org-pomodoro-long-break-finished-hook #'org-pomodoro-music-break-finished-hook)

(add-hook 'org-pomodoro-started-hook #'org-pomodoro-music-started-hook)

(provide 'org-pomodoro-music-controller)
;;; org-pomodoro-music-controller.el ends here

;;; org-pomodoro-telegram-notifier.el --- 为 org-pomodoro 添加发送 Telegram 通知的功能。 -*- lexical-binding: t; -*-

;;; Commentary:
;;; Provide a way to send Telegram notifications when org-pomodoro breaks end.

;;; Code:

(require 'org-pomodoro)
(require 'request)

(defcustom org-pomodoro-telegram-bot-token ""
  "Your Telegram bot token."
  :type 'string
  :group 'org-pomodoro)

(defcustom org-pomodoro-telegram-chat-id ""
  "Your Telegram chat ID."
  :type 'string
  :group 'org-pomodoro)

(defcustom org-pomodoro-telegram-break-end-message "休息时间结束"
  "The message to send when a break ends."
  :type 'string
  :group 'org-pomodoro)

(defun org-pomodoro-send-telegram-message (message)
  "Send a message to the Telegram chat.
MESSAGE is the message to send."
  (interactive)
  (when (and (not (string-empty-p org-pomodoro-telegram-bot-token))
             (not (string-empty-p org-pomodoro-telegram-chat-id)))
    (request
      (format "https://api.telegram.org/bot%s/sendMessage" org-pomodoro-telegram-bot-token)
      :type "POST"
      :data `(("chat_id" . ,org-pomodoro-telegram-chat-id)
              ("text" . ,"⏳<b>[Emacs]</b> <code>org-pomodoro</code>: 休息时间结束")
              ("parse_mode" . "HTML"))
      :parser 'json-read
      :success (cl-function
                (lambda (&key data &allow-other-keys)
                  (message "成功发送 Telegram 通知")))
      :error (cl-function
              (lambda (&key error-thrown &allow-other-keys)
                (message "发送 Telegram 通知失败: %S" error-thrown))))
    )
  )

(defun org-pomodoro-telegram-break-finished-hook ()
  "Send a Telegram message when a break ends."
  (org-pomodoro-send-telegram-message org-pomodoro-telegram-break-end-message))

(add-hook 'org-pomodoro-break-finished-hook #'org-pomodoro-telegram-break-finished-hook)
(add-hook 'org-pomodoro-long-break-finished-hook #'org-pomodoro-telegram-break-finished-hook)


(provide 'org-pomodoro-telegram-notifier)
;;; org-pomodoro-telegram-notifier.el ends here

;;; org-pomodoro-telegram-notifier.el --- 发送 Telegram 通知当 org-pomodoro 休息结束

(require 'org-pomodoro)
(require 'request)

(defcustom org-pomodoro-telegram-bot-token ""
  "你的 Telegram Bot Token。"
  :type 'string
  :group 'org-pomodoro)

(defcustom org-pomodoro-telegram-chat-id ""
  "接收通知的 Telegram Chat ID。"
  :type 'string
  :group 'org-pomodoro)

(defcustom org-pomodoro-telegram-break-end-message "休息时间结束"
  "休息结束时发送的消息。"
  :type 'string
  :group 'org-pomodoro)

(defun org-pomodoro-send-telegram-message (message)
  "使用 Telegram bot 发送消息。"
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
  "当休息时间结束时发送 Telegram 通知。"
  (org-pomodoro-send-telegram-message org-pomodoro-telegram-break-end-message))

(add-hook 'org-pomodoro-break-finished-hook #'org-pomodoro-telegram-break-finished-hook)
(add-hook 'org-pomodoro-long-break-finished-hook #'org-pomodoro-telegram-break-finished-hook)


(provide 'org-pomodoro-telegram-notifier)
;;; org-pomodoro-telegram-notifier.el ends here

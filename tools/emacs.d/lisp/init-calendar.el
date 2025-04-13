;;; init-calendar.el

(setq calendar-date-style 'iso)
(setq diary-date-forms '((year "年" month "月" day "日" " 星期[" "日一二三四五六" "]") ;; Chinese
                         (year "-" month "-" day) ;; ISO
                         (month "[-/]" day "[^-/0-9]") (year "[-/]" month "[-/]" day "[^0-9]")
                         (monthname " *" day "[^-0-9]") (year " *" monthname " *" day "[^0-9]")
                         (dayname "\\W")))

(setq calendar-mark-holidays-flag t
      calendar-week-start-day 1)


(use-package cal-china-x
  :ensure t
  :custom
  (cal-china-x-important-holidays '((holiday-chinese-new-year)
                                    (holiday-lunar 12 23 "小年(北)" 1)
                                    (holiday-lunar 12 24 "小年(南)" 1)
                                    (holiday-lunar 12 30 "除夕" 1)
                                    (holiday-lunar 1 1 "春节" 0)
                                    (holiday-lunar 1 2 "春节" 0)
                                    (holiday-lunar 1 3 "春节" 0)
                                    (holiday-lunar 1 4 "春节" 0)
                                    (holiday-lunar 1 5 "春节(破五)" 0)
                                    (holiday-lunar 1 15 "元宵节" 0)
                                    (holiday-lunar 2 2 "龙抬头" 0)
                                    (holiday-solar-term "清明" "清明节")
                                    (holiday-fixed 5 1 "劳动节")
                                    (holiday-lunar 5 5 "端午节" 0)
                                    (holiday-lunar 7 7 "七夕节" 0)
                                    (holiday-lunar 7 15 "中元节" 0)
                                    (holiday-lunar 8 15 "中秋节" 0)
                                    (holiday-fixed 10 1 "国庆节")
                                    (holiday-fixed 10 2 "国庆节")
                                    (holiday-fixed 10 3 "国庆节")
                                    (holiday-lunar 9 9 "重阳节" 0)
                                    (holiday-lunar 10 1 "寒衣节" 0)
                                    (holiday-lunar 12 8 "腊八" 1)
                                    (holiday-solar-term "立春" "立春")
                                    (holiday-solar-term "立夏" "立夏")
                                    (holiday-solar-term "立秋" "立秋")
                                    (holiday-solar-term "立冬" "立冬")
                                    (holiday-solar-term "春分" "春分")
                                    (holiday-solar-term "夏至" "夏至")
                                    (holiday-solar-term "秋分" "秋分")
                                    (holiday-solar-term "冬至" "冬至")))
  (cal-china-x-general-holidays '((holiday-fixed 1 1 "元旦")
                                  (holiday-fixed 2 14 "情人节")
                                  (holiday-fixed 3 8 "妇女节")
                                  (holiday-fixed 4 1 "愚人节")
                                  (holiday-fixed 5 4 "青年节")
                                  (holiday-float 5 0 2 "母亲节")
                                  (holiday-fixed 6 1 "儿童节")
                                  (holiday-float 6 0 3 "父亲节")
                                  (holiday-fixed 9 10 "教师节")
                                  (holiday-float 11 4 4 "感恩节")
                                  (holiday-fixed 12 25 "圣诞节")))
  :config
  (setq calendar-holidays (append cal-china-x-important-holidays
                                  cal-china-x-general-holidays)))

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



(setq diary-file "~/.local/js0ny/diary")


(provide 'init-calendar)

;;; init-file.el -- File Management configuration 
;;; First edit at 2025/01/29

;; Dired

;; Dired Configuration
(with-eval-after-load 'dired
  (setq dired-recursive-deletes 'top) ;; Ask Before Delete Dir
  (setq dired-recursive-copies 'always) ;; Always Copy Dir
  (setq dired-dwim-target t)) ;; dwim for Do What I Mean - 当分屏显示两个 Buffer 时，复制或移动文件会自动将另一个 dired buffer 作为目标目录

;; Dired Keybindings - Colemak
(evil-define-key 'normal dired-mode-map
  "h" 'dired-up-directory
  "i" 'dired-find-file
  "n" 'dired-next-line
  "e" 'dired-previous-line)

;; This prevents Dired from opening more buffers
;; https://stackoverflow.com/q/1839313
(setq dired-kill-when-opening-new-dired-buffer t)


(provide 'init-file)

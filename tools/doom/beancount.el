;;; init-beancount.el --- beancount support -*- lexical-binding: t -*-
(after! beancount

  ;; 1. 自动启用 outline-minor-mode
  (add-hook! 'beancount-mode-hook #'outline-minor-mode)

  ;; 2. 设置大纲导航快捷键 (使用 Doom 的 map! 宏)
  (map! :map beancount-mode-map
        "C-c C-n" #'outline-next-visible-heading
        "C-c C-p" #'outline-previous-visible-heading)

  ;; 3. 核心功能：跨文件账户补全 (这部分逻辑完全保留)
  (defvar my-beancount-accounts-files nil "List of account files.")
  (setq my-beancount-accounts-files
        (directory-files "~/Documents/Finance/Beancount/config/" 'full (rx ".beancount" eos)))

  (defun my-beancount--collect-accounts-from-files (oldfun &rest args)
    "Collect all accounts from files specified in `my-beancount-accounts-files'."
    (let ((keys (apply oldfun args))
          (hash (make-hash-table :test 'equal)))
      (dolist (key keys)
        (puthash key nil hash))
      ;; collect accounts from files
      (save-excursion
        (dolist (f my-beancount-accounts-files)
          ;; `ignore-errors` is a good practice for file operations
          (ignore-errors
            (with-current-buffer (find-file-noselect f)
              (goto-char (point-min))
              (while (re-search-forward beancount-account-regexp nil t)
                (puthash (match-string-no-properties 1) nil hash))))))
      (hash-table-keys hash)))

  (advice-add #'beancount-collect
              :around #'my-beancount--collect-accounts-from-files))

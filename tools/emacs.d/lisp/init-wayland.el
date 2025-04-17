
(when (getenv "WAYLAND_DISPLAY")
  ;; Fix: Emacs nox does not have clipboard integration under wayland
  (use-package xclip
    :config
    (setq xclip-program "wl-copy")
    (setq xclip-select-enable-clipboard t)
    (setq xclip-mode t)
    (setq xclip-method (quote wl-copy))))

(provide 'init-wayland)

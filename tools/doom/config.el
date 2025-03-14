;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
;; (setq user-full-name "John Doe"
;;       user-mail-address "john@doe.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom:
;;
;; - `doom-font' -- the primary font to use
;; - `doom-variable-pitch-font' -- a non-monospace font (where applicable)
;; - `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;; - `doom-symbol-font' -- for symbols
;; - `doom-serif-font' -- for the `fixed-pitch-serif' face
;;
;; See 'C-h v doom-font' for documentation and more examples of what they
;; accept. For example:
;;
;; https://emacs-china.org/t/doom-emacs/23513/13
(setq doom-font (font-spec :family "Iosevka Nerd Font Propo" :size 14)
      doom-serif-font doom-font
      doom-symbol-font (font-spec :family "LXGW WenKai Mono")
      doom-variable-pitch-font (font-spec :family "LXGW WenKai Mono" :weight 'extra-bold))

;; 如果不把这玩意设置为 nil, 会默认去用 fontset-default 来展示, 配置无效
(setq use-default-font-for-symbols nil)

;; Doom 的字体加载顺序问题, 如果不设定这个 hook, 配置会被覆盖失效
(add-hook! 'after-setting-font-hook
  (set-fontset-font t 'latin (font-spec :family "Iosevka Nerd Font Propo"))
  (set-fontset-font t 'symbol (font-spec :family "Symbola"))
  (set-fontset-font t 'mathematical (font-spec :family "Symbola"))
  (set-fontset-font t 'emoji (font-spec :family "Symbola")))

;; (dolist (charset '(kana han cjk-misc bopomofo))
;;   (set-fontset-font t charset (font-spec :family "LXGW WenKai Mono" :size 16)))
;;
;; If you or Emacs can't find your font, use 'M-x describe-font' to look them
;; up, `M-x eval-region' to execute elisp code, and 'M-x doom/reload-font' to
;; refresh your font settings. If Emacs still can't find your font, it likely
;; wasn't installed correctly. Font issues are rarely Doom issues!

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'catppuccin)
(setq catppuccin-flavor 'mocha)
                                        ;(catppuccin-reload)

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers t)
(setq display-line-numbers-type 'visual)




;; Whenever you reconfigure a package, make sure to wrap your config in an
;; `after!' block, otherwise Doom's defaults may override your settings. E.g.
;;
;;   (after! PACKAGE
;;     (setq x y))
;;
;; The exceptions to this rule:
;;
;;   - Setting file/directory variables (like `org-directory')
;;   - Setting variables which explicitly tell you to set them before their
;;     package is loaded (see 'C-h v VARIABLE' to look up their documentation).
;;   - Setting doom variables (which start with 'doom-' or '+').
;;
;; Here are some additional functions/macros that will help you configure Doom.
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;; Alternatively, use `C-h o' to look up a symbol (functions, variables, faces,
;; etc).
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.

(add-to-list 'load-path (expand-file-name "lisp" doom-user-dir))
(setq doom-local-dir (expand-file-name "emacs" (getenv "XDG_DATA_HOME")))
(setq doom-data-dir (expand-file-name "etc" doom-local-dir))

(after! recentf
  (setq recentf-max-saved-items 200)
  (add-to-list 'recentf-exclude "\\.revive$")
  (add-to-list 'recentf-exclude "\\.windows$")
  (add-to-list 'recentf-exclude "\\.#.+$")
  (add-to-list 'recentf-exclude "^/tmp/")
  (add-to-list 'recentf-exclude "COMMIT_EDITMSG\\'")
  )[1][2]



(after! wakatime-mode
  (global-wakatime-mode)
  (setq wakatime-cli-path "~/.local/bin/wakatime"))

;; accept completion from copilot and fallback to company
(use-package! copilot
  :hook (prog-mode . copilot-mode)
  :bind (:map copilot-completion-map
              ("<tab>" . 'copilot-accept-completion)
              ("TAB" . 'copilot-accept-completion)
              ("C-TAB" . 'copilot-accept-completion-by-word)
              ("C-<tab>" . 'copilot-accept-completion-by-word)))

(load! "evil.el")

(load! "treemacs.el")

(load! "org.el")

(after! evil-matchit
  (global-evil-matchit-mode 1)
  )


(if (eq system-type 'gnu/linux)
    (use-package! rime
      :config
      (setq default-input-method "rime")
      (add-hook! (org-mode markdown-mode) (activate-input-method default-input-method))
      (setq rime-user-data-dir (expand-file-name "emacs-rime" (getenv "XDG_CONFIG_HOME")))
      ))

(load! "calendar.el")

(when (file-exists-p (expand-file-name "local.el" doom-user-dir))
  (load! "local.el"))

;; (load! "telega.el")

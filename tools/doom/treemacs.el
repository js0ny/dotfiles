(after! treemacs
  (map! :map evil-treemacs-state-map
        "n"    #'treemacs-next-line
        "e"    #'treemacs-previous-line
        "N"    #'treemacs-next-neighbour
        "E"    #'treemacs-previous-neighbour
        "H"    #'treemacs-toggle-show-dotfiles
        "I"    #'treemacs-hide-gitignored-files-mode
        "i"    #'treemacs-RET-action
        "a"    #'treemacs-create-file
        "A"    #'treemacs-create-dir
        "c"    #'treemacs-copy-file
        "d"    #'treemacs-delete-file
        "r"    #'treemacs-rename-file
        "q"    #'treemacs-quit
        "y"    #'treemacs-copy-relative-path-at-point
        "Y"    #'treemacs-copy-absolute-path-at-point
        "m"    #'treemacs-mark-or-unmark-path-at-point
        )
  )

(map! :leader
      :desc "Toggle Treemacs" "f t" #'+treemacs/toggle)

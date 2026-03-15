{...}: {
  programs.obsidian.defaultSettings = {
    extraFiles.".obsidian.vimrc" = {
      target = "../.obsidian.vimrc";
      text = ''
        " Put this in OBSIDIAN_VAULT/.obsidian.vimrc
        set clipboard=unnamed       " Sync with System Clipboard



        """ Visual mode surrounding

        " {{{ Vim-like Ex commands
        exmap write obcommand editor:save-file
        exmap w obcommand editor:save-file
        exmap quit obcommand workspace:close-tab-group
        exmap q obcommand workspace:close-tab-group
        exmap bprevious obcommand workspace:previous-tab
        exmap bp obcommand workspace:previous-tab
        exmap bnext obcommand workspace:next-tab
        exmap bn obcommand workspace:next-tab
        exmap vsplit obcommand workspace:split-vertical
        exmap split obcommand workspace:split-horizontal
        exmap wincmdh obcommand editor:focus-left
        exmap wincmdi obcommand editor:focus-right
        exmap wincmde obcommand editor:focus-top
        exmap wincmdn obcommand editor:focus-bottom
        exmap bd obcommand workspace:close
        " }}}


        " {{{ User-defined Ex commands
        exmap SpaceKeysLeader obcommand spacekeys:leader
        exmap Reload :source .obsidian.vimrc<CR>
        exmap HistPrev obcommand app:go-back
        exmap HistNext obcommand app:go-forward
        exmap ViewSource obcommand editor:toggle-source
        exmap ViewPreview obcommand markdown:toggle-preview
        exmap PickAny obcommand darlal-switcher-plus:switcher-plus:open
        exmap PickCmd obcommand darlal-switcher-plus:switcher-plus:open-commands
        exmap PickRecent obcommand darlal-switcher-plus:switcher-plus:open-related-items
        exmap FoldToggle obcommand editor:toggle-fold
        exmap FoldLess obcommand editor:fold-less
        exmap FoldMore obcommand editor:fold-more
        exmap FoldAll obcommand editor:fold-all
        exmap UnfoldAll obcommand editor:unfold-all
        exmap BufferDeleteOthers obcommand workspace:close-others
        exmap AddCallout obcommand editor:insert-callout
        exmap AddBold obcommand editor:toogle-bold
        exmap AddItalic obcommand editor:toogle-italic
        exmap AddInternalLink obcommand editor:insert-internal-link
        exmap AddHighlight obcommand editor:toogle-highlight
        exmap Addcode obcommand editor:toogle-code
        exmap Adddel obcommand editor:toogle-strikethrough
        exmap ToggleLeft obcommand app:toggle-left-sidebar
        exmap ToggleRight obcommand app:toggle-right-sidebar
        exmap ToggleRibbon obcommand app:toggle-ribbon
        exmap TogglePin obcommand workspace:toggle-pin
        exmap ToggleStackedTab obcommand workspace:toggle-stacked-tabs
        exmap ThemeSwitch obcommand theme:switch
        exmap UpSkipFold jscommand {view.editor.exec('goUp')}
        exmap DownSkipFold jscommand {view.editor.exec('goDown')}
        "" exmap HeadingPrev jsfile .mdHelpers.js {jumpHeading(true)}
        "" exmap HeadingNext jsfile .mdHelpers.js {jumpHeading(false)}
        "" exmap SmarterIndent jsfile .mdHelpers.js {smarterIndent()}
        exmap FollowLink obcommand editor:follow-link
        exmap SurroundWikiLink surround [[ ]]
        exmap SurroundBold surround ** **
        exmap SurroundItalic surround * *
        exmap SurroundDoubleQuotes surround " "
        exmap SurroundSingleQuotes surround ' '
        exmap SurroundBackticks surround ` `
        exmap SurroundBrackets surround ( )
        exmap SurronudCurlyBrackets surround { }
        "" }}}
        "
        map mL :SurroundWikiLink<CR>
        map m[ :SurroundWikiLink<CR>
        ""nunmap s
        ""vunmap s
        map m" :SurroundDoubleQuotes<CR>
        map m' :SurroundSingleQuotes<CR>
        map m` :SurroundBackticks<CR>
        map mb :SurroundBrackets<CR>
        map m( :SurroundBrackets<CR>
        map m) :SurroundBrackets<CR>
        map m{ :SurronudCurlyBrackets<CR>
        map m} :SurronudCurlyBrackets<CR>

        nnoremap H :bp<CR>
        nnoremap L :bn<CR>
        noremap J 5j
        noremap K 5k
        "" Y to yank to end of line
        "noremap Y y$
        nmap <CR> :FollowLink<CR>
        "nmap >> :SmarterIndent<CR>
        "
        "
        """" g-commands
        "nnoremap gh :HistPrev<CR>
        "nnoremap gl :HistNext<CR>
        "nnoremap gs :ViewSource<CR>
        "nnoremap gp :ViewPreview<CR>
        "" nmap [[ :HeadingPrev<CR>
        "" nmap ]] :HeadingNext<CR>
        "
        "nnoremap za :FoldToggle<CR>
        "" Use Tab to toggle fold, Org Mode style
        nnoremap <Tab> :FoldToggle<CR>
        "imap <Tab> <Esc>:SmarterIndent<CR>i
        nnoremap zr :FoldLess<CR>
        nnoremap zm :FoldMore<CR>
        nnoremap zM :FoldAll<CR>
        nnoremap zR :UnfoldAll<CR>

        vnoremap ~ :Adddel<CR> " Add delete to selection
        vnoremap ` c`<C-r>"`<Esc> " editor:toogle-code is buggy
        vnoremap * :AddBold<CR> " Add bold to selection
        vnoremap _ :AddItalic<CR>   " Add italic to selection
        vnoremap = :AddHighlight<CR> " Add highlight to selection
        vnoremap [ :AddInternalLink<CR> " Add internal link to selection
      '';
    };
  };
}

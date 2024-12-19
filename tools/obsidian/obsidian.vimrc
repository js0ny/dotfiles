" Put this in OBSIDIAN_VAULT/.obsidian.vimrc
set clipboard=unnamed       " Sync with System Clipboard

" Colemak vim-like
noremap n j
noremap e k
noremap i l

" Similar position to i
noremap l i
noremap L I
" ne[k]st
noremap k n
noremap K N
" [j]ump
noremap j e
noremap J E

" Y to yank to end of line
noremap Y y$

""" Visual mode surrounding
exmap addbold obcommand editor:toogle-bold
exmap additalic obcommand editor:toogle-italic
exmap addhighlight obcommand editor:toogle-highlight
exmap addcode obcommand editor:toogle-code
exmap adddel obcommand editor:toogle-strikethrough
vnoremap ~ :adddel<CR> " Add delete to selection
vnoremap ` c`<C-r>"`<Esc> " editor:toogle-code is buggy
vnoremap * :addbold<CR> " Add bold to selection
vnoremap _ :additalic<CR>   " Add italic to selection
vnoremap = :addhighlight " Add highlight to selection

""" Commands
exmap write editor:save-file
exmap w editor:save-file
exmap q workspace:close-tab-group

exmap prevtab obcommand workspace:previous-tab
exmap nexttab obcommand workspace:next-tab
nnoremap H :prevtab<CR>
nnoremap I :nexttab<CR>

exmap prevhist obcommand app:go-back
exmap nexthist obcommand app:go-forward
nnoremap gh :prevhist<CR>
nnoremap gi :nexthist<CR>

exmap reload :source .obsidian.vimrc<CR>

unmap <Space>
exmap vsplit obcommand workspace:split-vertical
exmap hsplit obcommand workspace:split-horizontal
map <Space>| :vsplit<CR>
map <Space>- :hsplit<CR>
" map <Space>bd

exmap chat obcommand obsidian-custom-frames:open-custom-frames-chatgpt
map <Space>ai :chat<CR>



""" g-commands
exmap tsource obcommand editor:toggle-source
exmap tpreview obcommand markdown:toggle-preview
nnoremap gs :tsource<CR>
nnoremap gp :tpreview<CR>

exmap wl obcommand editor:focus-left
exmap wr obcommand editor:focus-right
exmap wt obcommand editor:focus-top
exmap wb obcommand editor:focus-bottom

map <Space>h :wl<CR>
map <Space>i :wr<CR>
map <Space>n :wb<CR>
map <Space>e :wt<CR>

exmap FoldToggle obcommand editor:toggle-fold
exmap FoldLess obcommand editor:fold-less
exmap FoldMore obcommand editor:fold-more
exmap FoldAll obcommand editor:fold-all
exmap UnfoldAll obcommand editor:unfold-all
nnoremap za :FoldToggle<CR>
nnoremap zr :FoldLess<CR>
nnoremap zm :FoldMore<CR>
nnoremap zM :FoldAll<CR>
nnoremap zR :UnfoldAll<CR>

exmap switchany obcommand darlal-switcher-plus:switcher-plus:open
exmap switchcmd obcommand darlal-switcher-plus:switcher-plus:open-commands
exmap switchrecent obcommand darlal-switcher-plus:switcher-plus:open-related-items
map <Space><Space> :switchany<CR>
map <Space>: :switchcmd<CR>
map <Space>fr :switchrecent<CR>

" <leader>b : +buffer
exmap bd obcommand
exmap DeleteOthers obcommand workspace:close-others
map <Space>bd :bd<CR>
map <Space>bX :DeleteOthers<CR>

" <leader>m : +major/markdown
exmap addCallout obcommand editor:insert-callout
map <Space>mb :addbold<CR>
map <Space>mi :additalic<CR>
map <Space>mc :addcode<CR>
map <Space>md :adddel<CR>
map <Space>mh :addhighlight<CR>
map <Space>mp :tpreview<CR>
map <Space>mo :addCallout<CR>

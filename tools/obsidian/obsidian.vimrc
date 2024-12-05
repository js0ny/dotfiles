" Put this in OBSIDIAN_VAULT/.obsidian.vimrc
set clipboard=unnamed       " Sync with System Clipboard

" Word wrap
noremap n gj
noremap e gk
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

exmap prevtab obcommand workspace:previous-tab
exmap nexttab obcommand workspace:next-tab
nnoremap H :prevtab<CR>
nnoremap I :nexttab<CR>

exmap reload :source .obsidian.vimrc<CR>

unmap <Space>
exmap vsplit obcommand workspace:split-vertical
exmap hsplit obcommand workspace:split-horizontal
map <Space>| :vsplit<CR>
map <Space>- :hsplit<CR>
" map <Space>bd

exmap chat obcommand obsidian-custom-frames:open-custom-frames-chatgpt
map <Space>ai :chat<CR>

exmap omnisearch obcommand omnisearch:show-modal
map <Space><Space> :omnisearch<CR>

exmap command-palette obcommand command-palette:open
map <Space>: :command-palette<CR>

""" g-commands
exmap tsource obcommand editor:toggle-source
nnoremap gs :tsource<CR>

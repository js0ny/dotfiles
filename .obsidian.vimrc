" Put this in OBSIDIAN_VAULT/.obsidian.vimrc

" Colemak 方向键映射 (hnei）
nnoremap k n
nnoremap K N
nnoremap j e
vnoremap j e
nnoremap l i
nnoremap N J
nnoremap E K
nnoremap I L
nnoremap J E
vnoremap J E
nnoremap L I
nnoremap k n
nnoremap K N
nnoremap j e
vnoremap j e
nnoremap l i
nnoremap N J
nnoremap E K
nnoremap I L
nnoremap J E
vnoremap J E
nnoremap L I
" 方向键映射
noremap n <Down>     " 向下
noremap e <Up>       " 向上
noremap i <Right>    " 向右


""" Word wrap cursor movement
nmap j gj
nmap k gk

nmap Y y$                   " Use Y to yank to the EOL

set clipboard=unnamed       " Sync with System Clipboard

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
map <Space>bd 

exmap chat obcommand obsidian-custom-frames:open-custom-frames-chatgpt
map <Space>ai :chat<CR>

exmap omnisearch obcommand omnisearch:show-modal
map <Space><Space> :omnisearch<CR>

""" g-commands
exmap tsource obcommand editor:toggle-source
nnoremap gs :tsource<CR>

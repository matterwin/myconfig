let mapleader = " "

set relativenumber
set number

" Map Ctrl+s to save the file
nnoremap <C-s> :w<CR>

" window "
set splitbelow
nnoremap <leader>t :term<CR>

" Map Ctrl+h/j/k/l to move between windows
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Map Ctrl+h/j/k/l to move between windows in terminal mode
tnoremap <C-h> <C-w>h
tnoremap <C-j> <C-w>j
tnoremap <C-k> <C-w>k
tnoremap <C-l> <C-w>l

" Map <leader>v to open a vertical split "
nnoremap <leader>v :vsplit<CR>

" Map <leader>h to open a horizontal split "
nnoremap <leader>h :split<CR>

" Ctrl+arrow keys for window resize "
nnoremap <C-Up> :resize +5<CR>
nnoremap <C-Down> :resize -5<CR>
nnoremap <C-Right> :vertical resize +5<CR>
nnoremap <C-Left> :vertical resize -5<CR>

" Tabs "
set expandtab
set tabstop=4
set shiftwidth=4
set softtabstop=4 

" Shift lines up and down in normal mode
nnoremap <S-k> :move .-2<CR>
nnoremap <S-j> :move .+1<CR>

" Shift lines left and right in normal mode
nnoremap <S-h> <<
nnoremap <S-l> >>


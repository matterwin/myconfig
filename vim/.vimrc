" --------------------------------------- "
" Installs

" To install Vim with GTK3 on a new machine, run these commands:
" sudo add-apt-repository ppa:jonathonf/vim
" sudo apt update
" sudo apt install vim-gtk3



" --------------------------------------- "
" Plugins "

" NERDTree configuration "
" Check if NERDTree is installed, if not, clone it
if !isdirectory(expand('~/.vim/pack/plugins/start/nerdtree'))
  silent !git clone https://github.com/preservim/nerdtree.git ~/.vim/pack/plugins/start/nerdtree
endif

let NERDTreeShowHidden=1
map <C-n> :NERDTreeToggle<CR>
" Map Tab to go to the next tab
map <Tab> :tabnext<CR>
" Map Shift+Tab to go to the previous tab
map <S-Tab> :tabprevious<CR>
autocmd VimLeave * NERDTreeClose



" Clipboard "
set clipboard=unnamedplus



" --------------------------------------- "
" MAPPINGS AND SETTINGS VIM"
let mapleader = " "

set relativenumber
set number

syntax on
set mouse=a

" Visuals "
set ruler
set laststatus=2

" Define Highlight Groups
hi User1 ctermfg=Yellow
hi User2 ctermfg=Red
hi User3 ctermfg=Magenta
hi User4 ctermfg=Green
hi User5 ctermfg=Yellow

" Set up Statusline with Colors
set statusline=
set statusline+=%1*%#User1#\ %n\ %*             " buffer number with User1 color
set statusline+=%5*%#User2#%{&ff}%*             " file format with User2 color
set statusline+=%3*%#User3#%y%*                 " file type with User3 color
set statusline+=%4*\ %<%F%*                     " full path
set statusline+=%2*%#User4#%m%*                 " modified flag with User4 color
set statusline+=%1*%=%3l/%L\ (%p%%)%*           " current line / total lines, percentage
set statusline+=%2*%#User5#%4v\ %*              " virtual column number with User5 color
set statusline+=%2*0x%04B\ %*                   " character under cursor


" Map Ctrl+s to save the file
nnoremap <C-s> :w<CR>

" Highlights "
highlight Visual ctermbg=yellow guibg=yellow

" window "
set splitbelow
nnoremap <leader>t :term<CR>

nnoremap <C-q><C-q> :q<CR>

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

" Shift lines up and down in visual mode (selected lines)
vnoremap <S-k> :move '<-2<CR>gv
vnoremap <S-j> :move '>+1<CR>gv

" Shift lines left and right in visual mode (selected lines)
vnoremap <S-h> <gv
vnoremap <S-l> >gv

function! CommentLine()
  if &filetype == 'python' || &filetype == 'bash'
    execute 'normal! I# '
  elseif &filetype == 'c' || &filetype == 'cpp' || &filetype == 'java'
    execute 'normal! I// '
  elseif &filetype == 'lua'
    execute 'normal! I-- '
  elseif &filetype == 'ruby'
    execute 'normal! I# '
  elseif &filetype == 'javascript' || &filetype == 'typescript'
    execute 'normal! I// '
  elseif &filetype == 'html' || &filetype == 'xml'
    execute 'normal! <!-- '
  else
    echo "Unsupported filetype"
  endif
endfunction
nnoremap <leader>/ :call CommentLine()<CR>

inoremap <C-h> <Left>
inoremap <C-j> <Down>
inoremap <C-k> <Up>
inoremap <C-l> <Right>


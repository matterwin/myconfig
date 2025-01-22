" --------------------------------------- "
" Installs

" To install Vim with GTK3 on a new machine, run these commands:
" sudo add-apt-repository ppa:jonathonf/vim
" sudo apt update
" sudo apt install vim-gtk3


" Plugins --------------------------------------- "

" PlugInstall --------------------
call plug#begin('~/.vim/plugged')
Plug 'powerline/powerline'
Plug 'christoomey/vim-tmux-navigator'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'preservim/nerdtree'
Plug 'justinmk/vim-sneak'
Plug 'tpope/vim-commentary'
call plug#end()


" Powerline settings
if has('python3')
    python3 from powerline.vim import setup
    python3 setup()
else
    echo "Powerline requires Python 3. Please install Python 3."
endif
set rtp+=~/.vim/pack/plugins/start/powerline
set laststatus=2

" fzf
" Keybinding for fuzzy file search
nnoremap <C-p> :Files<CR>
" Keybinding for searching lines within the current buffer
nnoremap <C-f> :Lines<CR>
" Fuzzy buffer search with Ctrl+b
nnoremap <C-b> :Buffers<CR>
let g:fzf_layout = { 'down': '40%' }




" vim-tmux-navigator configuration
let g:tmux_navigator_no_mappings = 1
nnoremap <C-h> :TmuxNavigateLeft<CR>
nnoremap <C-j> :TmuxNavigateDown<CR>
nnoremap <C-k> :TmuxNavigateUp<CR>
nnoremap <C-l> :TmuxNavigateRight<CR>




" vim-sneak
let g:sneak#label = 1



" vim-commentary
filetype plugin indent on
nnoremap <C-/> gcc
" nnoremap <C-/> gc
" vnoremap <C-/> gcc
" vnoremap <C-/> gc


" nerdtree
let NERDTreeShowHidden=1
map <C-n> :NERDTreeToggle<CR>


" --------------------------------


" MAPPINGS AND SETTINGS VIM"
let mapleader = " "

set relativenumber
set number

syntax on
set mouse=a

" Go to next tab
nnoremap <Tab> :tabnext<CR>
" Go to previous tab
nnoremap <S-Tab> :tabprevious<CR>

" Visuals "
set fillchars=eob:\ 

" Define Highlight Groups
" hi User1 ctermfg=Yellow
" hi User2 ctermfg=Red
" hi User3 ctermfg=Magenta
" hi User4 ctermfg=Green
" hi User5 ctermfg=Yellow
" hi StatusLine ctermbg=8 ctermfg=darkblue
" hi StatusLineNC ctermbg=8 ctermfg=Grey

" Clipboard "
set clipboard=unnamedplus

set ruler
" Set up Statusline with Colors
" set statusline=
" set statusline+=%1*%#User1#\ %n\ %*             " buffer number with User1 color
" set statusline+=%5*%#User2#%{&ff}%*             " file format with User2 color
" set statusline+=%3*%#User3#%y%*                 " file type with User3 color
" set statusline+=%4*\ %<%F%*                     " full path
" set statusline+=%2*%#User4#%m%*                 " modified flag with User4 color
" set statusline+=%1*%=%3l/%L\ (%p%%)%*           " current line / total lines, percentage
" set statusline+=%2*%#User5#%4v\ %*              " virtual column number with User5 color
" set statusline+=%2*0x%04B\ %*                   " character under cursor
 
" Map Ctrl+s to save the file
nnoremap <C-s> :w<CR>

" Highlights "
" highlight Visual ctermbg=black guibg=black

" window "
set splitbelow
set splitright
set noswapfile

" I use tmux now
" Map Ctrl+h/j/k/l to move between windows
" nnoremap <C-h> <C-w>h
" nnoremap <C-j> <C-w>j
" nnoremap <C-k> <C-w>k
" nnoremap <C-l> <C-w>l

" Map Ctrl+h/j/k/l to move between windows in terminal mode
" tnoremap <C-h> <C-w>h
" tnoremap <C-j> <C-w>j
" tnoremap <C-k> <C-w>k
" tnoremap <C-l> <C-w>l

" Terminal"
nnoremap <leader>t :below term<CR>
nnoremap <leader>g :above term<CR>


" Exit terminal mode to traverse like in vim "
tnoremap <Esc><Esc> <C-\><C-n>
tnoremap <ScrollWheelUp> <C-\><C-n>
tnoremap <ScrollWheelDown> <C-\><C-n>
autocmd TerminalOpen * setlocal nonumber norelativenumber laststatus=0


nnoremap <C-q><C-q> :q<CR>

nnoremap <leader>h :split<CR>
nnoremap <leader>j :vsplit<CR>
nnoremap <leader>k :split<CR>
nnoremap <leader>l :vsplit<CR>


" Ctrl+arrow keys for window resize "
nnoremap <C-Up> :resize +2<CR>
nnoremap <C-Down> :resize -2<CR>
nnoremap <C-Right> :vertical resize +2<CR>
nnoremap <C-Left> :vertical resize -2<CR>

" Tabs "
set expandtab
set tabstop=4
set shiftwidth=4
set softtabstop=4 




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
vnoremap <leader>/ :call CommentLine()<CR>

" inoremap <C-h> <Left>
" inoremap <C-j> <Down>
" inoremap <C-k> <Up>
" inoremap <C-l> <Right>

nnoremap 9 $


" --------------------------------------- "
" Installs

" To install Vim with GTK3 on a new machine, run these commands:
" sudo add-apt-repository ppa:jonathonf/vim
" sudo apt update
" sudo apt install vim-gtk3


" Plugins --------------------------------------- "
"
" Must have plugins
" Plug 'christoomey/vim-tmux-navigator'
" Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
" Plug 'junegunn/fzf.vim'
" Plug 'rking/ag.vim'
" Plug 'farmergreg/vim-lastplace'
" Plug 'preservim/nerdtree'

" Lsp plugins
" Plug 'prabirshrestha/vim-lsp'
" Plug 'mattn/vim-lsp-settings'
" Plug 'prabirshrestha/asyncomplete.vim'
" Plug 'prabirshrestha/asyncomplete-lsp.vim'




" PlugInstall --------------------
call plug#begin('~/.vim/plugged')
Plug 'christoomey/vim-tmux-navigator'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'preservim/nerdtree'
Plug 'justinmk/vim-sneak'
Plug 'tpope/vim-commentary'
Plug 'rking/ag.vim'
Plug 'farmergreg/vim-lastplace'
Plug 'catppuccin/nvim', { 'as': 'catppuccin' }
Plug 'itchyny/lightline.vim'
" Plug 'altercation/vim-colors-solarized'
Plug 'morhetz/gruvbox'
Plug 'itchyny/vim-gitbranch'

" Lsp plugins
Plug 'prabirshrestha/vim-lsp'
Plug 'mattn/vim-lsp-settings'
Plug 'prabirshrestha/asyncomplete.vim'
Plug 'prabirshrestha/asyncomplete-lsp.vim'
call plug#end()
" ---------------------------------

"" Vim Lsp:
filetype plugin on
" copied (almost) directly from the vim-lsp docs:
function! s:on_lsp_buffer_enabled() abort
    setlocal omnifunc=lsp#complete
    if exists('+tagfunc') | setlocal tagfunc=lsp#tagfunc | endif

    let g:lsp_format_sync_timeout = 1000
    autocmd! BufWritePre *.rs,*.go call execute('LspDocumentFormatSync')
endfunction

augroup lsp_install
    au!
    " call s:on_lsp_buffer_enabled (set the lsp shortcuts) when an lsp server
    " is registered for a buffer.
    autocmd User lsp_buffer_enabled call s:on_lsp_buffer_enabled()
augroup END

" Keybindings for LSP features
nnoremap gd :LspDefinition<CR>
nnoremap K :LspHover<CR>
nnoremap gr :LspReferences<CR>
nnoremap <leader>rn :LspRename<CR>
nnoremap <leader>e :LspDiagnostic<CR>
nnoremap <leader>f :LspFormat<CR>
nnoremap ]d :LspDiagnosticNext<CR>
nnoremap [d :LspDiagnosticPrev<CR>
let g:lsp_diagnostics_enabled = 0
let g:lsp_signs_enabled = 0
set signcolumn=no
set foldcolumn=0

set laststatus=2

" lightline.vim
let g:lightline = {
      \ 'colorscheme': 'wombat',
      \ 'active': {
      \ 'left': [ [ 'mode', ],
      \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ],
      \ 'right': [ [ 'lineinfo' ],
      \              [ 'percent' ],
      \              [ 'fileformat', 'fileencoding', 'filetype', 'charvaluehex' ] ]
      \ },
      \ 'component': {
      \   'charvaluehex': '0x%B'
      \ },
      \ 'component_function': {
      \   'gitbranch': 'gitbranch#name',
      \   'filename': 'LightlineFilename'
      \ },
      \ }

function! LightlineFilename()
  return &filetype ==# 'vimfiler' ? vimfiler#get_status_string() :
        \ &filetype ==# 'unite' ? unite#get_status_string() :
        \ &filetype ==# 'vimshell' ? vimshell#get_status_string() :
        \ LightlineTruncatePath(expand('%:p'))
endfunction

function! LightlineTruncatePath(fullpath)
  if empty(a:fullpath)
    return '[No Name]'
  endif

  " Split path into parts
  let pathParts = split(a:fullpath, '/')

  " Only trim if there are more than 4 parts
  return len(pathParts) > 4 ? join(pathParts[-4:], '/') : a:fullpath
endfunction

let g:unite_force_overwrite_statusline = 0
let g:vimfiler_force_overwrite_statusline = 0
let g:vimshell_force_overwrite_statusline = 0


" Get rid of ^M chars after pasting
" :%s/\r//g



" fzf
" Keybinding for fuzzy file search
nnoremap <C-p> :Files<CR>
" Keybinding for searching lines within the current buffer
nnoremap <C-f> :Lines<CR>
" Fuzzy buffer search with Ctrl+b
nnoremap <C-b> :Buffers<CR>
let g:fzf_layout = { 'down': '60%' }
command! -bang -nargs=* Tags
    \ call fzf#vim#tags('', fzf#vim#with_preview(), <bang>0)




" vim-tmux-navigator configuration
let g:tmux_navigator_no_mappings = 1
nnoremap <C-h> :TmuxNavigateLeft<CR>
nnoremap <C-j> :TmuxNavigateDown<CR>
nnoremap <C-k> :TmuxNavigateUp<CR>
nnoremap <C-l> :TmuxNavigateRight<CR>


" vim-sneak
let g:sneak#label = 1


" ag.vim
" Used to searching for words in files fast
" Need this to ag
" brew install the_silver_searcher
nnoremap <C-g> :Ag<CR>
nnoremap <C-g> :silent Ag<CR>

" vim-commentary
filetype plugin indent on
" gcc

" nerdtree
let NERDTreeShowHidden=1
map <C-n> :NERDTreeToggle<CR>


" --------------------------------


" MAPPINGS AND SETTINGS VIM"
let mapleader = " "

set relativenumber
set number

syntax on

set nopaste
" highlight Visual guifg=#FFFFFF guibg=#111111

" Go to next tab
nnoremap <Tab> :tabnext<CR>
" Go to previous tab
nnoremap <S-Tab> :tabprevious<CR>
nnoremap < <cmd>bprev<CR>
nnoremap > <cmd>bprev<CR>

" Visuals "
" set fillchars=eob:\ 
" hi MatchParen cterm=bold ctermbg=none ctermfg=yellow

" Define Highlight Groups
" hi User1 ctermfg=White
" hi User2 ctermfg=Red
" hi User3 ctermfg=Magenta
" hi User4 ctermfg=Green
" hi User5 ctermfg=Yellow
" hi StatusLine ctermbg=8 ctermfg=DarkRed
" hi StatusLineNC ctermbg=8 ctermfg=Red

" function! GitBranch()
"   let branch = system('git rev-parse --abbrev-ref HEAD')
"   return substitute(branch, '\n', '', 'g')
" endfunction

" Add the branch name to the statusline

" Clipboard "
set clipboard=unnamedplus
" Gets rid of blackhole copying from pasting
vnoremap p "_dP

" Set up Statusline with Colors
" set statusline=
" set statusline=%{GitBranch()}%*
" set statusline+=%3*%#User1#\ %n\ %*             " buffer number with User1 color
" set statusline+=%5*%#User2#%{&ff}36%*             " file format with User2 color
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

nnoremap <C-q><C-q> :q<CR>

nnoremap <leader>h :split<CR>
nnoremap <leader>j :vsplit<CR>
nnoremap <leader>k :split<CR>
nnoremap <leader>l :vsplit<CR>


" Ctrl+arrow keys for window resize "
nnoremap <C-Up> :resize +2<CR>
nnoremap <C-Down> :resize -2<CR>
nnoremap <C-Right> :vertical resize -2<CR>
nnoremap <C-Left> :vertical resize +2<CR>

" Tabs "
set expandtab
set tabstop=4
set shiftwidth=4
set softtabstop=4
set smarttab
set autoindent
set smartindent
set backspace=indent,eol,start

" Shift lines up and down in visual mode (selected lines)
vnoremap <S-k> :move '<-2<CR>gv
vnoremap <S-j> :move '>+1<CR>gv

" Shift lines left and right in visual mode (selected lines)
vnoremap <S-h> <gv
vnoremap <S-l> >gv

" inoremap <C-h> <Left>
" inoremap <C-j> <Down>
" inoremap <C-k> <Up>
" inoremap <C-l> <Right>

nnoremap 9 $

" set cursorline
" set termguicolors
" syntax on

" let g:catppuccin_flavour = 'frappe'  " Use the 'frappe' flavour for darker background
" let g:catppuccin_background = 'dark'  " Set the background to dark
" let g:catppuccin_transparent_background = 0  " Disable transparent background
" let g:catppuccin_dim_inactive = 1  " Disable dimming of inactive windows
" let g:catppuccin_no_bold = 1  " Allow bold text
" let g:catppuccin_no_italic = 0  " Allow italic text
" colorscheme catppuccin

syntax enable
set background=dark

" Enable Gruvbox customizations
let g:gruvbox_italic=0
let g:gruvbox_bold=1
let g:gruvbox_underline=1
let g:gruvbox_undercurl=1
let g:gruvbox_invert_selection=0  " Don't invert selection
let g:gruvbox_transparent_bg=0    " Transparent mode
let g:gruvbox_contrast_dark="soft"  " Contrast can be 'hard', 'medium', or 'soft'

autocmd ColorScheme gruvbox hi Comment ctermfg=gray

colorscheme gruvbox


set mouse=a
" set ttymouse=


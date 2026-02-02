"source ~/.vimrc
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

Plug 'michaeljsmith/vim-indent-object'

" Aesthetics
Plug 'catppuccin/nvim', { 'as': 'catppuccin' }
Plug 'itchyny/lightline.vim'
" Plug 'altercation/vim-colors-solarized'
Plug 'morhetz/gruvbox'
Plug 'itchyny/vim-gitbranch'
Plug 'NLKNguyen/papercolor-theme'
Plug 'crusoexia/vim-monokai'
Plug 'Yggdroot/indentLine'
Plug 'nathanaelkane/vim-indent-guides'

" Academic
Plug 'lervag/vimtex'

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

if executable('rust-analyzer')
	au User lsp_setup call lsp#register_server({
		\ 'name': 'rust-analyzer',
		\ 'cmd': {server_info->['rust-analyzer']},
		\ 'whitelist': ['rust'],
	\ })
endif

if executable('clangd')
    au User lsp_setup call lsp#register_server({
        \ 'name': 'clangd',
        \ 'cmd': ['clangd', '--header-insertion=never'],
        \ 'whitelist': ['c', 'cpp'],
    \ })
endif

if executable('pylsp')
    " pip install python-lsp-server
    au User lsp_setup call lsp#register_server({
        \ 'name': 'pylsp',
        \ 'cmd': {server_info->['pylsp']},
        \ 'allowlist': ['python'],
        \ })
endif

" Keybindings for LSP features
nnoremap gd :LspDefinition<CR>
nnoremap gD :LspDeclaration<CR>
nnoremap gi <plug>(lsp-implementation)
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

function! ToggleLspDiagnostics()
  if g:lsp_signs_enabled
    " Hide signs
    let g:lsp_signs_enabled = 0
    set signcolumn=no
    echom "LSP Diagnostics UI OFF"
    " Clear signs but keep diagnostics running
    silent! execute('sign unplace * group=lsp')
  else
    " Show signs
    let g:lsp_signs_enabled = 1
    set signcolumn=yes
    echom "LSP Diagnostics UI ON"
    " Refresh diagnostics UI (signs)
    silent! call lsp#diagnostics#refresh()
  endif
endfunction

nnoremap <C-w> :call ToggleLspDiagnostics()<CR>


" Aesthetics
set hlsearch

set laststatus=2

set backspace=indent,eol,start

" VimTeX settings
let g:tex_flavor='latex'
let g:vimtex_view_method='zathura'
let g:vimtex_quickfix_mode=0
set conceallevel=0
let g:tex_conceal='abdmg'
let g:vimtex_mappings_enabled = 0
let g:vimtex#digestif#enabled = 0

nnoremap <C-_> :VimtexCompile<CR>
nnoremap <F6> :VimtexView<CR>
" sudo apt install texlive-latex-base latexmk zathura zathura-pdf-poppler
" To compile: latexmk -pdf main.tex or pdflatex main.tex
" To view pdf: zathura main.pdf & or explorer.exe main.pdf (this is for wsl)

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

  let pathParts = split(a:fullpath, '/')

  " Only trim if there are more than 2 parts
  return len(pathParts) > 2 ? join(pathParts[-2:], '/') : a:fullpath
endfunction

let g:unite_force_overwrite_statusline = 0
let g:vimfiler_force_overwrite_statusline = 0
let g:vimshell_force_overwrite_statusline = 0


" Get rid of ^M chars after pasting
" :%s/\r//g

xnoremap u <Nop>

" fzf
" Keybinding for fuzzy file search
nnoremap <C-f> :Files<CR>
nnoremap <C-p> :Lines<CR>
nnoremap <C-b> :Buffers<CR>
nnoremap <C-g> :Ag<CR>
" nnoremap <C-t> :Tags<CR>

let g:fzf_layout = { 'down': '60%' }

" command! -bang -nargs=* Tags
"     \ call fzf#vim#tags('', fzf#vim#with_preview(), <bang>0)

" ctags -R .

" vim-tmux-navigator configuration
let g:tmux_navigator_no_mappings = 1
nnoremap <C-h> :TmuxNavigateLeft<CR>
nnoremap <C-j> :TmuxNavigateDown<CR>
nnoremap <C-k> :TmuxNavigateUp<CR>
nnoremap <C-l> :TmuxNavigateRight<CR>

tnoremap <C-h> <C-\><C-n><C-w>h
tnoremap <C-j> <C-\><C-n><C-w>j
tnoremap <C-k> <C-\><C-n><C-w>k
tnoremap <C-l> <C-\><C-n><C-w>l

" vim-sneak
let g:sneak#label = 1

" ag.vim
" Used to searching for words in files fast
" Need this to ag
" brew install the_silver_searcher
nnoremap <C-g> :Ag<CR>
" nnoremap <C-g> :silent Ag<CR>

" command! -nargs=+ Ag
"       \ call fzf#vim#grep(
"       \   'ag --vimgrep --no-heading --smart-case '.shellescape(<q-args>), 1,
"       \   {'options': '--ansi'}, 0)

" nnoremap <C-g> :call fzf#vim#grep('ag --vimgrep --no-heading --smart-case '.input('Ag: '), 1, {'options':'--ansi'}, 0)<CR>

"Switched from Ag to Rg
" nnoremap <C-g> :Rg<Space>
nnoremap <leader>rr :Rg<Space>


" vim-commentary
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

" Tabs
nnoremap <C-Left>  :tabprevious<CR>
nnoremap <C-Right> :tabnext<CR>
nnoremap <Tab> <Nop>

" Buffers (jump list style)
nnoremap <C-I> <C-I>   " jump forward
nnoremap <C-O> <C-O>   " jump back

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

" Terminal splits by direction
nnoremap <leader>th :leftabove  vert term<CR>   " left
nnoremap <leader>tl :rightbelow vert term<CR>   " right
nnoremap <leader>tj :belowright term<CR>        " down
nnoremap <leader>tk :aboveleft  term<CR>        " up

"ctrl+t - exit terminal
" tnoremap <C-t> <C-\><C-n>
tnoremap <C-\> <C-\><C-n>
" tnoremap <ScrollWheelUp> <C-\><C-n>
" tnoremap <ScrollWheelDown> <C-\><C-n>

" nnoremap <C-q><C-q> :q<CR>

nnoremap <leader>h :split<CR>
nnoremap <leader>j :vsplit<CR>
nnoremap <leader>k :split<CR>
nnoremap <leader>l :vsplit<CR>

" Resize splits with Ctrl + Shift + Arrows
nnoremap <C-S-Up>    :resize +2<CR>
nnoremap <C-S-Down>  :resize -2<CR>
nnoremap <C-S-Right> :vertical resize -2<CR>
nnoremap <C-S-Left>  :vertical resize +2<CR>

" Tabs "
filetype on
filetype plugin indent on
filetype indent on
set expandtab
set shiftwidth=4
set tabstop=4
set softtabstop=4
set smarttab
set autoindent
set smartindent

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
nnoremap dd "_dd
vnoremap d "_d

set cursorline
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

" Dark mode -- Gruvbox
set background=dark

" Enable Gruvbox customizations
let g:gruvbox_italic=0
let g:gruvbox_bold=1
let g:gruvbox_underline=1
let g:gruvbox_undercurl=1
let g:gruvbox_invert_selection=0  " Don't invert selection
let g:gruvbox_transparent_bg=0    " Transparent mode
let g:gruvbox_contrast_dark="soft"  " Contrast can be 'hard', 'medium', or 'soft'

" For transparent bg
" autocmd VimEnter * hi Normal guibg=NONE ctermbg=NONE
" autocmd VimEnter * hi NormalNC guibg=NONE ctermbg=NONE
" autocmd VimEnter * hi SignColumn guibg=NONE ctermbg=NONE
" autocmd VimEnter * hi VertSplit guibg=NONE ctermbg=NONE
" autocmd VimEnter * hi LineNr guibg=NONE ctermbg=NONE
" autocmd VimEnter * hi EndOfBuffer guibg=NONE ctermbg=NONE

autocmd ColorScheme gruvbox hi Comment ctermfg=gray

colorscheme gruvbox

" syntax on
" colorscheme monokai

" Light mode -- PaperColor
" set background=light
" set t_Co=256
" colorscheme PaperColor

set mouse=a
" set ttymouse=

" Yggdroot/indentLine
let g:indentLine_enabled        = 0      " enable indent lines
let g:indentLine_setColors      = 1      " enable colors
let g:indentLine_showFirstIndentLevel = 1 " show first indent

" tabs
nnoremap <Leader>n :tabnew<CR>
nnoremap <Leader>s :tab split<CR>

" find and replace
nnoremap <leader>r :%s/
" nnoremap <leader>r :%s/old/new/gc

" Make Esc behave like Ctrl-C everywhere
inoremap <Esc> <C-c>
vnoremap <Esc> <C-c>
snoremap <Esc> <C-c>
cnoremap <Esc> <C-c>
onoremap <Esc> <C-c>

" Reduce delays for terminal escape sequences
set ttimeout
set ttimeoutlen=10
set notimeout

" nathanaelkane/vim-indent-guides
" let g:indent_guides_enable_on_vim_startup = 1
" let g:indent_guides_start_level = 1
" let g:indent_guides_guide_size = 1
" let g:indent_guides_draw_blank = 1
"

" nnoremap <leader>tl :colorscheme PaperColor<CR>
" nnoremap <leader>td :colorscheme gruvbox<CR>

" nnoremap <leader>bd :set background=dark<CR>
" nnoremap <leader>bl :set background=light<CR>

" ---------- Helpful vim shortcuts ----------

" 1. Cursor pointer control
"
" g; and g, to move forward and backward through edit locations
" Ctrl+i and Ctrl+o to move forward and backward through the jump list
" `` and '' to swap between the last jump list positions
"
" zz - to move pov in middle of screen
" zt - to move pov in top of screen
"
" :%s/old/new/g       Replace all occurrences of 'old' with 'new' in entire file
" :s/old/new/g        Replace all occurrences of 'old' with 'new' in current line
" :%s/old/new/gi      Replace all occurrences, case-insensitive, entire file
" :%s/old/new/gc      Replace all occurrences with confirmation prompt
" :10,20s/old/new/g   Replace between lines 10 and 20

" -- Confirmation in gc mode --
" y    Yes, replace this match
" n    No, skip this match
" a    Replace all remaining without asking
" q    Quit substitution
" l    Replace this and quit

" -- Visual mode replace --
" 1. Select text in visual mode (v)
" 2. Press ':'
" 3. Type s/old/new/g and Enter

" . - Repeat last substitution command
" ce - when you want to replace the rest of a word.
" cw - when editing mid-word OR editing whitespace.
"
" ciw  - change word under cursor; enter insert mode
" caW  - change around WORD; includes surrounding whitespace, enter insert mode
" ci(  - change inside parentheses
" ca(  - change around parentheses (includes the parentheses)
" cib  - change inside parentheses (balanced)
" ci{  - change inside braces
" ca{  - change around braces (includes the braces)
" ci[  - change inside brackets
" ca[  - change around brackets (includes the brackets)
" ci"  - change inside double quotes
" ca"  - change around double quotes (includes the quotes)
" ci'  - change inside single quotes
" ca'  - change around single quotes (includes the quotes)

" viw  - visually select word under cursor
" vaw  - visually select a word (includes surrounding whitespace)
" diw  - delete word under cursor; stay in normal mode
" diW  - delete WORD (to surrounding whitespace)
" dw   - delete from cursor to end of word

" vii  - visually select current indent block
" cii  - change current indent block
" dii  - delete current indent block
" cai  - change around indent block (includes the surrounding indent)

" c - change (delete text, then enter insert mode)
" d - delete (delete text, stay in normal mode)
" v - visual select (highlight text)
" y - yank (copy text)
" p - paste yanked or deleted text

" c and d are basically the same, c moves you into insert mode
" i vs a - 'i' = inside the object, 'a' = around the object (includes delimiters)
" this can be used with c, d, v, y, etc.
"
" d$ - delete from cursor to end of line

" ctrl+q - gives visual block (i.e. like duplicated cursors) 
" v + ctrl+q - gives column block selection
"
" ctrl + d - scroll down with key
" ctrl + u - scroll up with key
" Shift + w - move to next continuous word
" Shift + e - move to next end of continuous word (basically like w/b/e but can
" just to next whitespace)
"
" f + character - targeted character jumps
" ; to go to next instance of target
" , to go back to previous instance
"
" v + i + b - visual inside block
" v + i " - visual inside quotes
" v + i + [ - visual inside bracket, etc
" v + i + { - visual inside braces
"
" v + a + ... - visual around it
"
" / + word - search for word
" * - search for word in cursor
"
" ctrl + q + I + type your changes + esc + esc - gives you multiple line
" change for insertion (visual block mode)
"
" " ctrl + q + x - gives you multiple line
" change for deletion (visual block mode)
"
" " ctrl + q + I + type your changes + esc + esc - gives you multiple line
" change for insertion (visual block mode)
"
" shift + d - delete till the end of line
" shift + c to delete whole line and go into insert mode
"
" d + f + character - delets from cursor up to character inclusive

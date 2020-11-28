let mapleader =","

if ! filereadable(expand('~/.config/nvim/autoload/plug.vim'))
	echo "Downloading junegunn/vim-plug to manage plugins..."
	silent !mkdir -p ~/.config/nvim/autoload/
	silent !curl "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim" > ~/.config/nvim/autoload/plug.vim
endif

call plug#begin('~/.config/nvim/plugged')
Plug 'puremourning/vimspector'
" syntax
Plug 'PotatoesMaster/i3-vim-syntax'
Plug 'kovetskiy/sxhkd-vim'
" other
Plug 'jreybert/vimagit'
Plug 'vimwiki/vimwiki'
" file browser
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
" surround text
Plug 'tpope/vim-surround'
" better powerline
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
" highlight yank area
Plug 'machakann/vim-highlightedyank'
" automatically change into root directory
Plug 'airblade/vim-rooter'
" completion
Plug 'neoclide/coc.nvim', {'branch': 'release'}
" semantic highlighting
Plug 'jackguo380/vim-lsp-cxx-highlight'
" {}, [], etc.
Plug 'jiangmiao/auto-pairs'
Plug 'scrooloose/nerdcommenter'
Plug 'tmhedberg/SimpylFold'
call plug#end()

for f in glob('~/.config/nvim/configs/*.vim', 0, 1)
	execute 'source' f
endfor

let g:vimspector_enable_mappings = 'HUMAN'

" Turn off swap files
set noswapfile
set nobackup
set nowb

" Behaviour when files get changed outside of vim
set autoread
autocmd FocusGained,BufEnter,CursorHold,CursorHoldI * if mode() != 'c' | checktime | endif
autocmd FileChangedShellPost *
\ echohl WarningMsg | echo "File changed on disk. Buffer reloaded." | echohl None

" Folding
set foldmethod=indent   "fold based on indent
set foldnestmax=3       "deepest fold is 3 levels
set nofoldenable        "dont fold by default

" Misc
set showcmd
set bg=light
set mouse=a
set clipboard+=unnamedplus " use clipboard for all operations
set scrolloff=8
filetype plugin indent on
syntax on
set guicursor=
set mat=0
set showmatch
set completeopt-=preview
set timeoutlen=300
set nojoinspaces
" set termguicolors

" Encoding
if &encoding != 'utf-8'
    set encoding=utf-8
endif

" Line number column
set number
autocmd InsertEnter * :set nornu
autocmd InsertLeave * :set rnu

" Indenting
set tabstop=4
set softtabstop=0
set shiftwidth=4
set shiftround
set autoindent
set smartindent

" Searching
set ignorecase
set incsearch
set smartcase
set hlsearch
set gdefault
nnoremap <F3> :set hlsearch!<CR>

" Performance
set lazyredraw

" Permanent undo
set undodir=~/.vimdid
set undofile

" Call compiler
nnoremap <leader>c :!compile %<CR>

" Disables automatic commenting on newline
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o
nnoremap <leader>q ciw"<C-R>""
" Spell-check
map <leader>P :setlocal spell! spelllang=en_us<CR>

map <leader>o :!opout <c-r>%<CR><CR>

" NERDTree
noremap <C-n> :NERDTreeToggle<CR>
let g:NERDTreeQuitOnOpen = 1
let g:NERDTreeWinPos = "right"

" Splits open at the bottom and right
set splitright
set splitbelow

" Decent wildmenu
set wildmenu
set wildmode=list:longest

" Replace all is aliased to S
nnoremap S :%s//g<Left><Left>

" Clean tex build files when leaving vim
autocmd VimLeave *.tex !texclear %
" Read files properly
let g:vimwiki_ext2syntax = {'.Rmd': 'markdown', '.rmd': 'markdown','.md': 'markdown', '.markdown': 'markdown', '.mdown': 'markdown'}
autocmd BufRead,BufNewFile /tmp/calcurse*,~/.calcurse/notes/* set filetype=markdown
autocmd BufRead,BufNewFile *.tex set filetype=tex

" Delete trailing whitespace on save
autocmd BufWritePre * %s/\s\+$//e

" Apply config when i finished editing it
autocmd BufWritePost ~/.config/res/bm* !shortcuts
autocmd BufWritePost ~/.Xresources,~/.Xdefaults !xrdb %
autocmd BufWritePost *sxhkdrc !pkill -USR1 sxhkd

" file under cursor
nnoremap <F2> :IH<CR>
inoremap <F2> <ESC>:IH<CR>

" completion most of these taken from github
set hidden
set nobackup
set nowritebackup
set updatetime=300
set shortmess+=c

" ; as :
nnoremap ; :

" tab completion
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()
inoremap <silent><expr> <c-@> coc#refresh()

" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocActionAsync('doHover')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Remap keys for applying codeAction to the current buffer.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Show actions available at this location
nnoremap <silent> <space>a  :CocAction<cr>

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" --- Movement ---

" No arrow keys --- force yourself to use the home row
nnoremap <up> <nop>
nnoremap <down> <nop>
inoremap <up> <nop>
inoremap <down> <nop>
inoremap <left> <nop>
inoremap <right> <nop>

" Left and right can switch buffers
nnoremap <left> :bp<CR>
nnoremap <right> :bn<CR>

" Move by line
nnoremap j gj
nnoremap k gk

" Jump to start and end of line using the home row keys
map H ^
map L $

nnoremap <C-j> <Esc>
inoremap <C-j> <Esc>
vnoremap <C-j> <Esc>
snoremap <C-j> <Esc>
xnoremap <C-j> <Esc>
cnoremap <C-j> <C-c>
onoremap <C-j> <Esc>
lnoremap <C-j> <Esc>
tnoremap <C-j> <Esc>

nnoremap <C-k> <Esc>
inoremap <C-k> <Esc>
vnoremap <C-k> <Esc>
snoremap <C-k> <Esc>
xnoremap <C-k> <Esc>
cnoremap <C-k> <C-c>
onoremap <C-k> <Esc>
lnoremap <C-k> <Esc>
tnoremap <C-k> <Esc>

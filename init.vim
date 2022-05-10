set nocompatible
let mapleader = "\<Space>"
let maplocalleader = ","


" =============================================================================
" # PLUGINS
" =============================================================================
" using vim-plug to manage plugins
call plug#begin('~/.vim/plugged')

Plug 'lervag/vimtex'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-obsession'

Plug 'neovim/nvim-lspconfig'

"Autocomplete
"" main one
Plug 'ms-jpq/coq_nvim', {'branch': 'coq'}
" 9000+ Snippets
Plug 'ms-jpq/coq.artifacts', {'branch': 'artifacts'}

" lua & third party sources -- See https://github.com/ms-jpq/coq.thirdparty
" Need to **configure separately**

Plug 'ms-jpq/coq.thirdparty', {'branch': '3p'}
" - shell repl
" - nvim lua api
" - scientific calculator
" - comment banner
" - etc GUI enhancements
"

" Snippets
Plug 'SirVer/ultisnips'

" VIM enhancements
Plug 'justinmk/vim-sneak'
Plug 'dhruvasagar/vim-table-mode'

Plug 'itchyny/lightline.vim'
Plug 'jacoborus/tender.vim'
Plug 'machakann/vim-highlightedyank'

" Syntactic language support
Plug 'rust-lang/rust.vim'

call plug#end()

" vimtex configurations
"

"" viewer
let g:vimtex_view_general_viewer = 'okular'
let g:vimtex_view_general_options = '--unique file:@pdf\#src:@line@tex'
let g:vimtex_view_general_options_latexmk = '--unique'

"" pdf previewing

"vim-sneak configuration
let g:sneak#s_next = 1

"rust.vim configuration
let g:rustfmt_autosave = 1

" Ultisnip configuration
let g:UltiSnipsSnippetDirectories=[$HOME.'/.vim/snippets']
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-j>"
let g:UltiSnipsJumpBackwardTrigger="<c-k>"

" =============================================================================
" # Editor settings
" =============================================================================

filetype plugin indent on
set autoindent
set encoding=utf-8
set hidden
set noshowmode " remove -- INSERT -- since lightline does its job
set nowrap
set nojoinspaces
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab
set number relativenumber

" SEARCH SETTINGS
set incsearch
set ignorecase
set smartcase
set gdefault

" Search results centered please
nnoremap <silent> n nzz
nnoremap <silent> N Nzz
nnoremap <silent> * *zz
nnoremap <silent> # #zz
nnoremap <silent> g* g*zz

" COLOR SETTINGS
if (has("termguicolors"))
 set termguicolors
endif

" Theme
syntax enable
colorscheme tender

" set lighline theme inside lightline config
let g:lightline = { 'colorscheme': 'tender' }

" =============================================================================
" # Keyboard shortcuts
" =============================================================================

" Quick-save
nmap <leader>w :w<CR>

" Ctrl+k as Esc
nnoremap <C-k> <Esc>
inoremap <C-k> <Esc>
vnoremap <C-k> <Esc>
snoremap <C-k> <Esc>
xnoremap <C-k> <Esc>
cnoremap <C-k> <Esc>
onoremap <C-k> <Esc>
lnoremap <C-k> <Esc>
tnoremap <C-k> <Esc>

" Ctrl+h to stop searching
vnoremap <C-h> :nohlsearch<cr>
nnoremap <C-h> :nohlsearch<cr>

" Jump to start and end of line using the home row keys
map H ^
map L $

" No arrow keys --- force yourself to use the home row
nnoremap <up> <nop>
nnoremap <down> <nop>
inoremap <up> <nop>
inoremap <down> <nop>
inoremap <left> <nop>
inoremap <right> <nop>

" Move by line on screen
nnoremap j gj
nnoremap k gk


" ======================= LSP ===========================

lua << EOF
local lspconfig = require('lspconfig')

-- Automatically start coq
vim.g.coq_settings = { auto_start = 'shut-up' }

-- Enable some language servers with the additional completion capabilities offered by coq_nvim
local servers = { 'rust_analyzer', 'quick_lint_js', 'cssls', 'jsonls', 'html'}
for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup(require('coq').lsp_ensure_capabilities({
    -- on_attach = my_custom_on_attach,
  }))
end
EOF

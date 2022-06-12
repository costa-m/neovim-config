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

" Prettier
" post install (npm install) then load plugin only for editing supported files
Plug 'prettier/vim-prettier', { 'do': 'npm install --frozen-lockfile --production' }

" fuzzy-finder
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

" vim practice
Plug 'ThePrimeagen/vim-be-good'

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
" tab behaviour
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab
" line numbering
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

-- Mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
local opts = { noremap=true, silent=true }
vim.api.nvim_set_keymap('n', '<space>e', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
vim.api.nvim_set_keymap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
vim.api.nvim_set_keymap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
vim.api.nvim_set_keymap('n', '<space>q', '<cmd>lua vim.diagnostic.setloclist()<CR>', opts)

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)

  -- Mappings.
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
end

--Enable (broadcasting) snippet capability for completion
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

-- Enable some language servers with the additional completion capabilities offered by coq_nvim
local servers = { 'rust_analyzer', 'quick_lint_js', 'cssls', 'jsonls', 'html', 'tsserver'}
for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup(require('coq').lsp_ensure_capabilities({
    on_attach = on_attach,
    capabilities = capabilities,
  }))
end
EOF

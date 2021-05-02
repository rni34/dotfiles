let g:python3_host_prog='/usr/bin/python3'
let g:python_host_prog='/usr/bin/python'

""""" LIST OF PLUGINS

" Plugin starts here
call plug#begin()
Plug 'christoomey/vim-tmux-navigator'
Plug 'diepm/vim-rest-console'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'mileszs/ack.vim'
Plug 'ms-jpq/chadtree', {'branch': 'chad', 'do': ':UpdateRemotePlugins'}
Plug 'dart-lang/dart-vim-plugin'

Plug 'neoclide/coc.nvim', {'branch': 'release'}

"Plug 'neovim/nvim-lspconfig'
"Plug 'nvim-lua/completion-nvim'
"Plug 'nvim-treesitter/nvim-treesitter'
"Plug 'nvim-treesitter/nvim-treesitter-textobjects'
Plug 'ryanoasis/vim-devicons'
Plug 'sbdchd/neoformat'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'junegunn/seoul256.vim'
Plug 'justinmk/vim-sneak'
" Keep at last
call plug#end()
" Plugin ends here

" vim-rest-console
let g:vrc_curl_opts = {
\ '-b': '/tmp/cookies',
\ '-c': '/tmp/cookies',
\ '-i': '',
\ '-s': '',
\ '--max-time': 60,
\ '--ipv4': '',
\ '-k': '',
\}
augroup filetype_rest
    autocmd!
    autocmd FileType rest nnoremap ; /--<CR>
    autocmd FileType rest nnoremap ' ?--<CR>
    autocmd FileType rest nnoremap <CR> :call VrcQuery()<CR>
augroup END

let g:vrc_auto_format_response_patterns = {
\ 'json': 'python3 -m json.tool'
\}

" Surround word with tags
inoremap <C-g> <esc>yiWi<lt><esc>Ea></><esc>hpF>i

" Set leader key to space
let mapleader = " "

" Split a docstring into shorter lines
let @i = '60lWiw'

set completeopt=menuone,noinsert,noselect
set shortmess+=c

" " <Tab> or <S-Tab> to select next item in autocomplete
" inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
" inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" " Vim-vsnip jump forward or backward
" imap <expr> <C-j> vsnip#jumpable(1)   ? '<Plug>(vsnip-jump-next)'      : '<Tab>'
" smap <expr> <C-j> vsnip#jumpable(1)   ? '<Plug>(vsnip-jump-next)'      : '<Tab>'
" imap <expr> <C-k> vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)'      : '<S-Tab>'
" smap <expr> <C-k> vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)'      : '<S-Tab>'

" " completion.nvim
" let g:completion_enable_snippet = 'vim-vsnip'
" let g:completion_matching_strategy_list = ['substring', 'fuzzy']
" let g:completion_matching_ignore_case = 1
" let g:completion_trigger_keyword_length = 1 " default = 1
" let g:completion_trigger_on_delete = 1
" let g:completion_items_priority = {
"            \ 'Field': 9,
"            \ 'Function': 7,
"            \ 'Variables': 10,
"            \ 'Method': 9,
"            \ 'Interfaces': 5,
"            \ 'Constant': 5,
"            \ 'Class': 5,
"            \ 'Keyword': 4,
"            \ 'vim-vsnip' : 11,
"            \ 'Buffers' : 1,
"            \ 'TabNine' : 0,
"            \ 'File' : 8,
"            \}

" augroup completionnvim
"   autocmd BufEnter * lua require'completion'.on_attach()
"   set updatetime=500
"   autocmd CursorHold <buffer> lua vim.lsp.diagnostic.show_line_diagnostics()
" augroup END

" Load lsp configurations
" lua require("lsp_config")


set signcolumn=yes

" CHADtree
nnoremap <C-n> <cmd>CHADopen<cr>
let g:chadtree_settings = { 'width': 43 }

""" ACK.VIM
" Use silver searcher
let g:ackprg = 'ag --nogroup --nocolor --column'

filetype indent plugin on
syntax on

let g:filetype_pl="prolog"

set relativenumber
set so=5

" Turn off swap file because it's just annoying
set noswapfile

" Hide the current buffer when switching to another buffer
set hidden

set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab
set smarttab
set autoindent

" Format the buffer with F12
"nnoremap <F12> :Neoformat<CR>
"let g:neoformat_enabled_python = ['black', 'isort', 'docformatter']
"augroup neoformat_specific_filetype_checks
"    autocmd!
"    autocmd FileType python let b:neoformat_run_all_formatters = 1
"augroup END
"
" Reset Treesitter highlighting
nnoremap <leader>rr :write \| edit \| TSBufEnable highlight<CR>

" More natural split position (bottom and right)
set splitbelow
set splitright

" Enable true color support
set termguicolors

colo seoul256-light
"colo seoul256
set background=light

" Open nvim/init.vim
nnoremap <leader>e :e $MYVIMRC<CR>
nnoremap <leader>eb :e $HOME/.bashrc<CR>
" nnoremap <leader>el :e $HOME/.config/nvim/lua/lsp_config.lua<CR>
nnoremap <leader>em :e $HOME/dotfiles/Makefile<CR>

" Close the quickfix window
nnoremap <leader>q :ccl<CR>

" Source nvim/init.vim
nnoremap <leader>v :source $MYVIMRC<CR>

vnoremap <C-c> "+y

" VIM SNEAK
let g:sneak#label = 1

" Paste stuff from register in insert mode
inoremap <C-r> <C-r><C-o>"

set timeout
set ttimeout
set timeoutlen=250
set ttimeoutlen=100

" Ag with space-3
nnoremap <leader>3 :Ag<CR>

" Easy search and replace
nnoremap <Leader>4 :%s/\<<C-r><C-w>\>/

" Live substitution
set inccommand=split

""" STATUSLINE
set statusline=
set statusline+=%#DiffAdd#%{(mode()=='n')?'\ \ NORMAL\ ':''}
set statusline+=%#DiffChange#%{(mode()=='i')?'\ \ INSERT\ ':''}
set statusline+=%#DiffDelete#%{(mode()=='r')?'\ \ RPLACE\ ':''}
set statusline+=%#Cursor#%{(mode()=='v')?'\ \ VISUAL\ ':''}
set statusline+=\ %n\           " buffer number
set statusline+=%#Visual#       " colour
set statusline+=%{&paste?'\ PASTE\ ':''}
set statusline+=%{&spell?'\ SPELL\ ':''}
set statusline+=%#CursorIM#     " colour
set statusline+=%R                        " readonly flag
set statusline+=%M                        " modified [+] flag
set statusline+=%#Cursor#               " colour
set statusline+=%#CursorLine#     " colour
set statusline+=\ %t\                   " short file name
set statusline+=%=                          " right align
set statusline+=%#CursorLine#   " colour
set statusline+=\ %y\                   " file type
set statusline+=%#CursorIM#     " colour
set statusline+=\ %3l:%-2c\         " line + column
set statusline+=%#Cursor#       " colour
set statusline+=\ %3p%%\                " percentage

""" FZF
" Search open buffers
nnoremap <leader>b :Buffers<CR>

" Search files
nnoremap <leader>f :Files<CR>

""" Turn items separated by commas into multiple lines
nnoremap <leader>, :s#,#,\r#g<CR>

" TextEdit might fail if hidden is not set.
set hidden

" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup

" Give more space for displaying messages.
set cmdheight=2

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
if has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
endif

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
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
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

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
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current buffer.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Remap <C-f> and <C-b> for scroll float windows/popups.
if has('nvim-0.4.0') || has('patch-8.2.0750')
  nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
  inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
  inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
  vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
endif

" Use CTRL-S for selections ranges.
" Requires 'textDocument/selectionRange' support of language server.
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')
nnoremap <F12> :call CocAction('format')<CR>

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Mappings for CoCList
" Show all diagnostics.
nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>

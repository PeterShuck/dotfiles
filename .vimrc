" === Mappings ===
vmap '' :w !pbcopy<CR><CR>

" === VimPlug ===
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('$HOME/.vim/bundle')

" === colorscheme(s) ===
Plug 'https://github.com/xero/sourcerer.vim'

" === completion ===
Plug 'https://github.com/dense-analysis/ale'

" === Search ===
Plug 'https://github.com/junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'https://github.com/junegunn/fzf.vim'

" === Other ===
Plug 'https://github.com/tpope/vim-commentary'
Plug 'https://github.com/tpope/vim-endwise'
Plug 'https://github.com/tpope/vim-fugitive'
Plug 'https://github.com/leafOfTree/vim-vue-plugin'

call plug#end()

"  ____ ____ ____ ____ ____ ____ ____ ____
" ||s |||e |||t |||t |||i |||n |||g |||s ||
" ||__|||__|||__|||__|||__|||__|||__|||__||
" |/__\|/__\|/__\|/__\|/__\|/__\|/__\|/__\|

set autoread
set backspace=2 " Backspace deletes like most programs in insert mode
set clipboard^=unnamedplus " copy paste to system clipboard
set colorcolumn=+1 " highlight column after 'textwidth'
set background=dark " Use colors that look good on a dark background
colorscheme sourcerer
set cursorline
set diffopt+=vertical " Start diff mode with vertical splits
set expandtab " Use the appropriate number of spaces to insert a <Tab>.
filetype plugin indent on " load indent file for language
set formatprg=par
set gdefault " Replace all matches on a line instead of just the first
set grepprg=ack\ -a
set grepformat=%f:%l:%c:%m,%f:%l:%m
set history=50 " remember the last 50 command-lines in the history table
set hlsearch " highlight search results
let g:html_indent_tags = 'li\|p' " Treat <li> and <p> tags like the block tags they are
set incsearch " do incremental searching
set ignorecase " case insensitive pattern matching
set laststatus=2
set lazyredraw
let g:is_posix=1 " When the type of shell script is /bin/sh, assume a POSIX-compatible shell for syntax highlighting purposes.
set list listchars=tab:»·,trail:·,nbsp:· " Display extra whitespace
let g:mapleader = ' ' " Set Leader key to <Space> bar
runtime! macros/matchit.vim " Extended matching with '%'. See :help matchit
set matchtime=0 " Speed up escape after (){} chars
set mouse=a " Enable mouse for pair programming
set nobackup " Don't make a backup before overwriting a file
set nofoldenable " Leave open all folds
set nojoinspaces " Insert one space after a '.', '?' and '!' with a join command.
set noshowmode " If in Insert, Replace or Visual mode don't put a message on the last line.
set noswapfile " Do not create a swapfile for a new buffer.
set nowrap " Don't wrap lines longer than the width of the window
set nowritebackup " Don't make a backup before overwriting a file.
set number " Turn on line numbers
set numberwidth=1 " Minimal number of columns to use for the line number.
set path+=.,,
set redrawtime=1000 " Stop highlighting if it takes more than a second
set ruler " show the cursor position all the time
set scrolloff=3 " show 5 lines above and below cursor
scriptencoding utf-8 " Specify the character encoding used in the script.
set shiftround " Round indent to multiple of 'shiftwidth'.
set shiftwidth=2 " Returns the effective value of 'shiftwidth'
set showcmd " display incomplete commands
set showtabline=2
set signcolumn=yes " Leave signcolumn enabled otherwise it's a little jarring
set smartcase " overrides ignorecase if pattern contains upcase
set spellfile=$HOME/.vim-spell-en.utf-8.add " Name of the word list file where words are added for the |zg| and |zw| commands.
set spelllang=en_us " Set region to US English
set splitbelow " When on, splitting a window will put the new window below the current one.
set splitright " When on, splitting a window will put the new window right of the current one.
syntax on " Turn on syntax highlighting. This must come before statusline
set statusline=
set statusline+=%3*\ %L
set statusline+=\ %*
set statusline+=%1*\▉▊▋▌
set statusline+=%1*\ %f\ %*
set statusline+=%3*\▎
set statusline+=%3*\ %{StatusGit()}
set statusline+=%3*\ %{StatusGitGutter()}
set statusline+=%3*\ ▎
set statusline+=%3*\ %{StatusErrors()}
set statusline+=%=
set statusline+=%3*\ %y%*%*
set statusline+=%3*\ ▎
set statusline+=%3*\ %P
set statusline+=%3*\ ▌▋▊▉
set synmaxcol=200
set tabstop=2 " Number of spaces that a <Tab> in the file counts for.
set textwidth=120 " Maximum width of text that is being inserted. A longer line will be broken after white space to get this width.
set ttimeout " determine the behavior when part of a key code sequence has been received by the terminal UI.
set undodir=$HOME/.undodir " directory name for undo file.
set undofile " Automatically saves undo history to an undo file when writing a buffer to a file, and restores undo history from the same file on buffer read.
set undolevels=500
set undoreload=500
set wildignore+=tmp/** " Ignore stuff that can't be opened
set wildmenu " Enables a menu at the bottom of the vim window.
set wildmode=list:longest,list:full

"  ____ ____ ____ ____ ____ ____  ____ ____ ___
" ||f |||u |||n |||c |||t |||i |||o |||n |||s ||
" ||__|||__|||__|||__|||__|||__|||__|||__|||__||
" |/__\|/__\|/__\|/__\|/__\|/__\|/__\|/__\|/__\|

" === statusline ===
function! StatusGit() abort
  return exists('*fugitive#head') ? fugitive#head() : ''
endfunction

function! StatusErrors() abort
  let l:counts = ale#statusline#Count(bufnr(''))
  return l:counts.total == 0 ? '' : printf('• %d', l:counts.total)
endfunction

function! StatusGitGutter() abort
  if !exists('*GitGutterGetHunkSummary')
        \ || ! get(g:, 'gitgutter_enabled', 0)
        \ || winwidth('.') <= 90
    return ''
  endif
  let l:symbols = [
        \ g:gitgutter_sign_added . '',
        \ g:gitgutter_sign_modified . '',
        \ g:gitgutter_sign_removed . ''
        \ ]
  let l:hunks = GitGutterGetHunkSummary()
  let l:ret = []
  for l:i in [0, 1, 2]
    if l:hunks[l:i] > 0
      call add(l:ret, l:symbols[l:i] . l:hunks[l:i])
    endif
  endfor
  return join(l:ret, ' ')
endfunction

"  ____ ____ ____ ____ ____ ____   ____ ____ ____ ____ ____ ____ ____ ____
" ||p |||l |||u |||g |||i |||n || ||s |||e |||t |||t |||i |||n |||g |||s ||
" ||__|||__|||__|||__|||__|||__|| ||__|||__|||__|||__|||__|||__|||__|||__||
" |/__\|/__\|/__\|/__\|/__\|/__\| |/__\|/__\|/__\|/__\|/__\|/__\|/__\|/__\|

" === ale ===
let g:ale_linters = {
      \ 'css': ['scsslint'],
      \ 'erb': ['erubi'],
      \ 'html': ['tidy', 'htmlhint', 'write-good', 'alex'],
      \ 'javascript': ['eslint'],
      \ 'jsx': ['stylelint', 'eslint'],
      \ 'ruby': ['ruby', 'rubocop', 'rails_best_practices', 'brakeman'],
      \ 'scss': ['scsslint'],
      \ 'text': ['vale', 'write-good', 'alex'],
      \ 'vim': ['vint']
      \ }

let g:ale_fixers = {
      \ 'css': ['stylelint'],
      \ 'html': ['prettier'],
      \ 'javascript': ['prettier-eslint'],
      \ 'json': ['prettier'],
      \ 'ruby': ['rubocop'],
      \ 'scss': ['stylelint']
      \ }

" Do not lint or fix minified files.
let g:ale_pattern_options = {
      \ '\.min\.css$': {'ale_enabled': 0},
      \ '\.min\.js$': {'ale_enabled': 0},
      \}

let g:ale_virtualtext_cursor = 1
let g:ale_javascript_prettier_eslint_options = '--single-quote --trailing-comma all --print-width 100 --arrow-parens always'
let g:ale_set_quickfix = 0
let g:ale_sign_warning = '•'
let g:ale_sign_error = '•'
let g:ale_echo_msg_error_str = 'Error'
let g:ale_echo_msg_warning_str = 'Warning'
let g:ale_echo_msg_format = '[%linter%] %s'

nnoremap <Leader>f :ALEFix<CR>
nmap <silent> <Leader>k <Plug>(ale_previous_wrap)
nmap <silent> <Leader>j <Plug>(ale_next_wrap)

" === fzf.vim ===
nnoremap <C-p> :wa<CR>:Files<CR>
nnoremap <C-t> :wa<CR>:Tags<CR>
nnoremap <C-b> :wa<CR>:Buffers<CR>
nnoremap <Leader>p :BLines<CR>
nnoremap <Leader>gc :wa<CR>:Commits<CR>
nnoremap <Leader>hi :wa<CR>:History<CR>

augroup fzfstatus
  autocmd! FileType fzf
  autocmd  FileType fzf set laststatus=0 | autocmd WinLeave <buffer> set laststatus=2
augroup END

" Command for git grep
" - fzf#vim#grep(command, with_column, [options], [fullscreen])
command! -bang -nargs=* GGrep
  \ call fzf#vim#grep(
  \   'git grep --line-number '.shellescape(<q-args>), 0,
  \   { 'dir': systemlist('git rev-parse --show-toplevel')[0] }, <bang>0)

" === commentary ===
nnoremap <C-\> :Commentary<CR>
vnoremap <C-\> :Commentary<CR>

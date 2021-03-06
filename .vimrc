" http://github.com/mitchweaver/dots
" -/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/

" ██╗███╗   ██╗██╗████████╗
" ██║████╗  ██║██║╚══██╔══╝
" ██║██╔██╗ ██║██║   ██║
" ██║██║╚██╗██║██║   ██║
" ██║██║ ╚████║██║   ██║
" ╚═╝╚═╝  ╚═══╝╚═╝   ╚═╝
" -*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath
" unbind space for everything but leader
nnoremap <silent><SPACE> <nop>
let mapleader=" "

" ██████╗ ██╗     ██╗   ██╗ ██████╗ ██╗███╗   ██╗███████╗
" ██╔══██╗██║     ██║   ██║██╔════╝ ██║████╗  ██║██╔════╝
" ██████╔╝██║     ██║   ██║██║  ███╗██║██╔██╗ ██║███████╗
" ██╔═══╝ ██║     ██║   ██║██║   ██║██║██║╚██╗██║╚════██║
" ██║     ███████╗╚██████╔╝╚██████╔╝██║██║ ╚████║███████║
" ╚═╝     ╚══════╝ ╚═════╝  ╚═════╝ ╚═╝╚═╝  ╚═══╝╚══════╝
" -*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
if has('nvim')
    set nocompatible
    filetype off
    call plug#begin('~/.vim/vim-plug')

    Plug 'tpope/vim-repeat'          " allows '.' to do more things
    Plug 'tpope/vim-speeddating'     " allows C-a to increment dates and times
    Plug 'tpope/vim-eunuch'          " wrapper around common unix shell commands
    Plug 'tpope/vim-sleuth'          " autodetect tab indentation
    Plug 'tpope/vim-abolish'         " bracket {,} expansion in substitution
    Plug 'tpope/vim-unimpaired'      " pairing of binds with '[' and ']'
    Plug 'tpope/vim-surround'        " surround stuff with stuff
        nmap ss ysiw
        nmap sl yss
        vmap s S
    Plug 'tpope/vim-commentary'      " comment toggler
        nmap <silent><leader>c :Commentary<CR>
        autocmd BufNewFile,BufRead *.asm setlocal commentstring=;\ %s
        autocmd BufNewFile,BufRead *.conf setlocal commentstring=#\ %s
        autocmd BufNewFile,BufRead *rc setlocal commentstring=#\ %s
        autocmd BufNewFile,BufRead pkgfile setlocal commentstring=#\ %s

    Plug 'unblevable/quick-scope'    " make f F t T ; and , useable 
    Plug 'godlygeek/tabular'         " tab alignment
    Plug 'sheerun/vim-polyglot'      " syntax highlighting
    Plug 'ekalinin/Dockerfile.vim'   " syntax for dockerfiles
    Plug 'svermeulen/vim-yoink'      " emacs killring for vim
    Plug 'dstein64/vim-startuptime'  " useful for debugging slow plugins
    Plug 'chrisbra/unicode.vim'      " easily search and copy unicode chars
    Plug 'ryanoasis/vim-devicons'    " adds icons to plugins
    Plug 'psliwka/vim-smoothie'      " smooth scrolling done right

    Plug 'preservim/vim-wordy'       " make me write gooder
        noremap <silent><F8> :<C-u>NextWordy<cr>
        xnoremap <silent><F8> :<C-u>NextWordy<cr>
        inoremap <silent><F8> <C-o>:NextWordy<cr>
        if !&wildcharm | set wildcharm=<C-z> | endif
        execute 'nnoremap <leader>w :Wordy<space>'.nr2char(&wildcharm)

    Plug 'ap/vim-buftabline' " display buffers along top as tabs
        " uncomment to hide tab if there is only one buffer
        " let g:buftabline_show = 1

    Plug 'mg979/vim-visual-multi' " sublime-like multiple select
        let g:VM_default_mappings = 0
        let g:VM_mouse_mappings = 0
        let g:VM_maps = {}
        " let g:VM_maps["Undo"] = 'u'
        " let g:VM_maps["Redo"] = '<C-r>'
        " let g:VM_maps['Select All']  = '<M-n>'
        " let g:VM_maps['Visual All']  = '<M-n>'
        let g:VM_maps['Find Under']         = '<C-d>'
        let g:VM_maps['Find Subword Under'] = '<C-d>'
        let g:VM_maps['Skip Region'] = '<C-x>'
        " let g:VM_maps["Select Cursor Down"] = '<M-C-Down>'
        " let g:VM_maps["Select Cursor Up"]   = '<M-C-Up>'

    Plug 'airblade/vim-gitgutter' " git diffing along the left side
        let g:gitgutter_map_keys = 0 " disable all gitgutter keybinds
        let g:gitgutter_realtime = 0 " only run gitgutter on save
        let g:gitgutter_earer = 1
        let g:gitgutter_max_signs = 1000
        let g:gitgutter_diff_args = '-w'
        let g:gitgutter_sign_added = '+'
        let g:gitgutter_sign_modified = '~'
        let g:gitgutter_sign_removed = '-'
        let g:gitgutter_sign_removed_first_line = '^'
        let g:gitgutter_sign_modified_removed = ':'
        map <silent><leader>g :GitGutterToggle<CR>
        " nmap ]h <Plug>GitGutterNextHunk
        " nmap [h <Plug>GitGutterPrevHunk
        " nmap <Leader>hs <Plug>GitGutterStageHunk
        " nmap <Leader>hr <Plug>GitGutterUndoHunk

    Plug 'vimwiki/vimwiki' " the ultimate note taking system
        let wiki = {}
        let g:vimwikidir = "~/files/wiki"
        let g:vimwiki_list=[wiki]
        let g:vimwiki_list = [
          \{'path': '~/files/wiki', 'syntax': 'markdown', 'ext': '.md'},
        \]
        let g:vimwiki_ext2syntax = {'.md': 'markdown'}
        let g:vimwiki_global_ext = 0
        autocmd FileType md set ft=markdown

    Plug 'honza/vim-snippets' " snippets repo
    Plug 'SirVer/ultisnips' " snippet driver
        let g:UltiSnipsExpandTrigger="<c-l>"
        let g:UltiSnipsListSnippets = '<c-cr>'
        let g:UltiSnipsEditSplit="vertical"

    Plug 'ervandew/supertab' " tab completion rather than <c-n>
        let g:SuperTabDefaultCompletionType = "<c-n>"

    Plug 'Yggdroot/indentLine' " show indentation lines
        let g:indentLine_enabled = 0
        nmap <leader>il :let g:indentLine_enabled = 1<CR>
        nmap <leader>li :let g:indentLine_enabled = 0<CR>

   Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
       let g:deoplete#enable_at_startup = 1

    Plug 'w0rp/ale'
        let g:ale_sign_column_always = 0
        let g:ale_fix_on_save = 1
        " uncomment to only have ale check on file saves
        let g:ale_lint_on_text_changed = 'never'
        let g:airline#extensions#ale#enabled = 1
        let g:ale_linters = {'python': ['pylint']} " flake8
        let g:ale_python_pylint_options = '--rcfile ~/.pylintrc'

    Plug 'mhinz/vim-startify'
        let g:startify_files_number = 10
        " 0: recently-used files update on vim exit, 1: immediate
        let g:startify_update_oldfiles = 1
        let g:startify_change_to_dir = 1
        " remove fortune and cowsay from startify... annoying...
        let g:startify_custom_header = [
            \ '                                 ',
            \ '      ⢀⣀ ⣰⡀ ⢀⣀ ⡀⣀ ⣰⡀ ⣀⡀ ⢀⣀ ⢀⡀ ⢀⡀ ',
            \ '      ⠭⠕ ⠘⠤ ⠣⠼ ⠏  ⠘⠤ ⡧⠜ ⠣⠼ ⣑⡺ ⠣⠭ ',
            \ ]

        let g:startify_lists = [
            \ { 'type': 'dir',       'header': ['   Last Updated: '] },
            \ { 'type': 'bookmarks', 'header': ['   Bookmarks:']      },
            \ ]

        let g:startify_bookmarks = [
            \ {'w': '~/files/wiki/index.md'},
            \ {'v': '~/.vimrc'},
            \ ]

        let g:startify_skiplist = [
            \ 'COMMIT_EDITMSG',
            \ escape(fnamemodify(resolve($VIMRUNTIME), ':p'), '\') .'doc',
            \ 'bundle/.*/doc',
            \ ]

    Plug 'preservim/nerdtree'
        nnoremap <C-n> :NERDTreeToggle<CR>
        nnoremap <leader>n :NERDTreeToggle<CR>
        nnoremap <leader>f :NERDTreeFind<CR>
        " Exit Vim if NERDTree is the only window left.
        autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() |
            \ quit | endif
        " If another buffer tries to replace NERDTree, put it in the other window, and bring back NERDTree.
        autocmd BufEnter * if bufname('#') =~ 'NERD_tree_\d\+' && bufname('%') !~ 'NERD_tree_\d\+' && winnr('$') > 1 |
            \ let buf=bufnr() | buffer# | execute "normal! \<C-W>w" | execute 'buffer'.buf | endif
        " Open the existing NERDTree on each new tab.
        autocmd BufWinEnter * silent NERDTreeMirror
        let g:NERDTreeDirArrowExpandable = '▸'
        let g:NERDTreeDirArrowCollapsible = '▾'

    Plug 'sonph/onehalf', {'rtp': 'vim/'} " theme
    Plug 'sainnhe/everforest' " theme
    Plug 'logico/typewriter-vim' " theme
    Plug 'dylanaraps/wal.vim' " if using pywal

    Plug 'gyim/vim-boxdraw' " the coolest plugin you never knew you needed
        " NOTE: this is toggled by ']ov' if you tpope's vim-unimpaired
        " set virtualedit+=all " allows you to select empty space in visual

    " Plug 'skywind3000/vim-keysound'
    "     let g:keysound_enable = 1
    "     let g:keysound_theme = "default"
    "     " let g:keysound_theme = "typewriter"
    "     let g:keysound_py_version = 3
    "     let g:keysound_volume = 1000 " 0-1000

    call plug#end()
    filetype indent plugin on

    if exists(':PlugInstall')
        map <silent><leader>pi :PlugInstall<CR>
        map <silent><leader>pu :PlugUpdate<CR>
        map <silent><leader>pc :PlugClean<CR>

        " NOTE: colorschemes must be set after loading plugins
        " -/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/
        " ----- If not using pywal: ---------------
        " colorscheme onehalfdark
        " colorscheme typewriter
        " set background=light
        " set background=dark
        " set t_Co=256 " fix terminal colors
        " -/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/

        " if using pywal:
        colorscheme wal

        " make sign column same color as terminal background
        hi signColumn ctermbg=NONE
    endif
endif

"  ██████╗ ███████╗███╗   ██╗███████╗██████╗  █████╗ ██╗
" ██╔════╝ ██╔════╝████╗  ██║██╔════╝██╔══██╗██╔══██╗██║
" ██║  ███╗█████╗  ██╔██╗ ██║█████╗  ██████╔╝███████║██║
" ██║   ██║██╔══╝  ██║╚██╗██║██╔══╝  ██╔══██╗██╔══██║██║
" ╚██████╔╝███████╗██║ ╚████║███████╗██║  ██║██║  ██║███████╗
"  ╚═════╝ ╚══════╝╚═╝  ╚═══╝╚══════╝╚═╝  ╚═╝╚═╝  ╚═╝╚══════╝
" -*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
scriptencoding utf-8
set encoding=utf-8
set mouse=a             " a=all,'unset mouse'=disable
set signcolumn=auto     " yes=always, no=never, auto=ifchanges
set history=200
set backspace=indent,eol,start
set whichwrap+=<,>,h,l
set updatetime=500
set clipboard=unnamedplus
set lazyredraw          " whether to redraw screen after macros
set mat=2               " how fast to blink matched brackets
set textwidth=0         " very annoying warning
set backspace=2         " allow backspace to go over new lines
set title               " keep window name updated with current file
set noruler             " don't show file position in the bottom right
set laststatus=0        " Disable bottom status line / statusbar
set noshowcmd           " don't print the last run command
set ch=1                " get rid of the wasted line at the bottom
set cmdheight=1         " cmd output only take up 1 line
set nostartofline       " gg/G do not always go to line start
set modeline            " enable per-file custom syntax
set shortmess+=I        " disable startup message
" set noshowmode        " don't show 'insert' or etc on bottom left
" set cursorline " highlight current line of cursor

" remove need to hold shift for commands
noremap ; :
" allow operations if we accidentally held shift
noremap :W :w
noremap :W! :w!
noremap :Q :q
noremap :Q! :q!

" ███████╗██╗   ██╗███╗   ██╗████████╗ █████╗ ██╗  ██╗
" ██╔════╝╚██╗ ██╔╝████╗  ██║╚══██╔══╝██╔══██╗╚██╗██╔╝
" ███████╗ ╚████╔╝ ██╔██╗ ██║   ██║   ███████║ ╚███╔╝ 
" ╚════██║  ╚██╔╝  ██║╚██╗██║   ██║   ██╔══██║ ██╔██╗ 
" ███████║   ██║   ██║ ╚████║   ██║   ██║  ██║██╔╝ ██╗
" ╚══════╝   ╚═╝   ╚═╝  ╚═══╝   ╚═╝   ╚═╝  ╚═╝╚═╝  ╚═╝
" -*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
autocmd BufNewFile,BufRead *.config  set syntax=sh
autocmd BufNewFile,BufRead *.conf    set syntax=sh
autocmd BufNewFile,BufRead *.cfg     set syntax=sh
autocmd BufNewFile,BufRead *.rc      set syntax=sh
autocmd BufNewFile,BufRead *.shellrc set syntax=sh
autocmd BufNewFile,BufRead pkgfile   set syntax=sh

autocmd BufNewFile,BufRead *.c       set syntax=c
autocmd BufNewFile,BufRead *.patch   set syntax=c
autocmd BufNewFile,BufRead *.hs      set syntax=haskell
autocmd BufNewFile,BufRead *.py      set syntax=python
autocmd BufNewFile,BufRead *.pl      set syntax=perl
autocmd BufNewFile,BufRead *.txt     set syntax=off
autocmd BufNewFile,BufRead *.md      set syntax=md
autocmd BufNewFile,BufRead *.pad     set syntax=md
autocmd BufNewFile,BufRead *.asm     setlocal ft=nasm

autocmd BufNewFile,BufRead /tmp/mutt-* set tw=72
augroup filetypedetect
  autocmd BufRead,BufNewFile *mutt-*   setfiletype mail
augroup END

let g:is_posix = 1
let g:asmsyntax = 'nasm'
map <silent><leader>sy :set syntax=sh<cr>
filetype plugin on       " vim plugin syntax

" ▜ ▗                  ▌           
" ▐ ▄ ▛▀▖▞▀▖ ▛▀▖▌ ▌▛▚▀▖▛▀▖▞▀▖▙▀▖▞▀▘
" ▐ ▐ ▌ ▌▛▀  ▌ ▌▌ ▌▌▐ ▌▌ ▌▛▀ ▌  ▝▀▖
"  ▘▀▘▘ ▘▝▀▘ ▘ ▘▝▀▘▘▝ ▘▀▀ ▝▀▘▘  ▀▀ 
" -*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
map <silent><leader>ln :set number!<cr>
map <silent><leader>nl :set relativenumber!<cr>
set number! " start with line numbering enabled

" set color column width to 72 chars
" editor will start with it hidden, but allow it
" it to be toggleable with leader + 'll'
let s:color_column_old = 72
function! s:ToggleColorColumn()
    if s:color_column_old == 0
        let s:color_column_old = &colorcolumn
        set colorcolumn=0
    else
        let &colorcolumn=s:color_column_old
        let s:color_column_old = 0
    endif
endfunction
nnoremap <silent><leader>ll :call <SID>ToggleColorColumn()<cr>

set showmatch           " show matching parens
set scrolloff=8         " pad X lines when scrolling
set fillchars=""        " extremely annoying
set diffopt+=iwhite     " disable white space diffing
set formatoptions+=o    " continue comments new lines
set synmaxcol=512
set nowrap

" ███████╗████████╗██╗   ██╗██╗     ███████╗
" ██╔════╝╚══██╔══╝╚██╗ ██╔╝██║     ██╔════╝
" ███████╗   ██║    ╚████╔╝ ██║     █████╗  
" ╚════██║   ██║     ╚██╔╝  ██║     ██╔══╝  
" ███████║   ██║      ██║   ███████╗███████╗
" ╚══════╝   ╚═╝      ╚═╝   ╚══════╝╚══════╝
" -*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab         " use spaces instead of tabs
set smarttab          " soft tab creation / deletion
set shiftround        " tab / shifting moves to closest tabstop
set autoindent        " match indents on new lines
set smartindent
set breakindent       " set indents when wrapped
" darken inactive panes --- taken from xero.nu
" hi ActiveWindow ctermbg=0 | hi InactiveWindow ctermbg=234
" set winhighlight=Normal:ActiveWindow,NormalNC:InactiveWindow

" textwidth
augroup textwidth
	autocmd!
	autocmd FileType text,mail,markdown,gmi setlocal textwidth=72
augroup END

" spellcheck
augroup spelling
	autocmd!
	autocmd FileType text,mail,markdown,gmi setlocal spell
augroup END

" ███╗   ██╗ ██████╗ ███╗   ██╗███████╗███████╗███╗   ██╗███████╗███████╗
" ████╗  ██║██╔═══██╗████╗  ██║██╔════╝██╔════╝████╗  ██║██╔════╝██╔════╝
" ██╔██╗ ██║██║   ██║██╔██╗ ██║███████╗█████╗  ██╔██╗ ██║███████╗█████╗  
" ██║╚██╗██║██║   ██║██║╚██╗██║╚════██║██╔══╝  ██║╚██╗██║╚════██║██╔══╝  
" ██║ ╚████║╚██████╔╝██║ ╚████║███████║███████╗██║ ╚████║███████║███████╗
" ╚═╝  ╚═══╝ ╚═════╝ ╚═╝  ╚═══╝╚══════╝╚══════╝╚═╝  ╚═══╝╚══════╝╚══════╝
" -*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
set vb                   " disable audible bell
set novisualbell         " kill the visual bell too
set noerrorbells         " did I mention I hate bells?
set nobackup             " we have vcs, we don't need backups.
set nowritebackup        " we have vcs, we don't need backups.
set noswapfile           " annoying

" ██████╗ ██╗   ██╗███████╗███████╗███████╗██████╗ ███████╗
" ██╔══██╗██║   ██║██╔════╝██╔════╝██╔════╝██╔══██╗██╔════╝
" ██████╔╝██║   ██║█████╗  █████╗  █████╗  ██████╔╝███████╗
" ██╔══██╗██║   ██║██╔══╝  ██╔══╝  ██╔══╝  ██╔══██╗╚════██║
" ██████╔╝╚██████╔╝██║     ██║     ███████╗██║  ██║███████║
" ╚═════╝  ╚═════╝ ╚═╝     ╚═╝     ╚══════╝╚═╝  ╚═╝╚══════╝
" -*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
set hidden        " allow buffers with unsaved changes
set autoread      " reload files if changed on disk

" b <num> = go to $buffer
nnoremap <Leader>b :b 

map <silent><C-d> :bd<cr>
map <silent>tk :bnext<CR>
map <silent>tj :bprev<CR>
map <silent>td :bd<cr>

" make < and > retain selection
vnoremap < <gv
vnoremap > >gv

map Q @q

set ignorecase " case insensitive search
set smartcase " if there are uppercase letters, become case-sensitive.
set incsearch " live incremental searching
set showmatch " live match highlighting
set hlsearch " highlight matches
set gdefault " use the `g` flag by default.
set wrapscan " searching wraps lines
set magic " 'magic' patterns - (extended regex)
nnoremap <silent><leader><leader> :let @/ = ""<CR>:noh<CR>

" Search and Replace
nmap <leader>s :%s//g<Left><Left>

" ██╗  ██╗ █████╗  ██████╗██╗  ██╗███████╗
" ██║  ██║██╔══██╗██╔════╝██║ ██╔╝██╔════╝
" ███████║███████║██║     █████╔╝ ███████╗
" ██╔══██║██╔══██║██║     ██╔═██╗ ╚════██║
" ██║  ██║██║  ██║╚██████╗██║  ██╗███████║
" ╚═╝  ╚═╝╚═╝  ╚═╝ ╚═════╝╚═╝  ╚═╝╚══════╝
" -*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
" execute line as shell command and replace it with output
" notice: capital W
noremap <leader>W !!sh<cr>
" pipe line to fmt and replace current line
noremap F !!fmt<cr>
" prepend '> ' to lines as if to block quote
noremap Q :norm 0i> <esc>$

""""" noremap <leader>T !!toilet -f smblock<cr>
noremap <leader>T !!toiletmenu -f<cr>

" view open file in rendered markdown
nmap <leader>md :!a=$(rgen) ; ghmd2html "%:p" >/tmp/$a.html && $BROWSER /tmp/$a.html<CR>

set wildignore+=*.opus,*.flac,*.mp3,*.ogg,*.mp4,*.webm
set wildignore+=*.jpg,*.png,*.gif,*.jpeg,*.pdf
set wildignore+=*.zip,*.gzip,*.bz2,*.tar,*.xz
set wildignore+=*.so,*.o,*.a

" horizontal scrolling
noremap <silent><C-o> 10zl
noremap <silent><C-i> 10zh

" print a 60-char line separator, commented
map <C-s> 30i-*<ESC>:Commentary<CR>
" map <C-s> 30i-/<ESC>:Commentary<CR>

" conflicts with st/tabbed:
map  <silent><c-=> <nop>
map  <silent><c--> <nop>
" map  <silent><C-w> <nop>

augroup resCur "reopen vim at previous cursor point
  autocmd!
  autocmd BufReadPost * call setpos(".", getpos("'\""))
augroup END

" ██╗███╗   ██╗██╗   ██╗██╗███████╗██╗██████╗ ██╗     ███████╗███████╗
" ██║████╗  ██║██║   ██║██║██╔════╝██║██╔══██╗██║     ██╔════╝██╔════╝
" ██║██╔██╗ ██║██║   ██║██║███████╗██║██████╔╝██║     █████╗  ███████╗
" ██║██║╚██╗██║╚██╗ ██╔╝██║╚════██║██║██╔══██╗██║     ██╔══╝  ╚════██║
" ██║██║ ╚████║ ╚████╔╝ ██║███████║██║██████╔╝███████╗███████╗███████║
" ╚═╝╚═╝  ╚═══╝  ╚═══╝  ╚═╝╚══════╝╚═╝╚═════╝ ╚══════╝╚══════╝╚══════╝
set list
set listchars=
set listchars+=tab:·\ 
set listchars+=trail:░
set listchars+=extends:»
set listchars+=precedes:«
set listchars+=nbsp:░

" ██╗   ██╗ ██████╗ ██╗███╗   ██╗██╗  ██╗
" ╚██╗ ██╔╝██╔═══██╗██║████╗  ██║██║ ██╔╝
"  ╚████╔╝ ██║   ██║██║██╔██╗ ██║█████╔╝ 
"   ╚██╔╝  ██║   ██║██║██║╚██╗██║██╔═██╗ 
"    ██║   ╚██████╔╝██║██║ ╚████║██║  ██╗
"    ╚═╝    ╚═════╝ ╚═╝╚═╝  ╚═══╝╚═╝  ╚═╝
" -*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
nmap <c-[> <plug>(YoinkPostPasteSwapBack)
nmap <c-]> <plug>(YoinkPostPasteSwapForward)

nmap p <plug>(YoinkPaste_p)
nmap P <plug>(YoinkPaste_P)

" Also replace the default gp with yoink paste so we can toggle paste in this case too
nmap gp <plug>(YoinkPaste_gp)
nmap gP <plug>(YoinkPaste_gP)

" ██████╗  █████╗ ███╗   ██╗ ██████╗ ███████╗██████╗ 
" ██╔══██╗██╔══██╗████╗  ██║██╔════╝ ██╔════╝██╔══██╗
" ██████╔╝███████║██╔██╗ ██║██║  ███╗█████╗  ██████╔╝
" ██╔══██╗██╔══██║██║╚██╗██║██║   ██║██╔══╝  ██╔══██╗
" ██║  ██║██║  ██║██║ ╚████║╚██████╔╝███████╗██║  ██║
" ╚═╝  ╚═╝╚═╝  ╚═╝╚═╝  ╚═══╝ ╚═════╝ ╚══════╝╚═╝  ╚═╝
" -*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
if has('nvim')
    function! s:Ranger(...)
        let path = a:0 ? a:1 : getcwd()

        if !isdirectory(path)
            echom 'Not a directory: ' . path
            return
        endif

        let s:ranger_tempfile = tempname()
        let opts = ' --cmd="set viewmode multipane"'
        let opts .= ' --choosefiles=' . shellescape(s:ranger_tempfile)
        if a:0 > 1
            let opts .= ' --selectfile='. shellescape(a:2)
        else
            let opts .= ' ' . shellescape(path)
        endif
        let rangerCallback = {}

        function! rangerCallback.on_exit(id, code, _event)
            " Open previous buffer or new buffer *before* deleting the terminal
            " buffer. This ensures that splits don't break if ranger is opened in
            " a split window.
            if w:_ranger_del_buf != w:_ranger_prev_buf
                " Restore previous buffer
                exec 'silent! buffer! '. w:_ranger_prev_buf
            else
                " Previous buffer was empty
                enew
            endif

            " Delete terminal buffer
            exec 'silent! bdelete! ' . w:_ranger_del_buf

            unlet! w:_ranger_prev_buf w:_ranger_del_buf

            let names = ''
            if filereadable(s:ranger_tempfile)
                let names = readfile(s:ranger_tempfile)
            endif
            if empty(names)
                return
            endif
            for name in names
                exec 'edit ' . fnameescape(name)
                doautocmd BufRead
            endfor
        endfunction

        " Store previous buffer number and the terminal buffer number
        let w:_ranger_prev_buf = bufnr('%')
        enew
        let w:_ranger_del_buf = bufnr('%')

        " Open ranger in nvim terminal
        call termopen('ranger ' . opts, rangerCallback)
        startinsert
    endfunction

    let g:loaded_netrwPlugin = 'disable'
    augroup ReplaceNetrwWithRanger
        autocmd StdinReadPre * let s:std_in = 1
        autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | call s:Ranger(argv()[0]) | endif
    augroup END

    command! -complete=dir -nargs=* Ranger :call <SID>Ranger(<f-args>)
endif

" ranger
let g:ranger_map_keys = 0
nnoremap <silent><leader>r :Ranger<CR>

" ███████╗██████╗ ██╗     ██╗████████╗███████╗
" ██╔════╝██╔══██╗██║     ██║╚══██╔══╝██╔════╝
" ███████╗██████╔╝██║     ██║   ██║   ███████╗
" ╚════██║██╔═══╝ ██║     ██║   ██║   ╚════██║
" ███████║██║     ███████╗██║   ██║   ███████║
" ╚══════╝╚═╝     ╚══════╝╚═╝   ╚═╝   ╚══════╝
" -*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*

func! WinMove(key)
    let t:curwin = winnr()
    exec "wincmd ".a:key
    if (t:curwin == winnr())
        if (match(a:key,'[jk]'))
            wincmd v
        else
            wincmd s
        endif
        exec "wincmd ".a:key
    endif
endfu

nnoremap <silent><C-h> :call WinMove('h')<cr>
nnoremap <silent><C-j> :call WinMove('j')<cr>
nnoremap <silent><C-k> :call WinMove('k')<cr>
nnoremap <silent><C-l> :call WinMove('l')<cr>
set fillchars+=vert:│

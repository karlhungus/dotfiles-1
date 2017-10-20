"" Plugins
let g:vim_markdown_folding_disabled = 1

"" Emmet
let g:user_emmet_install_global = 0
let g:user_emmet_leader_key     = "<C-X>"

" CommandT
let g:CommandTWildIgnore=&wildignore . ",**/node_modules/*"
let g:CommandTFileScanner="git"

" NERDTree
let g:NERDSpaceDelims=1
let g:NERDTreeIgnore=["__pycache__", "\.egg-info"]

" airline
let g:airline_powerline_fonts        = 1
let g:airline_section_z              = airline#section#create_right(["%l/%L"])
let g:airline#extensions#ale#enabled = 1
let g:airline_theme                  = "badwolf"

" ale
let g:ale_set_loclist              = 0 " disable loc list
let g:ale_set_quickfix             = 1 " use quickfix list instead
let g:ale_open_list                = 1 " open the list when errors are present
let g:ale_lint_on_enter            = 0 " don't lint when opening a file
let g:ale_fix_on_save              = 1 " lint/correct on save

" localvimrc
let g:localvimrc_ask     = 0
let g:localvimrc_sandbox = 0

" Treat these tags like the block tags they are
let g:html_indent_tags = 'li\|p\|header\|footer\|section\|aside\|nav'

" use ag if available
if executable("ag")
  let g:ackprg = "ag --nogroup --column"
endif

" scala
let g:scala_scaladoc_indent = 1

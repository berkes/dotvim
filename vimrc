"Pathogen as per https://github.com/tpope/vim-pathogen
call pathogen#infect()

syntax on
filetype plugin indent on

" NERDTree configuration
let NERDTreeIgnore=['\.pyc$', '\.rbc$', '\~$']
map <Leader>n :NERDTreeToggle<CR>
"

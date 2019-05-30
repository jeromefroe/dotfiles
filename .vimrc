set background=dark
colorscheme solarized

:set mouse=a
:set number

:syntax on

"Highlight characters beyond 100 character column limit. Source:
"https://stackoverflow.com/questions/235439/vim-80-column-layout-concerns
highlight OverLength ctermbg=red ctermfg=white guibg=#592929
match OverLength /\%101v.\+/

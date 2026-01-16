
vim.cmd [[
try
    autocmd!
    autocmd ColorScheme * highlight Normal guibg=NONE ctermbg=NONE
    autocmd ColorScheme * highlight NonText guibg=NONE ctermbg=NONE 
	" autocmd ColorScheme * highlight Normal guifg=#c1aa78
	" autocmd ColorScheme * highlight Identifier guifg=#c1aa78
	" autocmd ColorScheme * highlight Constant guifg=#d1b387
	" autocmd ColorScheme * highlight Local guifg=#d1b387
    " let s:white = { "gui": "#ff0000", "cterm": "145", "cterm16" : "7" }
    " autocmd ColorScheme * call onedark#set_highlight("Normal", { "fg": s:white }) " `bg` will not be styled since there is no `bg` setting

	let g:onedark_color_overrides = {
	\ "background": {"gui": "#ff0000", "cterm": "235", "cterm16": "0" },
	\ "foreground": { "gui": "#0000ff", "cterm": "170", "cterm16": "5" },
	\ "normal": { "gui": "#00ff00", "cterm": "145", "cterm16": "7" }
	\}
    colorscheme onedark 

    " colorscheme sonokai
catch /^Vim\%((\a\+)\)\=:E185/
  colorscheme default
  set background=dark
endtry
]]

-- vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
-- vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none"})


local M = {}

vim.cmd([[
try
    autocmd!
    autocmd ColorScheme * highlight Normal guibg=NONE ctermbg=NONE
    autocmd ColorScheme * highlight NonText guibg=NONE ctermbg=NONE

catch /^Vim\%((\a\+)\)\=:E185/
  colorscheme default
  set background=dark
endtry
]])

local colors = {
	bg = "#000000",
	fg = "#d1b387",

	red = "#E06C75",
	dark_red = "#BE5046",
	green = "#98C379",
	light_green = "#0AF50E",
	yellow = "#E5C07B",
	orange = "#FFB07B",
	dark_yellow = "#D19A66",
	blue = "#61AFEF",
	purple = "#C678DD",
	cyan = "#56B6C2",
	white = "#ABB2BF",
	black = "#282C34",

	foreground = "#D1B387",
	background = "#282C34",

	comment_grey = "#5C6370",
	gutter_fg_grey = "#4B5263",
	cursor_grey = "#2C323C",
	visual_grey = "#3E4452",
	menu_grey = "#3E4452",
	special_grey = "#3B4048",
	vertsplit = "#3E4452",
}

-- #1E1E1E
-- #232323
-- #282828

function M.colorscheme()
	vim.cmd("highlight clear")
	vim.cmd("syntax reset")

	vim.o.background = "dark"
	vim.g.colors_name = "wyvern_colors"
	vim.g.terminal_color_7 = colors.fg

	local set = vim.api.nvim_set_hl
	set(0, "MatchParen", { bg = colors.visual_grey, fg = colors.light_green })
	set(0, "Normal", { fg = colors.fg })
	set(0, "Local", { fg = colors.fg })
	set(0, "Comment", { fg = colors.comment_grey, italic = true })

	set(0, "String", { fg = colors.green })
	set(0, "Character", { fg = colors.green })

	set(0, "Number", { fg = colors.dark_yellow })

	set(0, "Constant", { fg = colors.cyan })
	set(0, "Boolean", { fg = colors.dark_yellow })
	set(0, "Statement", { fg = colors.dark_yellow })
	set(0, "Label", { fg = colors.dark_yellow })

	set(0, "Special", { fg = colors.blue })

	-- set(0, 'Cursor', { fg = colors.green, bg = colors.cyan})
	-- set(0, 'CursorLine', {bg=colors.comment_grey})

	set(0, "Operator", { fg = colors.purple })
	set(0, "Directory", { fg = colors.blue })
	set(0, "ErrorMsg", { fg = colors.red })
	set(0, "LineNr", { fg = colors.gutter_fg_grey })
	set(0, "IncSearch", { fg = colors.yellow, bg = colors.comment_grey })
	set(0, "FoldColumn", {})
	set(0, "SignColumn", {})
	set(0, "DiffChange", { fg = colors.yellow, undercurl = true })
	set(0, "Keyword", { fg = colors.purple })
	set(0, "odinKeyword", { fg = colors.purple })
	set(0, "Conditional", { fg = colors.purple })
	set(0, "PreProc", { fg = colors.purple })
	set(0, "Structure", { fg = colors.purple })
	set(0, "Include", { fg = colors.blue })

	set(0, "LspErrorText", { fg = colors.red })
	set(0, "LspWarningText", { fg = colors.yellow })
	set(0, "LspInformationText", { fg = colors.blue })
	set(0, "LspHintText", { fg = colors.cyan })
	set(0, "LspErrorHighlight", { fg = colors.red, underline = true })
	set(0, "LspWarningHighlight", { fg = colors.yellow, underline = true })
	set(0, "LspInformationHighlight", { fg = colors.blue, underline = true })
	set(0, "LspHintHighlight", { fg = colors.cyan, underline = true })

	set(0, "DiagnosticError", { fg = colors.red })
	set(0, "DiagnosticWarning", { fg = colors.yellow })
	set(0, "DiagnosticInformation", { fg = colors.blue })
	set(0, "DiagnosticHint", { fg = colors.cyan })
	set(0, "DiagnosticUnderlineError", { fg = colors.red, underline = true })
	set(0, "DiagnosticUnderlineWarn", { fg = colors.yellow, underline = true })
	set(0, "DiagnosticUnderlineInfo", { fg = colors.blue, underline = true })
	set(0, "DiagnosticUnderlineHint", { fg = colors.cyan, underline = true })

	set(0, "Function", { fg = colors.blue })
	set(0, "@Function", { fg = colors.blue })
	set(0, "SpellBad", { fg = colors.red, underline = true })
	set(0, "WarningMsg", { fg = colors.yellow })
	set(0, "Error", { fg = colors.red })
	set(0, "Type", { fg = colors.yellow })
	set(0, "cType", { fg = colors.purple})
	set(0, "cStorageClass", { fg = colors.purple})
	set(0, "Identifier", { fg = colors.cyan })

	set(0, "glslQualifier", { fg = colors.purple }) -- layout, in, out, uniform, const
	set(0, "glslType", { fg = colors.cyan }) -- vec3, float, int, etc.
	set(0, "glslBuiltin", { fg = colors.purple }) -- gl_Position, gl_FragCoord, etc.
	set(0, "glslStructure", { fg = colors.purple })
	set(0, "glslFunction", { fg = colors.purple })
	set(0, "glslDefine", { fg = colors.blue })
	set(0, "glslInclude", { fg = colors.orange })
	set(0, "glslStatement", { fg = colors.purple})
end

return M

--vim.api.nvim_exec('language en_US', true)
--[[ vim.opt.foldmethod = "expr" ]]
--[[ vim.opt.foldexpr = "nvim_treesitter#foldexpr()" ]]

require "user.options"
require "user.keymaps"
require "user.plugins"
require "user.colorscheme"
require "user.copilot"
-- require "user.cmp"
require "user.lsp"
require "user.telescope"
require "user.treesitter"
require "user.autopairs"
require "user.comment"
require "user.gitsigns"
require "user.nvim-tree"
require "user.bufferline"
require "user.lualine"
require "user.toggleterm"
require "user.project"
require "user.impatient"
require "user.cpp-tools"
require "user.indentline"
require "user.alpha"
require "user.whichkey"
require "user.autocommands"
require "user.autosessions"
-- require "nvim-comment"
require "user.nvim-dap"

--[[ https://github.com/toppair/reach.nvim ]]
require "user.harpoon"
-- require "user.vimspector"
require "user.undotree"
require "user.lazygit"
require "user.todo_comments"

--[[ require "user.glslview" ]]

-- print("NVIM init called!")

if vim.g.neovide then
    vim.g.neovide_cursor_trail_legnth = 0
    vim.g.neovide_cursor_animation_length = 0
    vim.o.guifont = "Jetbrains Mono"
end

-- Extra settings
vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
vim.cmd('highlight Search guibg=#4b9ba8 guifg=#13252B')


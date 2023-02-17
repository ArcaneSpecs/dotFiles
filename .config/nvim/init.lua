vim.api.nvim_exec('language en_US', true)

require "user.options"
require "user.keymaps"
require "user.plugins"
require "user.colorscheme"
require "user.cmp"
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
require "user.indentline"
require "user.alpha"
require "user.whichkey"
require "user.autocommands"
-- require "nvim-comment"
require "user.nvim-dap"
require "user.harpoon"
require "user.vimspector"
require "user.undotree"

-- print("NVIM init called!")

if vim.g.neovide then
    vim.g.neovide_cursor_trail_legnth = 0
    vim.g.neovide_cursor_animation_length = 0
    vim.o.guifont = "Jetbrains Mono"
end



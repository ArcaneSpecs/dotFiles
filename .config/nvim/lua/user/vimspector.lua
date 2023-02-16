local status_ok, vimspector = pcall(require, "vimspector")
if not status_ok then
	return
end

vimspector.setup({


})


local opts = { noremap = true, silent = true }
local term_opts = { silent = true }
-- Shorten function name
local keymap = vim.api.nvim_set_keymap

keymap("n",  "<leader>y", ":call vimspector#Launch()", opts)
keymap("n",  "<leader>u", ":call vimspector#Reset()", opts)


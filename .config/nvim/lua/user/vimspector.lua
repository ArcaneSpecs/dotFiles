local status_ok, vimspector = pcall(require, "vimspector")
if not status_ok then
	return
end

vimspector.setup({

})

vimspector.configurations.cpp = {
    {
        name = 'Launch',
        type = 'llbd',
        request = 'launch',
        program = '${workspaceFolder}/build/bin/Debug-windows-x86_64/WyvernEditor/WyvernEditor.exe',
        cwd = '${workspaceFolder}',
        sourceMaps = true,
        protocol = 'inspector'
    },
}
vimspector.enable_for_current_project()

local opts = { noremap = true, silent = true }
local term_opts = { silent = true }
-- Shorten function name
local keymap = vim.api.nvim_set_keymap

keymap("n",  "<leader>y", ":call vimspector#Launch()", opts)
keymap("n",  "<leader>u", ":call vimspector#Reset()", opts)


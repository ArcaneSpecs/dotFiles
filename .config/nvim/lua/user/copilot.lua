
vim.g.copilot_no_tab_map = true
vim.g.copilot_assume_mapped = true
vim.g.copilot_tab_fallback = ""
--[[ vim.api.nvim_set_keymap("i", "<C-s>", 'copilot#Accept("<CR>")', { silent = true, expr = true }) ]]

vim.cmd[[imap <silent><script><expr> <C-s> copilot#Accept("\<CR>")]]
vim.cmd[[highlight CopilotSuggestion guifg=#555555 ctermfg=8]]

vim.g.copilot_filetypes = {
    ["*"] = true,
    ["xml"] = false,
    ["json"] = false,
}




--vim.api.nvim_exec('language en_US', true)
--[[ vim.opt.foldmethod = "expr" ]]
--[[ vim.opt.foldexpr = "nvim_treesitter#foldexpr()" ]]

require("user.options")
require("user.keymaps")
require("user.plugins")
require("user.colorscheme")
require("user.copilot")
-- require "user.cmp"
-- require("user.lsp")
require("user.telescope")
require("user.treesitter")
require("user.autopairs")
require("user.gitsigns")
require("user.nvim-tree")
require("user.bufferline")
require("user.lualine")
require("user.toggleterm")
require("user.project")
require("user.impatient")
require("user.cpp-tools")
-- require("user.indentline")
require("user.alpha")
require("user.whichkey")
require("user.autocommands")
require("user.autosessions")
require("user.nvim-dap")
require("user.noice")

require("user.WyvernChatConfig")

--[[ https://github.com/toppair/reach.nvim ]]
require("user.harpoon")
-- require "user.vimspector"
require("user.undotree")
require("user.todo_comments")

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
vim.cmd("highlight Search guibg=#4b9ba8 guifg=#13252B")
-- vim.cmd("highlight Visual guifg=#9f3388 guibg=#2e1219")
-- vim.cmd("highlight Visual guifg=#e678DD guibg=#1e1219")
vim.cmd("highlight Visual guifg=#b060DD guibg=#1e1219")


vim.api.nvim_create_autocmd({ 'VimEnter', 'SessionLoadPost' }, {
    callback = function()
        if vim.g.SessionLoad then return end
        vim.cmd('NvimTreeOpen')
        -- vim.cmd('vnew')
        vim.cmd.wincmd('l')
        -- vim.cmd('vnew')
        -- vim.cmd('bd')
        vim.cmd('NvimTreeClose')
    end,
    once = true
})


local rainbow_group = vim.api.nvim_create_augroup("rainbow_csv", { clear = true })

vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
    pattern = { '*.csv', '*.tsv', "*.csv_semicolon" },
    group = rainbow_group,
    callback = function(event)
        -- vim.notify("Rainbow CSV loaded", vim.log.levels.WARN)
        local map = function(keys, func, desc)
            vim.keymap.set("n", keys, func,
                { buffer = event.buf, desc = "LSP: " .. desc })
        end
        map('<A-l>', ':RainbowCellGoRight<CR>', "Go right")
        map('<A-h>', ':RainbowCellGoLeft<CR>', "Go left")
        map('<A-j>', ':RainbowCellGoDown<CR>', "Go down")
        map('<A-k>', ':RainbowCellGoUp<CR>', "Go up")
        map('<A-g>', ':RainbowAlign<CR>', "Align") -- NOTE: This can be used to formats the fields
        map('<A-t>', ':RainbowDelim<CR>', "Align") -- NOTE: This can be used to formats the fields
        map('<A-y>', ':RainbowDelimSimple<CR>', "Set delimiter")
        vim.fn.search(',', 'c')
        vim.cmd('RainbowDelimSimple')
        vim.cmd('RainbowAlign')

        -- vim.cmd("setfiletype csv")
    end
})

vim.api.nvim_create_autocmd({ 'BufNewFile', 'BufRead' }, {
    pattern = '*.dat',
    group = rainbow_group,
    callback = function()
        vim.cmd("set filetype=csv_pipe")
    end
})

-- vim.api.nvim_create_autocmd({'BufNewFile', 'BufRead'}, {
--     pattern = '*.csv',
--     callback = function()
--     end
-- })
--

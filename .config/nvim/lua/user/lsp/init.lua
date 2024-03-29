local status_ok, _ = pcall(require, "lspconfig")
if not status_ok then
    return
end

--[[ require "user.lsp.configs" ]]
--[[ require("user.lsp.handlers").setup() ]]
--[[ require "user.lsp.null-ls" ]]
local snip_status_ok, luasnip = pcall(require, "luasnip")
if not snip_status_ok then
    return
end

require("luasnip/loaders/from_vscode").lazy_load()


local lsp = require("lsp-zero")

lsp.extend_lspconfig()

lsp.preset("recommended")

lsp.setup_servers({
    'tsserver',
    'rust_analyzer',
    'clangd',
    'lua_ls',
    'pyright',
    'texlab',
})

local signs = { Error = "󰅚 ", Warn = "󰀪 ", Hint = "󰌶 ", Info = " " }
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

--[[
lsp.set_preferences({
    -- suggest_lsp_servers = false,
    suggest_lsp_servers = true,
    sign_icons = {
        error = '',
        --error = 'TEPPOOO!',
        warn  = '',
        info  = '',
        hint  = ''
    }
})
]]--

--[[ lsp.configure('lua-language-server', { ]]
lsp.use('lua_ls', {
    settings = {
        Lua = {
            diagnostics = {
                globals = { 'vim' }
            },
            workspace = {
                library = {
                    [vim.fn.expand("$VIMRUNTIME/lua")] = true,
                    [vim.fn.stdpath("config") .. "/lua"] = true,
                },
            }
        }
    }
})

lsp.use('clangd', {
    cmd = {
        "clangd",
        "--all-scopes-completion",
        "--suggest-missing-includes",
        "--background-index",
        "--pch-storage=disk",
        "--cross-file-rename",
        "--log=info",
        "--completion-style=detailed",
        "--enable-config",          -- clangd 11+ supports reading from .clangd configuration file
        "--clang-tidy",
        "--offset-encoding=utf-16", --temporary fix for null-ls
        -- "--clang-tidy-checks=-*,llvm-*,clang-analyzer-*,modernize-*,-modernize-use-trailing-return-type",
        -- "--fallback-style=Google",
        -- "--header-insertion=never",
        -- "--query-driver=<list-of-white-listed-complers>"
    }
})

-- lsp.configure(
--     'glsls', {
--         settings = {
--             filetypes = {
--                 'glsl', 'frag', 'vert', 'geom', 'comp', 'tesc', 'tese'
--             }
--         }
--     }
-- )

local check_backspace = function()
    local col = vim.fn.col "." - 1
    return col == 0 or vim.fn.getline("."):sub(col, col):match "%s"
end

local cmp = require('cmp')
local cmp_select = { behavior = cmp.SelectBehavior.Select }
local cmp_mappings = lsp.defaults.cmp_mappings({
    ['<C-k>'] = cmp.mapping.select_prev_item(cmp_select),
    ['<C-j>'] = cmp.mapping.select_next_item(cmp_select),
    ['<C-l>'] = cmp.mapping.confirm({ select = true }),
    ["<C-Space>"] = cmp.mapping.complete(),
    ["<C-y>"] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
    ["<C-e>"] = cmp.mapping {
        i = cmp.mapping.abort(),
        c = cmp.mapping.close(),
    },
    -- Accept currently selected item. If none selected, `select` first item.
    -- Set `select` to `false` to only confirm explicitly selected items.
    ["<CR>"] = cmp.mapping.confirm { select = false },
    ["<Tab>"] = cmp.mapping(function(fallback)
        if cmp.visible() then
            cmp.select_next_item()
        elseif luasnip.expandable() then
            luasnip.expand()
        elseif luasnip.expand_or_jumpable() then
            luasnip.expand_or_jump()
        elseif check_backspace() then
            fallback()
        else
            fallback()
        end
    end, {
        "i",
        "s",
    }),
    ["<S-Tab>"] = cmp.mapping(function(fallback)
        if cmp.visible() then
            cmp.select_prev_item()
        elseif luasnip.jumpable(-1) then
            luasnip.jump(-1)
        else
            fallback()
        end
    end, {
        "i",
        "s",
    }),
})

--[[ cmp_mappings['<Tab>'] = nil ]]
--[[ cmp_mappings['<S-Tab>'] = nil ]]
--   פּ ﯟ   some other good icons
local kind_icons = {
    Text = "",
    --[[ Method = "m", ]]
    Method = "ƒ ",
    Function = "",
    Constructor = "",
    Field = "",
    Variable = "",
    Class = "",
    Interface = "",
    Module = "",
    Property = "",
    Unit = "",
    Value = "",
    Enum = "",
    Keyword = "",
    Snippet = "",
    Color = "",
    File = "",
    Reference = "",
    Folder = "",
    EnumMember = "",
    Constant = "",
    Struct = "",
    Event = "",
    Operator = "",
    TypeParameter = "",
}
-- find more here: https://www.nerdfonts.com/cheat-sheet

local cmp = require('cmp')
local cmp_action = require('lsp-zero').cmp_action()

cmp.setup({
    mapping = cmp_mappings,
    window = {
        completion = cmp.config.window.bordered(),
        documentation = {
            border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
            max_width = 50,
            max_height = 50
        }
    },
    formatting = {
        fields = { "abbr", "kind", "menu" },
        format = function(entry, vim_item)
            vim_item.abbr = string.format('%.30s', vim_item.abbr) -- Limit the tooltip length

            -- Kind icons
            -- This concatonates the icons with the name of the item kind
            --[[ vim_item.kind = string.format('%s %s', kind_icons[vim_item.kind], vim_item.kind) ]]
            vim_item.kind = string.format("%s", kind_icons[vim_item.kind])
            vim_item.menu = ({
                nvim_lsp = "[LSP]",
                luasnip = "[Snippet]",
                --[[ ultisnips = "[Ultisnips]", ]]
                buffer = "[Buffer]",
                path = "[Path]",
            })[entry.source.name]
            return vim_item
        end,
    },
    sources = {
        { name = "nvim_lsp" },
        { name = "luasnip" },
        --[[ { name = "Ultisnips" }, ]]
        { name = "buffer" },
        { name = "path" },
    },
})


lsp.on_attach(function(client, bufnr)
    --[[ lsp.default_keymaps({buffer = bufnr}) ]]
    local opts = { buffer = bufnr, noremap = true, silent = true }

    vim.keymap.set("n", "gD", function() vim.lsp.buf.declaration() end, opts)
    vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
    vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
    vim.keymap.set("n", "gw", function() vim.lsp.buf.workspace_symbol() end, opts)
    vim.keymap.set("n", "gW", function() vim.diagnostic.open_float() end, opts)
    vim.keymap.set("n", "<M-e>", function() vim.diagnostic.goto_next() end, opts)
    vim.keymap.set("n", "<M-d>", function() vim.diagnostic.goto_prev() end, opts)
    vim.keymap.set("n", "ga", function() vim.lsp.buf.code_action() end, opts)
    vim.keymap.set("n", "gr", function() vim.lsp.buf.references() end, opts)
    vim.keymap.set("n", "gR", function() vim.lsp.buf.rename() end, opts)
    vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
    vim.keymap.set("n", "<leader>q", function() vim.diagnostic.setloclist() end, opts)
end)

lsp.setup()

vim.diagnostic.config({
    virtual_text = true,
    update_in_insert = true,
    underline = true,
    severity_sort = true,
    float = {
        focusable = false,
        style = "minimal",
        border = "rounded",
        source = "always",
        header = "",
        prefix = "",
    }
})

vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
    border = "single",
    width = 80,
})

vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
    border = "single",
    width = 80,
})

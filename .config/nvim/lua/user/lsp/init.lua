local status_ok, _ = pcall(require, "lspconfig")
if not status_ok then
  return
end

--[[ require "user.lsp.configs" ]]
--[[ require("user.lsp.handlers").setup() ]]
--[[ require "user.lsp.null-ls" ]]

local lsp = require("lsp-zero")

lsp.preset("recommended")

lsp.ensure_installed({
    'clangd',
    'texlab'
})

lsp.configure('lua-language-server', {
    settings = {
        Lua = {
            diagnostics = {
                globals = { 'vim' }
            }
        }
    }
})

--[[
local cmp = require('cmp')
local cmp_select = {behavior = cmp.SelectBehavior.Select}
local cmp_mappings = lsp.defaults.cmp_mappings({
  ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
  ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
  ['<C-y>'] = cmp.mapping.confirm({ select = true }),
  ["<C-Space>"] = cmp.mapping.complete(),
})

cmp_mappings['<Tab>'] = nil
cmp_mappings['<S-Tab>'] = nil

lsp.setup_nvim_cmp({
  mapping = cmp_mappings
})
]]--

lsp.set_preferences({
    suggest_lsp_servers = false,
    sign_icons = {
        error = '',
        --error = 'TEPPOOO!',
        warn  = '', 
        info  = '', 
        hint  = ''
    }
})

lsp.on_attach(function(client, bufnr)
  local opts = {buffer = bufnr, noremap = true, silent = true}

  --[[ vim.api.nvim_buf_set_keymap(bufnr, "n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts) ]]
  vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
  vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
  vim.keymap.set("n", "<leader>hws", function() vim.lsp.buf.workspace_symbol() end, opts)
  vim.keymap.set("n", "<leader>hd", function() vim.diagnostic.open_float() end, opts)
  vim.keymap.set("n", "<M-e>", function() vim.diagnostic.goto_next() end, opts)
  vim.keymap.set("n", "<M-d>", function() vim.diagnostic.goto_prev() end, opts)
  vim.keymap.set("n", "<leader>ja", function() vim.lsp.buf.code_action() end, opts)
  vim.keymap.set("n", "<leader>jr", function() vim.lsp.buf.references() end, opts)
  vim.keymap.set("n", "<leader>jn", function() vim.lsp.buf.rename() end, opts)
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
    border = "rounded",
    width = 60,
})

vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
    border = "rounded",
    width = 60,
})


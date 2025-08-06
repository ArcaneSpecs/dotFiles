local status_ok, tabnine = pcall(require, "tabnine")
if not status_ok then
    print("Tabnine not found!")
    return
end

local opts = {
    disable_auto_comment = true,
    accept_keymap = "<C-s>",
    dismiss_keymap = "<C-d>",
    max_num_results = 20,
    debounce_ms = 600,
    suggestion_color = { gui = "#1cd7ff", cterm = 244 },
    exclude_filetypes = { "TelescopePrompt", "NvimTree" },
    log_file_path = nil, -- absolute path to Tabnine log file
    ignore_certificate_errors = false,
}

tabnine.setup(opts)

vim.keymap.set("i", "<C-s>", function()
    if require("tabnine.keymaps").has_suggestion() then
        return require("tabnine.keymaps").accept_suggestion()
    elseif require("luasnip").jumpable(1) then
        return require("luasnip").jump(1)
    else
        return "<A-l>"
    end
end, { expr = true })


local status_ok, lualine = pcall(require, "lualine")
if not status_ok then
    return
end

local hide_in_width = function()
    return vim.fn.winwidth(0) > 80
end


local diagnostics = {
    "diagnostics",
    sources = { "nvim_diagnostic" },
    sections = { "error", "warn" },
    symbols = { error = " ", warn = " " },
    colored = false,
    update_in_insert = false,
    always_visible = true,
}

-- 
-- 
-- 
-- 
-- 
-- 
-- 
-- 
-- 

local diff = {
    "diff",
    colored = true,
    symbols = { added = " ", modified = " ", removed = " " }, -- changes diff symbols
    cond = hide_in_width
}

local mode = {
    "mode",
    fmt = function(str)
        --[[ return "  " .. str .. " " ]]
        --[[ return "  " .. str.sub(str, 1, 1) .. " " ]]
        return " " .. str.sub(str, 1, 3) .. " "
    end,
}
-- 
-- 
-- 
local filetype = {
    "filetype",
    icons_enabled = true,
    icon = nil,
}

local branch = {
    "branch",
    icons_enabled = true,
    icon = "",
}

local location = {
    "location",
    padding = 0,
}

-- cool function for progress
local progress = function()
    local current_line = vim.fn.line(".")
    local total_lines = vim.fn.line("$")
    local chars = { "__", "▁▁", "▂▂", "▃▃", "▄▄", "▅▅", "▆▆", "▇▇", "██" }
    local line_ratio = current_line / total_lines
    local index = math.ceil(line_ratio * #chars)
    return chars[index]
end

local filename = {
    "filename",
    path = 3
}

local spaces = function()
    return "Spaces: " .. vim.api.nvim_buf_get_option(0, "shiftwidth")
end

local colors = {
    blue   = '#80a0ff',
    cyan   = '#79dac8',
    black  = '#0a0a0a',
    white  = '#c6c6c6',
    red    = '#cc3189',
    violet = '#d183e8',
    grey   = '#343434',
}

local one_theme = {
    normal = {
        a = { fg = colors.black, bg = colors.cyan },
        b = { fg = colors.white, bg = colors.grey },
        c = { fg = colors.white, bg = colors.black },
    },
    insert = { a = { fg = colors.black, bg = colors.blue } },
    visual = { a = { fg = colors.black, bg = colors.violet } },
    replace = { a = { fg = colors.black, bg = colors.red } },
    inactive = {
        a = { fg = colors.white, bg = colors.black },
        b = { fg = colors.white, bg = colors.black },
        c = { fg = colors.white, bg = colors.black },
    },
}

local function_name = function()
    local function_name = vim.fn.expand('%:t')
    if function_name == '' then
        function_name = '[No Name]'
    end
    return function_name
end


lualine.setup({
    options = {
        --[[ section_separators = { left = '', right = '' }, ]]
        icons_enabled = true,
        theme = one_theme,
        --[[ component_separators = { left = '', right = '' }, ]]
        --[[ component_separators = { left = ' ', right = ' ' }, ]]
        --[[ component_separators = { left = ' ', right = ' ' }, ]]
        --[[ component_separators = { left = ' ', right = ' ' }, ]]
        --[[ component_separators = { left = '', right = '' }, ]]
        component_separators = { left = ' ', right = ' ' },
        --[[ component_separators = { left = ' ', right = ' ' }, ]]
        section_separators = { left = '  ', right = '  ' },
        --[[ component_separators = { left = '', right = ''}, ]]
        --[[ section_separators = { left = '', right = ''}, ]]
        --[[ component_separators = { left = "", right = "" }, ]]
        --[[ section_separators = { left = "", right = "" }, ]]
        disabled_filetypes = { "alpha", "dashboard", "NvimTree", "Outline" },
        always_divide_middle = true,
    },
    sections = {
        --[[ lualine_a = { branch, diagnostics, mode}, ]]
        lualine_a = { branch },
        lualine_b = { diagnostics },
        --[[ lualine_c = { mode }, ]]
        lualine_c = {},
        -- lualine_x = { "encoding", "fileformat", "filetype" },
        --[[ lualine_x = { filename, diff, spaces, "encoding", filetype }, ]]
        --[[ lualine_x = { filename, diff, function_name }, ]]
        lualine_x = { filename, diff },
        --[[ lualine_x = { filename, diff, filetype }, ]]
        lualine_y = { filetype },
        --[[ lualine_z = { progress }, ]]
        --[[ lualine_z = { filetype }, ]]
        lualine_z = {},
    },
    inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { filename },
        lualine_x = { "location" },
        lualine_y = {},
        lualine_z = { filetype },
    },
    tabline = {},
    extensions = {},
})

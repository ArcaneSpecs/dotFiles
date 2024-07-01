local status_ok, nvim_tree = pcall(require, "nvim-tree")
if not status_ok then
    print("nvim-tree not loaded!")
    return
end

--local config_status_ok, nvim_tree_config = pcall(require, "nvim-tree.config")
--if not config_status_ok then
--    print "nvim-tree.config doesn't exist?"
--    -- return
--end
--
--local tree_cb = nvim_tree_config.nvim_tree_callback


-- global
--vim.api.nvim_set_keymap("n", "<C-h>", ":NvimTreeToggle<cr>", {silent = true, noremap = true})

function my_on_attach(bufnr)
    local api = require("nvim-tree.api")

    local function opts(desc)
        return { desc = 'nvim-tree: ' .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
    end

    local function edit_or_open()
        local node = api.tree.get_node_under_cursor()

        if node.nodes ~= nil then
            -- expand or collapse folder
            api.node.open.edit()
        else
            -- open file
            api.node.open.edit()
            -- Close the tree if file was opened
            api.tree.close()
        end
    end

    local function jump_to_first_git()
        api.node.navigate.git.next_recursive()
    end

    local function jump_to_first_git_back()
        api.node.navigate.git.prev_recursive()
    end

    local function close_node()
        local node = api.tree.get_node_under_cursor()

        if node.nodes ~= nil then
            -- expand or collapse folder
            api.node.open.edit()
        else
            -- open file
            -- api.node.open.edit()
            -- Close the tree if file was opened
            -- api.tree.close()
        end
    end

    -- open as vsplit on current node
    local function vsplit_preview()
        local node = api.tree.get_node_under_cursor()

        if node.nodes ~= nil then
            -- expand or collapse folder
            api.node.open.edit()
        else
            -- open file as vsplit
            api.node.open.vertical()
        end

        -- Finally refocus on tree if it was lost
        api.tree.focus()
    end


    api.config.mappings.default_on_attach(bufnr)

    -- on_attach
    -- vim.keymap.set("n", "l", edit_or_open, {})
    -- vim.keymap.set("n", "L", vsplit_preview, {})
    -- vim.keymap.set("n", "h", api.tree.close, {})
    -- vim.keymap.set("n", "H", api.tree.collapse_all, {})
    vim.keymap.set('n', '?', api.tree.toggle_help, opts('Help'))
    vim.keymap.set('n', '1', jump_to_first_git, opts('Goto next git edit'))
    vim.keymap.set('n', '2', jump_to_first_git_back, opts('Goto previous git edit'))
    vim.keymap.set('n', 'l', edit_or_open, opts('Edit or Open'))
    vim.keymap.set('n', 'h', close_node, opts('Collapse node'))
    vim.keymap.set('n', 'L', vsplit_preview, opts('VSplit preview'))
end

nvim_tree.setup {
    on_attach = my_on_attach,
    update_focused_file = {
        enable = true,
        update_cwd = true,
    },
    renderer = {
        root_folder_modifier = ":t",
        icons = {
            glyphs = {
                default = "",
                symlink = "",
                folder = {
                    arrow_open = "",
                    arrow_closed = "",
                    default = "",
                    open = "",
                    empty = "",
                    empty_open = "",
                    symlink = "",
                    symlink_open = "",
                },
                git = {
                    unstaged = "",
                    staged = "S",
                    unmerged = "",
                    renamed = "➜",
                    untracked = "U",
                    deleted = "",
                    ignored = "◌",
                },
            },
        },
    },
    --open_on_setup = false,
    --[[ system_open = { ]]
    --[[   cmd = "kitty +kitten icat ~/.config/Wallpapers/Wallpaper.png", ]]
    --[[   args = {"+kitten", "icat", "~/.config/Wallpapers/Wallpaper.png"} ]]
    --[[ }, ]]
    diagnostics = {
        enable = true,
        show_on_dirs = true,
        icons = {
            hint = "",
            info = "",
            warning = "",
            error = "",
        },
    },
    view = {
        width = 45,
        --[[ height = 30, ]]
        side = "left"
    }
}

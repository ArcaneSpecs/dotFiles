local status_ok, telescope = pcall(require, "telescope")
if not status_ok then
    return
end

local actions = require "telescope.actions"

telescope.setup {
    defaults = {
        --  󰜏    󱘟 󱘞 󰭎   
        -- 󰧂 󱞪 󱞩 󱞶 󰵉 󰵌 󰵑 󰵕 󱡁 
        vimgrep_arguments = {
            'rg',
            '--color=never',
            '--no-heading',
            '--with-filename',
            '--line-number',
            '--column',
            '--smart-case',
            '--ignore-file',
            '/home/patu/.config/ignore_telescope/ignore_file.txt'
        },
        layout_strategy = 'vertical',
        layout_config = { height = 0.95 },
        prompt_prefix = " ",
        selection_caret = " ",
        path_display = { "truncate" },
        file_ignore_patterns = {
            --[[ ".cache", ]]
            --[[ ".git", ]]
            --[[ "build", ]]
            --[[ ".idea", ]]
            --[[ "includes", ]]
            --[[ "External", ]]
            --[[ "external", ]]
            --[[ "vendor", ]]
            --[[ "Vendor", ]]
            --[[ "%.obj", ]]
            --[[ "%.gltf", ]]
            --[[ "%.glb", ]]
            --[[ "%.wav", ]]
            --[[ "%.ogg", ]]
            --[[ "%.mp3", ]]
            --[[ "%.mp4", ]]
            --[[ "%.png", ]]
            --[[ "%.jpg", ]]
            --[[ "%.jpeg", ]]
            --[[ "%.gif", ]]
            --[[ "%.bin", ]]
            --[[ "%.zip", ]]
            --[[ "%.fbx", ]]
            --[[ "%.blend", ]]
            --[[ "%.blend1", ]]
            --[[ "%.kra", ]]
            --[[ "%.kra~", ]]
            --[[ "%.spv", ]]
            --[[ "%.ttf", ]]
            --[[ "%.otf", ]]
            --[[ "%.tga", ]]
            --[[ "%.hdr", ]]
            --[[ "%.hdri", ]]
        },
        mappings = {
            i = {
                ["<C-n>"] = actions.cycle_history_next,
                ["<C-p>"] = actions.cycle_history_prev,

                ["<C-j>"] = actions.move_selection_next,
                ["<C-k>"] = actions.move_selection_previous,

                ["<C-c>"] = actions.close,

                ["<Down>"] = actions.move_selection_next,
                ["<Up>"] = actions.move_selection_previous,

                ["<CR>"] = actions.select_default,
                ["<C-x>"] = actions.select_horizontal,
                ["<C-v>"] = actions.select_vertical,
                ["<C-t>"] = actions.select_tab,

                ["<C-u>"] = actions.preview_scrolling_up,
                ["<C-d>"] = actions.preview_scrolling_down,

                ["<PageUp>"] = actions.results_scrolling_up,
                ["<PageDown>"] = actions.results_scrolling_down,

                ["<Tab>"] = actions.toggle_selection + actions.move_selection_worse,
                ["<S-Tab>"] = actions.toggle_selection + actions.move_selection_better,
                ["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
                ["<M-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
                ["<C-l>"] = actions.complete_tag,
                ["<C-_>"] = actions.which_key, -- keys from pressing <C-/>
            },

            n = {
                ["<esc>"] = actions.close,
                ["<CR>"] = actions.select_default,
                ["<C-x>"] = actions.select_horizontal,
                ["<C-v>"] = actions.select_vertical,
                ["<C-t>"] = actions.select_tab,

                ["<Tab>"] = actions.toggle_selection + actions.move_selection_worse,
                ["<S-Tab>"] = actions.toggle_selection + actions.move_selection_better,
                ["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
                ["<M-q>"] = actions.send_selected_to_qflist + actions.open_qflist,

                ["j"] = actions.move_selection_next,
                ["k"] = actions.move_selection_previous,
                ["H"] = actions.move_to_top,
                ["M"] = actions.move_to_middle,
                ["L"] = actions.move_to_bottom,

                ["<Down>"] = actions.move_selection_next,
                ["<Up>"] = actions.move_selection_previous,
                ["gg"] = actions.move_to_top,
                ["G"] = actions.move_to_bottom,

                ["<C-u>"] = actions.preview_scrolling_up,
                ["<C-d>"] = actions.preview_scrolling_down,

                ["<PageUp>"] = actions.results_scrolling_up,
                ["<PageDown>"] = actions.results_scrolling_down,

                ["?"] = actions.which_key,
            },
        },
    },
    pickers = {
        -- Default configuration for builtin pickers goes here:
        -- picker_name = {
        --   picker_config_key = value,
        --   ...
        -- }
        -- Now the picker_config_key will be applied every time you call this
        find_files = {
            find_command = { 'rg', '--files', '--color=never', '--hidden', '--ignore-file', '/home/patu/.config/ignore_telescope/ignore_file.txt' }
        }
    }, -- builtin picker
    extensions = {
        -- Your extension configuration goes here:
        -- extension_name = {
        --   extension_config_key = value,
        -- }
        -- please take a look at the readme of the extension you want to configure
        advanced_git_search = {
            -- Browse command to open commits in browser. Default fugitive GBrowse.
            -- {commit_hash} is the placeholder for the commit hash.
            browse_command = "GBrowse {commit_hash}",
            -- when {commit_hash} is not provided, the commit will be appended to the specified command seperated by a space
            -- browse_command = "GBrowse",
            -- => both will result in calling `:GBrowse commit`

            -- fugitive or diffview
            diff_plugin = "fugitive",
            -- customize git in previewer
            -- e.g. flags such as { "--no-pager" }, or { "-c", "delta.side-by-side=false" }
            git_flags = {},
            -- customize git diff in previewer
            -- e.g. flags such as { "--raw" }
            git_diff_flags = {},
            -- Show builtin git pickers when executing "show_custom_functions" or :AdvancedGitSearch
            show_builtin_git_pickers = false,
            entry_default_author_or_date = "author", -- one of "author" or "date"
            keymaps = {
                -- following keymaps can be overridden
                toggle_date_author = "<C-w>",
                open_commit_in_browser = "<C-o>",
                copy_commit_hash = "<C-y>",
                show_entire_commit = "<C-e>",
            },

            -- Telescope layout setup
            telescope_theme = {
                function_name_1 = {
                    -- Theme options
                },
                function_name_2 = "dropdown",
                -- e.g. realistic example
                show_custom_functions = {
                    layout_config = { width = 0.4, height = 0.4 },
                },
            }
        }
    },
}

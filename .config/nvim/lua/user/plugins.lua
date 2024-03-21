-- [[ Install `lazy.nvim` plugin manager ]]
--    See `:help lazy.nvim.txt` or https://github.com/folke/lazy.nvim for more info
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    local lazyrepo = "https://github.com/folke/lazy.nvim.git"
    vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
end ---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)

-- NOTE: Here is where you install your plugins.
require("lazy").setup({
    -- NOTE: Plugins can be added with a link (or for a github repo: 'owner/repo' link).
    -- "tpope/vim-sleuth", -- Detect tabstop and shiftwidth automatically

    -- NOTE: Plugins can also be added by using a table,
    -- with the first argument being the link and the following
    -- keys can be used to configure plugin behavior/loading/etc.
    --
    -- Use `opts = {}` to force a plugin to be loaded.
    --
    --  This is equivalent to:
    --    require('Comment').setup({})

    -- "gc" to comment visual regions/lines
    {
        "numToStr/Comment.nvim",
        opts = {
            padding = true,
            sticky = true,
            ignore = nil,
            toggler = { line = 'gcc', block = 'gbc' },
            opleader = { line = 'gc', block = 'gb' },
            extra = { above = 'gcO', below = 'gco', eol = 'gcA' },
            mappings = { basic = true, extra = true },
            pre_hook = nil,
            post_hook = nil,
        }
    },

    -- Here is a more advanced example where we pass configuration
    -- options to `gitsigns.nvim`. This is equivalent to the following lua:
    --    require('gitsigns').setup({ ... })
    --
    -- See `:help gitsigns` to understand what the configuration keys do
    { -- Adds git related signs to the gutter, as well as utilities for managing changes
        "lewis6991/gitsigns.nvim",
        opts = {
            signs = {
                add = { text = "+" },
                change = { text = "~" },
                delete = { text = "_" },
                topdelete = { text = "‾" },
                changedelete = { text = "~" },
            },
        },
    },
    {
        -- Indent lines
        { 
            "lukas-reineke/indent-blankline.nvim", 
            main = "ibl", 
            opts = { } 
        }
    },
    {
        "fei6409/log-highlight.nvim",
        config = function()
            require("log-highlight").setup({

                -- The file extensions.
                extension = "log",

                -- The file names or the full file paths.
                filename = {
                    "messages",

                    -- The file path glob patterns, e.g. `.*%.lg`, `/var/log/.*`.
                    -- Note: `%.` is to match a literal dot (`.`) in a pattern in Lua, but most
                    -- of the time `.` and `%.` here make no observable difference.
                    pattern = {
                        "/var/log/.*",
                        "messages%..*",
                    },
                },
            })
        end,
    },
    {
        "skywind3000/asyncrun.vim"
    },
    {
        -- Surround
        "kylechui/nvim-surround",
        event = "VeryLazy",
        config = function()
            require("nvim-surround").setup({
                -- Configuration here, or leave empty to use defaults
            })
        end
    },
    {
        "rmagatti/auto-session",
        config = function() end,
        --log_level = "error",
        -- auto_session_suppress_dirs = {
        --     "~/",
        --     "~/Projects",
        --     "~/Downloads",
        --     "/",
        -- },
        dependencies = {
            "auto-session",
            {},
        },
    },
    {
        "nvim-lualine/lualine.nvim",
        commit = "3362b28f917acc37538b1047f187ff1b5645ecdd",
    },

    {
        -- Useful lua functions used by lots of plugins
        "nvim-lua/plenary.nvim",
        commit = "9a0d3bf7b832818c042aaf30f692b081ddd58bd9"
    },
    {
        -- Autopairs, integrates with both cmp and treesitter
        "windwp/nvim-autopairs"
    },
    {
        "akinsho/toggleterm.nvim",
        commit = "aaeed9e02167c5e8f00f25156895a6fd95403af8",
    },
    {
        'simrat39/inlay-hints.nvim'
    },
    {
        "github/copilot.vim",
    },
    {
        "mfussenegger/nvim-dap",
    },
    {
        "mfussenegger/nvim-dap-python",
    },
    {
        "leoluz/nvim-dap-go",
    },
    {
        "rcarriga/nvim-dap-ui",
    },
    {
        "theHamsta/nvim-dap-virtual-text",
    },
    {
        "mxsdev/nvim-dap-vscode-js",
    },
    {
        "microsoft/vscode-js-debug",
    },
    {
        "mbbill/undotree",
    },
    {
        "kdheepak/lazygit.nvim",
    },
    {
        "joshdick/onedark.vim",
    },
    {
        "ThePrimeagen/harpoon",
    },
    {
        "goolord/alpha-nvim",
        commit = "ef27a59e5b4d7b1c2fe1950da3fe5b1c5f3b4c94",
    },

    -- NOTE: Plugins can also be configured to run lua code when they are loaded.
    --
    -- This is often very useful to both group configuration, as well as handle
    -- lazy loading plugins that don't need to be loaded immediately at startup.
    --
    -- For example, in the following configuration, we use:
    --  event = 'VimEnter'
    --
    -- which loads which-key before all the UI elements are loaded. Events can be
    -- normal autocommands events (`:help autocmd-events`).
    --
    -- Then, because we use the `config` key, the configuration only runs
    -- after the plugin has been loaded:
    --  config = function() ... end

    {                       -- Useful plugin to show you pending keybinds.
        "folke/which-key.nvim",
        event = "VimEnter", -- Sets the loading event to 'VimEnter'
        -- config = function() -- This is the function that runs, AFTER loading
        --  require("which-key").setup()
        --
        --  -- Document existing key chains
        --  require("which-key").register({
        --      ["<leader>c"] = { name = "[C]ode", _ = "which_key_ignore" },
        --      ["<leader>d"] = { name = "[D]ocument", _ = "which_key_ignore" },
        --      ["<leader>r"] = { name = "[R]ename", _ = "which_key_ignore" },
        --      ["<leader>s"] = { name = "[S]earch", _ = "which_key_ignore" },
        --      ["<leader>w"] = { name = "[W]orkspace", _ = "which_key_ignore" },
        --  })
        -- end,
    },

    --{ -- Collection of various small independent plugins/modules
    --  "echasnovski/mini.nvim",
    --  config = function()
    --      -- Better Around/Inside textobjects
    --      --
    --      -- Examples:
    --      --  - va)  - [V]isually select [A]round [)]paren
    --      --  - yinq - [Y]ank [I]nside [N]ext [']quote
    --      --  - ci'  - [C]hange [I]nside [']quote
    --      require("mini.ai").setup({ n_lines = 500 })

    --      -- Add/delete/replace surroundings (brackets, quotes, etc.)
    --      --
    --      -- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
    --      -- - sd'   - [S]urround [D]elete [']quotes
    --      -- - sr)'  - [S]urround [R]eplace [)] [']
    --      require("mini.surround").setup()

    --      -- Simple and easy statusline.
    --      --  You could remove this setup call if you don't like it,
    --      --  and try some other statusline plugin
    --      local statusline = require("mini.statusline")
    --      -- set use_icons to true if you have a Nerd Font
    --      statusline.setup({ use_icons = vim.g.have_nerd_font })

    --      -- You can configure sections in the statusline by overriding their
    --      -- default behavior. For example, here we set the section for
    --      -- cursor location to LINE:COLUMN
    --      ---@diagnostic disable-next-line: duplicate-set-field
    --      statusline.section_location = function()
    --          return "%2l:%-2v"
    --      end

    --      -- ... and there is more!
    --      --  Check out: https://github.com/echasnovski/mini.nvim
    --  end,
    --},

    -- NOTE: Plugins can specify dependencies.
    --
    -- The dependencies are proper plugin specifications as well - anything
    -- you do for a plugin at the top level, you can do for a dependency.
    --
    -- Use the `dependencies` key to specify the dependencies of a particular plugin

    { -- Fuzzy Finder (files, lsp, etc)
        "nvim-telescope/telescope.nvim",
        event = "VimEnter",
        branch = "0.1.x",
        dependencies = {
            "nvim-lua/plenary.nvim",
            { -- If encountering errors, see telescope-fzf-native README for install instructions
                "nvim-telescope/telescope-fzf-native.nvim",

                -- `build` is used to run some command when the plugin is installed/updated.
                -- This is only run then, not every time Neovim starts up.
                build = "make",

                -- `cond` is a condition used to determine whether this plugin should be
                -- installed and loaded.
                cond = function()
                    return vim.fn.executable("make") == 1
                end,
            },
            { "nvim-telescope/telescope-ui-select.nvim" },

            -- Useful for getting pretty icons, but requires a Nerd Font.
            { "nvim-tree/nvim-web-devicons",            enabled = vim.g.have_nerd_font },
        },
        config = function()
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
                },
                signs = true,
            })

            -- { name = "DiagnosticSignError", text = " " },
            -- { name = "DiagnosticSignWarn",  text = " " },
            -- { name = "DiagnosticSignHint",  text = " " },
            -- { name = "DiagnosticSignInfo",  text = " " },

            vim.fn.sign_define(
                "DiagnosticSignError",
                { texthl = "DiagnosticSignError", text = "", numhl = "DiagnosticSignError" }
            )
            vim.fn.sign_define(
                "DiagnosticSignWarning",
                { texthl = "DiagnosticSignWarning", text = "", numhl = "DiagnosticSignWarning" }
            )
            vim.fn.sign_define(
                "DiagnosticSignHint",
                { texthl = "DiagnosticSignHint", text = "", numhl = "DiagnosticSignHint" }
            )
            vim.fn.sign_define(
                "DiagnosticSignInformation",
                { texthl = "DiagnosticSignInformation", text = "", numhl = "DiagnosticSignInformation" }
            )

            vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
                border = "rounded",
                width = 80,
            })

            vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
                border = "rounded",
                width = 80,
            })

            -- Telescope is a fuzzy finder that comes with a lot of different things that
            -- it can fuzzy find! It's more than just a "file finder", it can search
            -- many different aspects of Neovim, your workspace, LSP, and more!
            --
            -- The easiest way to use telescope, is to start by doing something like:
            --  :Telescope help_tags
            --
            -- After running this command, a window will open up and you're able to
            -- type in the prompt window. You'll see a list of help_tags options and
            -- a corresponding preview of the help.
            --
            -- Two important keymaps to use while in telescope are:
            --  - Insert mode: <c-/>
            --  - Normal mode: ?
            --
            -- This opens a window that shows you all of the keymaps for the current
            -- telescope picker. This is really useful to discover what Telescope can
            -- do as well as how to actually do it!

            -- [[ Configure Telescope ]]
            -- See `:help telescope` and `:help telescope.setup()`
            -- require("telescope").setup({
            --  -- You can put your default mappings / updates / etc. in here
            --  --  All the info you're looking for is in `:help telescope.setup()`
            --  --
            --  -- defaults = {
            --  --   mappings = {
            --  --     i = { ['<c-enter>'] = 'to_fuzzy_refine' },
            --  --   },
            --  -- },
            --  -- pickers = {}
            --  extensions = {
            --      ["ui-select"] = {
            --          require("telescope.themes").get_dropdown(),
            --      },
            --  },
            -- })
            --
            -- -- Enable telescope extensions, if they are installed
            -- pcall(require("telescope").load_extension, "fzf")
            -- pcall(require("telescope").load_extension, "ui-select")
            --
            -- -- See `:help telescope.builtin`
            -- local builtin = require("telescope.builtin")
            -- vim.keymap.set("n", "<leader>sh", builtin.help_tags, { desc = "[S]earch [H]elp" })
            -- vim.keymap.set("n", "<leader>sk", builtin.keymaps, { desc = "[S]earch [K]eymaps" })
            -- vim.keymap.set("n", "<leader>sf", builtin.find_files, { desc = "[S]earch [F]iles" })
            -- vim.keymap.set("n", "<leader>ss", builtin.builtin, { desc = "[S]earch [S]elect Telescope" })
            -- vim.keymap.set("n", "<leader>sw", builtin.grep_string, { desc = "[S]earch current [W]ord" })
            -- vim.keymap.set("n", "<leader>sg", builtin.live_grep, { desc = "[S]earch by [G]rep" })
            -- vim.keymap.set("n", "<leader>sd", builtin.diagnostics, { desc = "[S]earch [D]iagnostics" })
            -- vim.keymap.set("n", "<leader>sr", builtin.resume, { desc = "[S]earch [R]esume" })
            -- vim.keymap.set("n", "<leader>s.", builtin.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
            -- vim.keymap.set("n", "<leader><leader>", builtin.buffers, { desc = "[ ] Find existing buffers" })
            --
            -- -- Slightly advanced example of overriding default behavior and theme
            -- vim.keymap.set("n", "<leader>/", function()
            --  -- You can pass additional configuration to telescope to change theme, layout, etc.
            --  builtin.current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
            --      winblend = 10,
            --      previewer = false,
            --  }))
            -- end, { desc = "[/] Fuzzily search in current buffer" })
            --
            -- -- Also possible to pass additional configuration options.
            -- --  See `:help telescope.builtin.live_grep()` for information about particular keys
            -- vim.keymap.set("n", "<leader>s/", function()
            --  builtin.live_grep({
            --      grep_open_files = true,
            --      prompt_title = "Live Grep in Open Files",
            --  })
            -- end, { desc = "[S]earch [/] in Open Files" })
            --
            -- -- Shortcut for searching your neovim configuration files
            -- vim.keymap.set("n", "<leader>sn", function()
            --  builtin.find_files({ cwd = vim.fn.stdpath("config") })
            -- end, { desc = "[S]earch [N]eovim files" })

            vim.keymap.set("n", "gD", function()
                vim.lsp.buf.declaration()
            end)
            vim.keymap.set("n", "gd", function()
                vim.lsp.buf.definition()
            end)
            vim.keymap.set("n", "K", function()
                vim.lsp.buf.hover()
            end)
            vim.keymap.set("n", "gw", function()
                vim.lsp.buf.workspace_symbol()
            end)
            vim.keymap.set("n", "<M-g>", function()
                vim.diagnostic.open_float()
            end)
            vim.keymap.set("n", "<M-e>", function()
                vim.diagnostic.goto_next()
            end)
            vim.keymap.set("n", "<M-d>", function()
                vim.diagnostic.goto_prev()
            end)
            vim.keymap.set("n", "ga", function()
                vim.lsp.buf.code_action()
            end)
            vim.keymap.set("n", "gr", function()
                vim.lsp.buf.references()
            end)
            vim.keymap.set("n", "gR", function()
                vim.lsp.buf.rename()
            end)
            vim.keymap.set("i", "<C-j>", function()
                vim.lsp.buf.signature_help()
            end)
            vim.keymap.set("n", "<leader>q", function()
                vim.diagnostic.setloclist()
            end)
        end,
    },
    {
        "akinsho/bufferline.nvim",
        version = "*",
        dependencies = "nvim-tree/nvim-web-devicons",
    },
    { -- LSP Configuration & Plugins
        "neovim/nvim-lspconfig",
        dependencies = {
            -- Automatically install LSPs and related tools to stdpath for neovim
            "williamboman/mason.nvim",
            "williamboman/mason-lspconfig.nvim",
            "WhoIsSethDaniel/mason-tool-installer.nvim",

            -- Useful status updates for LSP.
            -- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
            { "j-hui/fidget.nvim", opts = {} },
        },
        config = function()
            -- Brief Aside: **What is LSP?**
            --
            -- LSP is an acronym you've probably heard, but might not understand what it is.
            --
            -- LSP stands for Language Server Protocol. It's a protocol that helps editors
            -- and language tooling communicate in a standardized fashion.
            --
            -- In general, you have a "server" which is some tool built to understand a particular
            -- language (such as `gopls`, `lua_ls`, `rust_analyzer`, etc). These Language Servers
            -- (sometimes called LSP servers, but that's kind of like ATM Machine) are standalone
            -- processes that communicate with some "client" - in this case, Neovim!
            --
            -- LSP provides Neovim with features like:
            --  - Go to definition
            --  - Find references
            --  - Autocompletion
            --  - Symbol Search
            --  - and more!
            --
            -- Thus, Language Servers are external tools that must be installed separately from
            -- Neovim. This is where `mason` and related plugins come into play.
            --
            -- If you're wondering about lsp vs treesitter, you can check out the wonderfully
            -- and elegantly composed help section, `:help lsp-vs-treesitter`

            --  This function gets run when an LSP attaches to a particular buffer.
            --    That is to say, every time a new file is opened that is associated with
            --    an lsp (for example, opening `main.rs` is associated with `rust_analyzer`) this
            --    function will be executed to configure the current buffer
            vim.api.nvim_create_autocmd("LspAttach", {
                group = vim.api.nvim_create_augroup("kickstart-lsp-attach", { clear = true }),
                callback = function(event)
                    -- NOTE: Remember that lua is a real programming language, and as such it is possible
                    -- to define small helper and utility functions so you don't have to repeat yourself
                    -- many times.
                    --
                    -- In this case, we create a function that lets us more easily define mappings specific
                    -- for LSP related items. It sets the mode, buffer and description for us each time.
                    local map = function(keys, func, desc)
                        vim.keymap.set("n", keys, func,
                            { buffer = event.buf, desc = "LSP: " .. desc })
                    end

                    -- Jump to the definition of the word under your cursor.
                    --  This is where a variable was first declared, or where a function is defined, etc.
                    --  To jump back, press <C-T>.
                    map("gd", require("telescope.builtin").lsp_definitions, "[G]oto [D]efinition")

                    -- Find references for the word under your cursor.
                    map("gr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")

                    -- Jump to the implementation of the word under your cursor.
                    --  Useful when your language has ways of declaring types without an actual implementation.
                    map("gI", require("telescope.builtin").lsp_implementations,
                        "[G]oto [I]mplementation")

                    -- Jump to the type of the word under your cursor.
                    --  Useful when you're not sure what type a variable is and you want to see
                    --  the definition of its *type*, not where it was *defined*.
                    map("<leader>D", require("telescope.builtin").lsp_type_definitions,
                        "Type [D]efinition")

                    -- Fuzzy find all the symbols in your current document.
                    --  Symbols are things like variables, functions, types, etc.
                    map("<leader>ds", require("telescope.builtin").lsp_document_symbols,
                        "[D]ocument [S]ymbols")

                    -- Fuzzy find all the symbols in your current workspace
                    --  Similar to document symbols, except searches over your whole project.
                    map(
                        "<leader>ws",
                        require("telescope.builtin").lsp_dynamic_workspace_symbols,
                        "[W]orkspace [S]ymbols"
                    )

                    -- Rename the variable under your cursor
                    --  Most Language Servers support renaming across files, etc.
                    map("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")

                    -- Execute a code action, usually your cursor needs to be on top of an error
                    -- or a suggestion from your LSP for this to activate.
                    map("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")

                    -- Opens a popup that displays documentation about the word under your cursor
                    --  See `:help K` for why this keymap
                    map("K", vim.lsp.buf.hover, "Hover Documentation")

                    -- WARN: This is not Goto Definition, this is Goto Declaration.
                    --  For example, in C this would take you to the header
                    map("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")

                    -- The following two autocommands are used to highlight references of the
                    -- word under your cursor when your cursor rests there for a little while.
                    --    See `:help CursorHold` for information about when this is executed
                    --
                    -- When you move your cursor, the highlights will be cleared (the second autocommand).
                    local client = vim.lsp.get_client_by_id(event.data.client_id)
                    if client and client.server_capabilities.documentHighlightProvider then
                        vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
                            buffer = event.buf,
                            callback = vim.lsp.buf.document_highlight,
                        })

                        vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
                            buffer = event.buf,
                            callback = vim.lsp.buf.clear_references,
                        })
                    end
                end,
            })

            -- LSP servers and clients are able to communicate to each other what features they support.
            --  By default, Neovim doesn't support everything that is in the LSP Specification.
            --  When you add nvim-cmp, luasnip, etc. Neovim now has *more* capabilities.
            --  So, we create new capabilities with nvim cmp, and then broadcast that to the servers.
            local capabilities = vim.lsp.protocol.make_client_capabilities()
            capabilities = vim.tbl_deep_extend("force", capabilities,
                require("cmp_nvim_lsp").default_capabilities())

            -- Enable the following language servers
            --  Feel free to add/remove any LSPs that you want here. They will automatically be installed.
            --
            --  Add any additional override configuration in the following tables. Available keys are:
            --  - cmd (table): Override the default command used to start the server
            --  - filetypes (table): Override the default list of associated filetypes for the server
            --  - capabilities (table): Override fields in capabilities. Can be used to disable certain LSP features.
            --  - settings (table): Override the default settings passed when initializing the server.
            --        For example, to see the options for `lua_ls`, you could go to: https://luals.github.io/wiki/settings/
            local servers = {
                clangd = {
                    cmd = {
                        "clangd",
                        "--all-scopes-completion",
                        --[[ "--suggest-missing-includes", ]] -- Obsolete
                        "--background-index",
                        "--pch-storage=disk",
                        --[[ "--cross-file-rename", ]] -- Obsolete
                        "--log=info",
                        "--completion-style=detailed",
                        "--enable-config",          -- clangd 11+ supports reading from .clangd configuration file
                        "--clang-tidy",
                        "--offset-encoding=utf-16", --temporary fix for null-ls
                        --[[ "--std=c++17", ]]
                        --[[ "--std=c89" ]]
                        -- "--clang-tidy-checks=-*,llvm-*,clang-analyzer-*,modernize-*,-modernize-use-trailing-return-type",
                        -- "--fallback-style=Google",
                        -- "--header-insertion=never",
                        -- "--query-driver=<list-of-white-listed-complers>"
                    }
                },
                -- Vue lsp
                vue_ls = {
                    cmd = { "vls" },
                    filetypes = { "vue" },
                },
                -- Latex lsp
                texlab = {
                    cmd = { "texlab" },
                    filetypes = { "tex", "bib", "plaintex" },
                },
                -- gopls = {},
                pyright = {
                    analysis = {
                        extraPaths = { '/home/patu/dev/simple_wyvern/Tools/DependencySetup/venv/include' },
                    },
                    format = {
                        enable = false
                    }
                },
                -- Javascript lsp


                -- rust_analyzer = {},
                -- ... etc. See `:help lspconfig-all` for a list of all the pre-configured LSPs
                --
                -- Some languages (like typescript) have entire language plugins that can be useful:
                --    https://github.com/pmizio/typescript-tools.nvim
                --
                -- But for many setups, the LSP (`tsserver`) will work just fine
                tsserver = {
                    cmd = {
                        "typescript-language-server",
                        "--stdio",
                    },
                    filetypes = { "javascript", "javascriptreact", "javascript.jsx", "typescript", "typescriptreact",
                        "typescript.tsx" },
                    capabilities = {
                        textDocument = {
                            completion = {
                                completionItem = {
                                    -- This is a workaround for the fact that tsserver doesn't support
                                    -- the `insertTextMode` capability. This is a workaround for the fact
                                    -- that tsserver doesn't support the `insertTextMode` capability.
                                    --  See
                                },
                            }
                        }
                    }
                },

                lua_ls = {
                    -- cmd = {...},
                    -- filetypes { ...},
                    -- capabilities = {},
                    settings = {
                        Lua = {
                            runtime = { version = "LuaJIT" },
                            workspace = {
                                checkThirdParty = false,
                                -- Tells lua_ls where to find all the Lua files that you have loaded
                                -- for your neovim configuration.
                                library = {
                                    "${3rd}/luv/library",
                                    unpack(vim.api.nvim_get_runtime_file("", true)),

                                    [vim.fn.expand("$VIMRUNTIME/lua")] = true,
                                    [vim.fn.stdpath("config") .. "/lua"] = true,
                                },
                                -- If lua_ls is really slow on your computer, you can try this instead:
                                -- library = { vim.env.VIMRUNTIME },
                            },
                            completion = {
                                callSnippet = "Replace",
                            },
                            -- You can toggle below to ignore Lua_LS's noisy `missing-fields` warnings
                            -- diagnostics = { disable = { 'missing-fields' } },
                            diagnostics = {
                                globals = { 'vim' }
                            },
                        },
                    },
                },
            }

            -- Ensure the servers and tools above are installed
            --  To check the current status of installed tools and/or manually install
            --  other tools, you can run
            --    :Mason
            --
            --  You can press `g?` for help in this menu
            require("mason").setup()

            -- You can add other tools here that you want Mason to install
            -- for you, so that they are available from within Neovim.
            local ensure_installed = vim.tbl_keys(servers or {})
            vim.list_extend(ensure_installed, {
                "stylua", -- Used to format lua code
            })
            require("mason-tool-installer").setup({ ensure_installed = ensure_installed })

            require("mason-lspconfig").setup({
                handlers = {
                    function(server_name)
                        local server = servers[server_name] or {}
                        -- This handles overriding only values explicitly passed
                        -- by the server configuration above. Useful when disabling
                        -- certain features of an LSP (for example, turning off formatting for tsserver)
                        server.capabilities = vim.tbl_deep_extend("force", {}, capabilities,
                            server.capabilities or {})
                        require("lspconfig")[server_name].setup(server)
                    end,
                },
            })
        end,
    },

    { -- Autoformat
        "stevearc/conform.nvim",
        opts = {
            notify_on_error = false,
            --format_on_save = {
            --  timeout_ms = 500,
            --  lsp_fallback = true,
            --},
            formatters_by_ft = {
                lua = { "stylua" },
                cpp = { "clang-format" },
                -- Conform can also run multiple formatters sequentially
                -- python = { "isort", "black" },
                --
                -- You can use a sub-list to tell conform to run *until* a formatter
                -- is found.
                -- javascript = { { "prettierd", "prettier" } },
            },
        },
    },

    {
        "hrsh7th/cmp-nvim-lsp-signature-help",
    },

    { -- Autocompletion
        "hrsh7th/nvim-cmp",
        event = "InsertEnter",
        dependencies = {
            -- Snippet Engine & its associated nvim-cmp source
            {
                "L3MON4D3/LuaSnip",
                build = (function()
                    -- Build Step is needed for regex support in snippets
                    -- This step is not supported in many windows environments
                    -- Remove the below condition to re-enable on windows
                    if vim.fn.has("win32") == 1 or vim.fn.executable("make") == 0 then
                        return
                    end
                    return "make install_jsregexp"
                end)(),
            },
            "saadparwaiz1/cmp_luasnip",

            -- Adds other completion capabilities.
            --  nvim-cmp does not ship with all sources by default. They are split
            --  into multiple repos for maintenance purposes.
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-path",

            -- If you want to add a bunch of pre-configured snippets,
            --    you can use this plugin to help you. It even has snippets
            --    for various frameworks/libraries/etc. but you will have to
            --    set up the ones that are useful for you.
            -- 'rafamadriz/friendly-snippets',
        },
        config = function()
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
            local check_backspace = function()
                local col = vim.fn.col "." - 1
                return col == 0 or vim.fn.getline("."):sub(col, col):match "%s"
            end

            -- See `:help cmp`
            local cmp = require("cmp")
            local cmp_select = { behavior = cmp.SelectBehavior.Select }
            local luasnip = require("luasnip")
            luasnip.config.setup({})

            cmp.setup({
                snippet = {
                    expand = function(args)
                        luasnip.lsp_expand(args.body)
                    end,
                },
                window = {
                    completion = cmp.config.window.bordered(),
                    documentation = {
                        border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
                        max_width = 50,
                        max_height = 50
                    }
                },
                completion = { completeopt = "menu,menuone,noinsert" },

                -- For an understanding of why these mappings were
                -- chosen, you will need to read `:help ins-completion`
                --
                -- No, but seriously. Please read `:help ins-completion`, it is really good!
                mapping = cmp.mapping.preset.insert({
                    ["<C-k>"] = cmp.mapping.select_prev_item(cmp_select),
                    ["<C-j>"] = cmp.mapping.select_next_item(cmp_select),
                    ["<C-l>"] = cmp.mapping.confirm({ select = true }),
                    ["<C-Space>"] = cmp.mapping.complete(),
                    ["<C-y>"] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
                    ["<C-e>"] = cmp.mapping({
                        i = cmp.mapping.abort(),
                        c = cmp.mapping.close(),
                    }),
                    -- Accept currently selected item. If none selected, `select` first item.
                    -- Set `select` to `false` to only confirm explicitly selected items.
                    ["<CR>"] = cmp.mapping.confirm { select = false },
                    -- ["<Tab>"] = cmp.mapping(function(fallback)
                    --     if cmp.visible() then
                    --         cmp.select_next_item()
                    --     elseif luasnip.expandable() then
                    --         luasnip.expand()
                    --     elseif luasnip.expand_or_jumpable() then
                    --         luasnip.expand_or_jump()
                    --     elseif check_backspace() then
                    --         fallback()
                    --     else
                    --         fallback()
                    --     end
                    -- end, {
                    --     "i",
                    --     "s",
                    -- }),
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
                }),
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
                    { name = "nvim_lsp_signature_help" },
                    { name = "luasnip" },
                    { name = "buffer" },
                    { name = "path" },
                },
            })
        end,
    },
    {
        'lervag/vimtex'
    },
    --{ -- You can easily change to a different colorscheme.
    --  -- Change the name of the colorscheme plugin below, and then
    --  -- change the command in the config to whatever the name of that colorscheme is
    --  --
    --  -- If you want to see what colorschemes are already installed, you can use `:Telescope colorscheme`
    --  "folke/tokyonight.nvim",
    --  lazy = false, -- make sure we load this during startup if it is your main colorscheme
    --  priority = 1000, -- make sure to load this before all the other start plugins
    --  config = function()
    --      -- Load the colorscheme here.
    --      -- Like many other themes, this one has different styles, and you could load
    --      -- any other, such as 'tokyonight-storm', 'tokyonight-moon', or 'tokyonight-day'.
    --      vim.cmd.colorscheme("tokyonight-night")

    --      -- You can configure highlights by doing something like
    --      vim.cmd.hi("Comment gui=none")
    --  end,
    --},

    -- Highlight todo, notes, etc in comments
    {
        "folke/todo-comments.nvim",
        event = "VimEnter",
        dependencies = { "nvim-lua/plenary.nvim" },
        opts = { signs = false },
    },

    { -- Highlight, edit, and navigate code
        "nvim-treesitter/nvim-treesitter",
        -- build = ":TSUpdate",
        config = function()
            -- [[ Configure Treesitter ]] See `:help nvim-treesitter`
            -- parser_install_dir = "$HOME/.local/share/nvim/lazy/nvim-treesitter/parser",

            ---@diagnostic disable-next-line: missing-fields
            require("nvim-treesitter.configs").setup({
                ensure_installed = { "bash", "c", "html", "lua", "markdown", "vim", "vimdoc" },
                -- Autoinstall languages that are not installed
                auto_install = true,
                highlight = { enable = true },
                indent = { enable = true },
            })

            -- There are additional nvim-treesitter modules that you can use to interact
            -- with nvim-treesitter. You should go explore a few and see what interests you:
            --
            --    - Incremental selection: Included, see `:help nvim-treesitter-incremental-selection-mod`
            --    - Show your current context: https://github.com/nvim-treesitter/nvim-treesitter-context
            --    - Treesitter + textobjects: https://github.com/nvim-treesitter/nvim-treesitter-textobjects
        end,
    },
    {
        "nvim-tree/nvim-tree.lua",
        commit = "08a0aa1a3b7411ee0a7887c8818528b1558cef96",
        config = function() end,
    },

    -- The following two comments only work if you have downloaded the kickstart repo, not just copy pasted the
    -- init.lua. If you want these files, they are in the repository, so you can just download them and
    -- put them in the right spots if you want.

    -- NOTE: Next step on your Neovim journey: Add/Configure additional plugins for kickstart
    --
    --  Here are some example plugins that I've included in the kickstart repository.
    --  Uncomment any of the lines below to enable them (you will need to restart nvim).
    --
    -- require 'kickstart.plugins.debug',
    -- require 'kickstart.plugins.indent_line',

    -- NOTE: The import below can automatically add your own plugins, configuration, etc from `lua/custom/plugins/*.lua`
    --    This is the easiest way to modularize your config.
    --
    --  Uncomment the following line and add your plugins to `lua/custom/plugins/*.lua` to get going.
    --    For additional information, see `:help lazy.nvim-lazy.nvim-structuring-your-plugins`
    -- { import = 'custom.plugins' },
}, {
    ui = {
        -- If you have a Nerd Font, set icons to an empty table which will use the
        -- default lazy.nvim defined Nerd Font icons otherwise define a unicode icons table
        icons = vim.g.have_nerd_font and {} or {
            cmd = "⌘",
            config = "🛠",
            event = "📅",
            ft = "📂",
            init = "⚙",
            keys = "🗝",
            plugin = "🔌",
            runtime = "💻",
            require = "🌙",
            source = "📄",
            start = "🚀",
            task = "📌",
            lazy = "💤 ",
        },
    },
})

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et

----------------------------------- PACKER ------------------------------------------
---- Automatically install packer
--local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
--if fn.empty(fn.glob(install_path)) > 0 then
--    PACKER_BOOTSTRAP = fn.system({
--        "git",
--        "clone",
--        "--depth",
--        "1",
--        "https://github.com/wbthomason/packer.nvim",
--        install_path,
--    })
--    print("Installing packer close and reopen Neovim...")
--    vim.cmd([[packadd packer.nvim]])
--end

---- Autocommand that reloads neovim whenever you save the plugins.lua file
--vim.cmd([[
--  augroup packer_user_config
--    autocmd!
--    autocmd BufWritePost plugins.lua source <afile> | PackerSync
--  augroup end
--]])
--
---- Use a protected call so we don't error out on first use
--local status_ok, packer = pcall(require, "packer")
--if not status_ok then
--    return
--end
--
---- Have packer use a popup window
--packer.init({
--    display = {
--        open_fn = function()
--            return require("packer.util").float({ border = "rounded" })
--        end,
--    },
--})
--
---- Install your plugins here
--return packer.startup(function(use)
--    -- My plugins here
--    --use({"ViliLipo/Oiko"})
--    use({ "wbthomason/packer.nvim", commit = "1d0cf98a561f7fd654c970c49f917d74fafe1530" }) -- Have packer manage itself
--    use({ "nvim-lua/plenary.nvim", commit = "9a0d3bf7b832818c042aaf30f692b081ddd58bd9" })  -- Useful lua functions used by lots of plugins
--    use("windwp/nvim-autopairs")                                                           -- Autopairs, integrates with both cmp and treesitter
--    use({ "numToStr/Comment.nvim", commit = "6821b3ae27a57f1f3cf8ed030e4a55d70d0c4e43" })
--    use({ "JoosepAlviste/nvim-ts-context-commentstring", commit = "88343753dbe81c227a1c1fd2c8d764afb8d36269" })
--    use({ "kyazdani42/nvim-web-devicons", commit = "8d2c5337f0a2d0a17de8e751876eeb192b32310e" })
--    -- use({ "kyazdani42/nvim-tree.lua", commit = "bdb6d4a25410da35bbf7ce0dbdaa8d60432bc243" })
--    use({ "nvim-tree/nvim-tree.lua", commit = "08a0aa1a3b7411ee0a7887c8818528b1558cef96" })
--    use { "akinsho/bufferline.nvim" }
--    use({ "moll/vim-bbye", commit = "25ef93ac5a87526111f43e5110675032dbcacf56" })
--    use({ "nvim-lualine/lualine.nvim", commit = "3362b28f917acc37538b1047f187ff1b5645ecdd" })
--    use({ "akinsho/toggleterm.nvim", commit = "aaeed9e02167c5e8f00f25156895a6fd95403af8" })
--    use({ "ahmedkhalf/project.nvim", commit = "541115e762764bc44d7d3bf501b6e367842d3d4f" })
--    use({ "lewis6991/impatient.nvim", commit = "969f2c5c90457612c09cf2a13fee1adaa986d350" })
--    use({ "lukas-reineke/indent-blankline.nvim", commit = "6177a59552e35dfb69e1493fd68194e673dc3ee2" })
--    use({ "goolord/alpha-nvim", commit = "ef27a59e5b4d7b1c2fe1950da3fe5b1c5f3b4c94" })
--    use("folke/which-key.nvim")
--    use("nvim-telescope/telescope.nvim")
--    -- use("puremourning/vimspector")
--
--    -- Colorschemes
--    use({ "folke/tokyonight.nvim", commit = "8223c970677e4d88c9b6b6d81bda23daf11062bb" })
--    use("lunarvim/darkplus.nvim")
--    use("Mofiqul/dracula.nvim")
--    use "EdenEast/nightfox.nvim"
--    use("joshdick/onedark.vim")
--    use("vimcolorschemes/vimcolorschemes")
--    use("sainnhe/gruvbox-material")
--    -- git@github.com:vimcolorschemes/vimcolorschemes.git
--
--    -- Todo comments
--    use {
--        "folke/todo-comments.nvim",
--        dependencies = { "nvim-lua/plenary.nvim" },
--        opts = {
--            -- your configuration comes here
--            -- or leave it empty to use the default settings
--            -- refer to the configuration section below
--        }
--    }
--    -- GO implementation generator
--    use {
--        'edolphin-ydf/goimpl.nvim',
--        requires = {
--            { 'nvim-lua/plenary.nvim' },
--            { 'nvim-lua/popup.nvim' },
--            { 'nvim-telescope/telescope.nvim' },
--            { 'nvim-treesitter/nvim-treesitter' },
--        },
--        config = function()
--            require 'telescope'.load_extension 'goimpl'
--        end,
--    }
--    -- Cpp tools
--    use {
--        requires = { "nvim-treesitter/nvim-treesitter" },
--        "Badhi/nvim-treesitter-cpp-tools",
--    }
--    -- GitHub Copilot
--    use("github/copilot.vim")
--    -- LSP
--    use {
--        'VonHeikemen/lsp-zero.nvim',
--        requires = {
--            -- LSP support
--            { 'neovim/nvim-lspconfig' },
--            {
--                'williamboman/mason.nvim',
--                opts = {
--                    ensure_installed = "pyright",
--                }
--
--            },
--            { 'williamboman/mason-lspconfig.nvim' },
--
--            -- Autocompletion
--            { "hrsh7th/nvim-cmp" },         -- The completion plugin
--            { "hrsh7th/cmp-buffer" },       -- buffer completions
--            { "hrsh7th/cmp-path" },         -- path completions
--            { "saadparwaiz1/cmp_luasnip" }, -- snippet completions
--            { "hrsh7th/cmp-nvim-lsp" },
--            { "hrsh7th/cmp-nvim-lua" },
--
--            -- Snippets
--            { 'L3MON4D3/LuaSnip' },
--            { 'rafamadriz/friendly-snippets' },
--            --[[ { "SirVer/ultisnips" }, ]]
--            --[[ { "quangnguyen30192/cmp-nvim-ultisnips" }, ]]
--        }
--    }
--    -- Auto sessions / autosessions
--    use {
--        'rmagatti/auto-session',
--        config = function()
--            require("auto-session").setup {
--                log_level = "error",
--                auto_session_suppress_dirs = { "~/", "~/Projects", "~/Downloads", "/" },
--            }
--        end
--    }
--    -- Inline hints
--    use('simrat39/inlay-hints.nvim')
--
--    use('lervag/vimtex')
--    --[[ use('') ]]
--    use('mbbill/undotree')
--    use('kdheepak/lazygit.nvim')
--    use('preservim/tagbar')
--
--    use { 'timtro/glslView-nvim', ft = 'glsl' }
--    use('jrop/jq.nvim')
--    -- DAP
--    use("mfussenegger/nvim-dap")
--    use("mfussenegger/nvim-dap-python")
--    use("leoluz/nvim-dap-go")
--    use("rcarriga/nvim-dap-ui")
--    use("theHamsta/nvim-dap-virtual-text")
--    use("mxsdev/nvim-dap-vscode-js")
--    use { "microsoft/vscode-js-debug",
--        opt = true, run = "npm install --legacy-peer-deps && npx gulp vsDebugServerBundle && mv dist out"
--    }
--
--    use {
--        'fei6409/log-highlight.nvim',
--        config = function()
--            require('log-highlight').setup {
--                -- The following options support either a string or a table of strings.
--
--                -- The file extensions.
--                extension = 'log',
--
--                -- The file names or the full file paths.
--                filename = {
--                    'messages',
--                },
--
--                -- The file path glob patterns, e.g. `.*%.lg`, `/var/log/.*`.
--                -- Note: `%.` is to match a literal dot (`.`) in a pattern in Lua, but most
--                -- of the time `.` and `%.` here make no observable difference.
--                pattern = {
--                    '/var/log/.*',
--                    'messages%..*',
--                },
--            }
--        end,
--    }
--
--    use("nvim-telescope/telescope-dap.nvim")
--
--    -- Jump files
--    use("ThePrimeagen/harpoon")
--
--    -- Git
--    use("lewis6991/gitsigns.nvim")
--    --[[ use("jose-elias-alvarez/null-ls.nvim") -- for formatters and linters ]]
--    use("nvim-treesitter/nvim-treesitter")
--end)

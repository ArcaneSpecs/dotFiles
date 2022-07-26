local status_ok, dap = pcall(require, "dap")
if not status_ok then
    print("nvim-dap not loaded!!")
    return
end

require("nvim-dap-virtual-text").setup()

dap.adapters.python = {
    type = 'executable',
    command = os.getenv('HOME') .. '/.virtualenvs/tools/bin/python',
    args = { '-m', 'debugpy.adapter' }
}


dap.configurations.python = {
    {
        type = 'python';
        request = 'launch';
        name = "Launch file";
        program = "${file}";
        pythonPath = function()
            return '/usr/bin/python'
        end;
    },
}

-- /usr/lib/python3.10/site-packages/debugpy/adapter

dap.adapters.lldb = {
    type = 'executable',
    command = '/usr/bin/lldb-vscode', -- adjust as needed, must be absolute path
    name = 'lldb'
}

dap.configurations.cpp = {
    {
        name = 'Launch',
        type = 'lldb',
        request = 'launch',
        program = function()
            return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
        end,
        cwd = '${workspaceFolder}',
        stopOnEntry = false,
        args = {},

        -- 💀
        -- if you change `runInTerminal` to true, you might need to change the yama/ptrace_scope setting:
        --
        --    echo 0 | sudo tee /proc/sys/kernel/yama/ptrace_scope
        --
        -- Otherwise you might get the following error:
        --
        --    Error on launch: Failed to attach to the target process
        --
        -- But you should be aware of the implications:
        -- https://www.kernel.org/doc/html/latest/admin-guide/LSM/Yama.html
        -- runInTerminal = false,
    },
}

-- print("aaaaaaaaaaaaaaaaaaa from nvim dap!")


local status_ok, dapui = pcall(require, "dapui")
if not status_ok then
    print("dapui not loaded!!")
    return
end


-- Automaticly open and close dapui when starting and stopping to debug
dap.listeners.before.event_terminated["dapui_config"] = function()
    dapui.close()
end

dap.listeners.after.event_initialized["dapui_config"] = function()
    dapui.open()
end

dap.listeners.before.event_exited["dapui_config"] = function()
    dapui.close()
end


dapui.setup {
    icons = {
        expanded = "►",
        collapsed = "▼",
        circular = "⭕"

        -- expanded = "➖",
        -- collapsed = "➕",
        -- circular = "⭕"
    },
    mappings = {
        expand = "<CR>",
        open = "o",
        remove = "d"
    },
    layouts = {
        {
            elements = {
                'scopes',
                'breakpoints',
                'stacks',
                -- 'watches',
            },
            size = 40,
            position = 'left',
        },
        {
            elements = {
                'repl',
                'console',
            },
            size = 10,
            position = 'bottom',
        },
        {
            elements = {
                'watches'
            },
            size = 20,
            position = 'right'
        }
    }

}

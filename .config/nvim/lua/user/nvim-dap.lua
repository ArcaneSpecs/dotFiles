local status_ok, dap = pcall(require, "dap")
if not status_ok then
    print("nvim-dap not loaded!!")
    return
end

require("nvim-dap-virtual-text").setup()

--[
--dap.adapters.python = {
    --type = 'executable',
    --command = os.getenv('HOME') .. '/.virtualenvs/tools/bin/python',
    --args = { '-m', 'debugpy.adapter' }
--}

--dap.configurations.python = {
    --{
        --type = 'python';
        --request = 'launch';
        --name = "Launch file";
        --program = "${file}";
        --pythonPath = function()
            --return '/usr/bin/python'
        --end;
    --},
--}

-- /usr/lib/python3.10/site-packages/debugpy/adapter

-- Check what platform we are on
-- print(vim.loop.os_uname().sysname)
local operating_system = vim.loop.os_uname().sysname
local lldb_path = '/usr/bin/lldb-vscode'

if (operating_system == "Windows_NT") then
    -- print("Windows!")
    -- lldb_path = 'C:/devel/DevelopmentEnvironments/LLVM/bin/lldb.exe'
    lldb_path = 'C:/devel/DevelopmentEnvironments/LLVM/bin/lldb-vscode.exe'
    -- lldb_path = 'C:/Users/patu/.vscode/extensions/vadimcn.vscode-lldb-1.8.1/lldb/bin/lldb.exe'
end

dap.adapters.cppdbg = {
    id = 'cppvsdbg',
    type = 'executable',
    command = 'C:/Users/patu/.vscode/extensions/ms-vscode.cpptools-1.14.3-win32-x64/debugAdapters/bin/OpenDebugAD7.exe',
    options = {
        detached = false
    }
}

dap.adapters.lldb = {
    type = 'executable',
    command = lldb_path, -- adjust as needed, must be absolute path
    name = 'lldb'
}

--[[ local cmd = os.getenv("HOME") .. "/.config/nvim/data/debug/tools/extension/adapter/codelldb" ]]
local cmd = "C:/Users/patu/AppData/Local/nvim-data/mason/packages/codelldb/extension/adapter/codelldb.exe"
dap.adapters.codelldb = function(on_adapter)
    -- This asks the system for a free port
    local tcp = vim.loop.new_tcp()
    tcp:bind("127.0.0.1", 0)
    local port = tcp:getsockname().port
    tcp:shutdown()
    tcp:close()

    -- Start codelldb with the port
    local stdout = vim.loop.new_pipe(false)
    local stderr = vim.loop.new_pipe(false)
    local opts = {
        stdio = {nil, stdout, stderr},
        args = {"--port", tostring(port)}
    }
    local handle
    local pid_or_err
    handle, pid_or_err =
        vim.loop.spawn(
        cmd,
        opts,
        function(code)
            stdout:close()
            stderr:close()
            handle:close()
            if code ~= 0 then
                print("codelldb exited with code", code)
            end
        end
    )
    if not handle then
        vim.notify("Error running codelldb: " .. tostring(pid_or_err), vim.log.levels.ERROR)
        stdout:close()
        stderr:close()
        return
    end
    vim.notify("codelldb started. pid=" .. pid_or_err)
    stderr:read_start(
        function(err, chunk)
            assert(not err, err)
            if chunk then
                vim.schedule(
                    function()
                        require("dap.repl").append(chunk)
                    end
                )
            end
        end
    )
    local adapter = {
        type = "server",
        host = "127.0.0.1",
        port = port
    }
    -- 💀
    -- Wait for codelldb to get ready and start listening before telling nvim-dap to connect
    -- If you get connect errors, try to increase 500 to a higher value, or check the stderr (Open the REPL)
    vim.defer_fn(
        function()
            on_adapter(adapter)
        end,
        500
    )
end

dap.configurations.cpp = {
    {
        name = 'Launch',
        type = 'codelldb',
        -- type = 'cppdbg',
        request = 'launch',
        program = function()
            return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/build/bin/Debug-windows-x86_64/WyvernEditor/WyvernEditor.exe', 'file')
        end,
        -- cwd = '${workspaceFolder}',
        cwd = '${workspaceFolder}/build/bin/Debug-windows-x86_64/WyvernEditor',
        stopOnEntry = true,
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

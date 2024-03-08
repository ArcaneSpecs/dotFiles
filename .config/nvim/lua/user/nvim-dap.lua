local status_ok, dap = pcall(require, "dap")
if not status_ok then
    print("nvim-dap not loaded!!")
    return
end

local operating_system = vim.loop.os_uname().sysname

vim.fn.sign_define('DapBreakpoint', {
    text = '',
    texthl = 'DapBreakpoint',
    linehl = 'DapBreakpoint',
    numhl = 'DapBreakpoint'
})

vim.fn.sign_define('DapBreakpointCondition',
    { text = 'ﳁ', texthl = 'DapBreakpoint', linehl = 'DapBreakpoint', numhl = 'DapBreakpoint' })
vim.fn.sign_define('DapBreakpointRejected',
    { text = '', texthl = 'DapBreakpoint', linehl = 'DapBreakpoint', numhl = 'DapBreakpoint' })
vim.fn.sign_define('DapLogPoint', { text = '', texthl = 'DapLogPoint', linehl = 'DapLogPoint', numhl = 'DapLogPoint' })
vim.fn.sign_define('DapStopped', { text = '', texthl = 'DapStopped', linehl = 'DapStopped', numhl = 'DapStopped' })

vim.api.nvim_set_hl(0, 'DapBreakpoint', { ctermbg = 0, fg = '#993939', bg = '#31353f' })
vim.api.nvim_set_hl(0, 'DapLogPoint', { ctermbg = 0, fg = '#61afef', bg = '#31353f' })
vim.api.nvim_set_hl(0, 'DapStopped', { ctermbg = 0, fg = '#98c379', bg = '#31353f' })

require("nvim-dap-virtual-text").setup()

local python_command = os.getenv('HOME') .. '/.virtualenvs/debugpy/bin/python'

--[[ local python_command = "source /home/patu/dev/simple_wyvern/Tools/DependencySetup/venv/bin/activate && /home/patu/dev/simple_wyvern/Tools/DependencySetup/venv/bin/python" ]]

dap.defaults.fallback.external_terminal = {
    command = '/usr/bin/alacritty';
    args = {'-e'};
}

dap.defaults.fallback.terminal_win_cmd = 'tabnew'
dap.defaults.fallback.force_external_terminal = true

if (operating_system == "Linux") then
    require('dap-python').setup('~/.virtualenvs/debugpy/bin/python')


elseif (operating_system == "Windows_NT") then
    --[[ python_command = os.getenv('HOME') .. '/.virtualenvs/tools/bin/python' ]]
    python_command = "" -- TODO: debugpy on windows
end


dap.adapters.python = {
    type = 'executable',
    command = python_command,
    venv = os.getenv('HOME') .. '/simple_wyvern/Tools/DependencySetup/venv/bin/activate',
    args = { '-m', 'debugpy.adapter' }
}

dap.configurations.python = {
    {
        type = 'python',
        request = 'launch',
        name = "Launch file",
        program = "${file}",
        pythonPath = function()
            --[[ return '/usr/bin/python' ]]
            return os.getenv('HOME') .. '/.virtualenvs/debugpy/bin/python'
            --[[ return "/home/patu/dev/simple_wyvern/Tools/DependencySetup/venv/bin/python" ]]
            --[[ return "/home/patu/github/webui_stable_diffusion/venv/bin/python" ]]
        end,
    },
}

-- /usr/lib/python3.10/site-packages/debugpy/adapter

-- Check what platform we are on
-- print(vim.loop.os_uname().sysname)
local lldb_path = '/usr/bin/lldb-vscode'
--[[ local lldb_path = '/usr/bin/lldb' ]]

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

local cmd = ""

if (operating_system == "Linux") then
    cmd = os.getenv("HOME") .. "/.config/nvim/data/debug/tools/extension/adapter/codelldb"
    -- print("Linux!")
elseif (operating_system == "Windows_NT") then
    --[[ local cmd = "/home/patu/.local/share/nvim/mason/bin/codelldb" ]]
    --[[ local cmd = "/usr/bin/lldb" ]]
    cmd = "C:/Users/patu/AppData/Local/nvim-data/mason/packages/codelldb/extension/adapter/codelldb.exe"
end

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
        stdio = { nil, stdout, stderr },
        args = { "--port", tostring(port) }
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
        2000
    )
end

--[[ local tempcwd = '${workspaceFolder}' ]]
--[[ local tempcwd = '${workspaceFolder}/build' ]]

--[[ local tempcwd = '${workspaceFolder}/build/bin/Debug-linux-x86_64/WyvernEditor' ]]
--[[ local tempcwd = '${workspaceFolder}/Projects/DEMO' ]]
--[[ local tempcwd = '${workspaceFolder}/build/bin/Debug-linux-x86_64/VulkanDEMO' ]]
--[[ local tempcwd = '/home/patu/Documents/Wyvern Projects/RPG' ]]
--[[ local tempcwd = '/home/patu/Documents/Wyvern_Projects/RPG' ]]
local tempcwd = '/home/patu/github/Lumos/Lumos/bin/Debug-linux-x86_64/'
--[[ local tempcwd = '/home/patu/github/vulkan-base/' ]]
--[[ local tempcwd = '/home/patu/dev/simple_wyvern/Tools/WyvernHeaderGenerator/External/llvm' ]]
--[[ local tempcwd = '/home/patu/dev/simple_wyvern/Tools/WyvernHeaderGenerator/External/llvm/clang-tools-extra/metareflect' ]]
--[[ local tempcwd = "/home/patu/dev/simple_wyvern/Projects/DEMO/PackagedGame/DEMO/Binaries/Debug-linux-x86_64" ]]
--[[ local tempcwd = '${workspaceFolder}/' ]]
--[[ local tempcwd = '/home/patu/dev/TIEP114/demot/Nand2Tetris/projects/04/oma' ]]
--[[ local tempcwd = '${workspaceFolder}/Demot/Nand2Tetris/projects/04/oma' ]]
--[[ local tempcwd = '${workspaceFolder}/Projects/DEMO/PackagedGame/DEMO/Binaries/Debug-linux-x86_64/' ]]
--[[ local tempcwd = '${workspaceFolder}/build' ]]
--[[ local tempcwd = '${workspaceFolder}/build/bin/Release-linux-x86_64/WyvernEditor' ]]
--[[ local tempcwd = '${workspaceFolder}/build/bin/' ]]
--[[ local tempcwd = '${workspaceFolder}/build/bin/Debug-linux-x86_64/VulkanDEMO' ]]
--[[ local tempcwd = '${workspaceFolder}/build/bin/Debug-linux-x86_64/StopWatch' ]]
--[[ local tempcwd = '${workspaceFolder}/../build-linux/bin/' ]]
--[[ local tempcwd = '${workspaceFolder}/build' ]]

if (operating_system == "Windows_NT") then
    tempcwd = '${workspaceFolder}/build/bin/Debug-windows-x86_64/WyvernEditor'
end

local lastUsedFile = nil -- Define a variable to store the last used file

-- Our custom lldb launch
dap.configurations.cpp = {
    {
        name = 'Launch lldb',
        type = 'lldb',
        -- type = 'cppdbg',
        request = 'launch',
        program = function()
            --[[ local defaultPath = vim.fn.getcwd() .. '/build/bin/Debug-linux-x86_64/' ]]
            --[[ local defaultPath = vim.fn.getcwd() .. '/build/bin/Release-linux-x86_64/' ]]
            local defaultPath = vim.fn.getcwd() .. '/build/bin/'

            if (operating_system == "Windows_NT") then
                defaultPath = vim.fn.getcwd() .. '/build/bin/Debug-windows-x86_64/WyvernEditor/'
            end

            local path = defaultPath

            if lastUsedFile ~= nil then
                path = lastUsedFile
            end

            local inputPath = vim.fn.input('Path to executable: ', path, 'file')

            -- Check if inputPath is not empty and store it as the last used file
            if inputPath ~= '' then
                lastUsedFile = inputPath
            end


            return inputPath
            --[[
            if (operating_system == "Windows_NT") then
                return vim.fn.input('Path to executable: ',
                    vim.fn.getcwd() .. '/build/bin/Debug-windows-x86_64/WyvernEditor/WyvernEditor.exe', 'file')
            else
                return vim.fn.input('Path to executable: ',
                    vim.fn.getcwd() .. '/build/bin/Debug-linux-x86_64/WyvernEditor/WyvernEditor', 'file')

                    -- Get path to current working directory and the executable name

                    vim.fn.getcwd() .. '/build/bin/Debug-linux-x86_64/', 'file')


                    vim.fn.getcwd() .. '/build/bin/Debug-linux-x86_64/VulkanDEMO/VulkanDEMO', 'file')
                    vim.fn.getcwd() .. '/build/bin/Debug-linux-x86_64/StopWatch/StopWatch', 'file')
                    vim.fn.getcwd() .. '../build-linux/bin/blender', 'file')
                vim.fn.getcwd() .. '/build/Vulkan', 'file')
            end
            ]]
            --
        end,

        --[[ cwd = function() ]]
        --[[     print(vim.fn.getcwd()) ]]
        --[[     return vim.fn.getcwd() ]]
        --[[ end, ]]

        cwd = tempcwd,
        console = "externalTerminal",
        --[[ internalConsoleOptions = "neverOpen", ]]
        stopOnEntry = false,
        args = {
            --[[ "/home/patu/dev/simple_wyvern/Projects/DEMO/PackagedGame/DEMO/Binaries/Debug-linux-x86_64", ]]
            --[[ "/home/patu/dev/simple_wyvern/Projects/DEMO", ]]
            --[[ "DEMO", ]]

            -- For debugging editor
            --[[ "--project_root", ]]
            --[[ "/home/patu/Documents/Wyvern_Projects/RPG", ]]
            --[[ "--project_alias", -- We initialize the project with the alias and not the game name that is shown to customers ]]
            --[[ "RPG", ]]
            --[[ "--engine_assets", ]]
            --[[ "/home/patu/dev/simple_wyvern/WyvernEditor", ]]
            --[[ "--engine_root", ]]
            --[[ "/home/patu/dev/simple_wyvern", ]]

            --[[ "~/dev/simple_wyvern/Tools/WyvernHeaderGenerator/External/llvm/clang-tools-extra/my-tool/metareflect/main.cxx" ]]
            --[[ "clang-tools-extra/my-tool/metareflect/main.cxx" ]]
            --[[ "clang-tools-extra/metareflect/metareflect/text.gxx" ]]

            --[[ "clang-tools-extra/my-tool/example/Example.cpp", ]]

            -- For testing WyvernHeaderGenerator
            --[[ "example/Example.h", ]]
            --[[ "--", ]]
            --[[ "-DGENERATE_REFLECTION", ]]
            --[[ "-x", ]]
            --[[ "c++", ]]
            --[[ "-I/home/patu/dev/simple_wyvern/Tools/WyvernHeaderGenerator/External/llvm/clang-tools-extra/WyvernHeaderGenerator/", ]]
            --[[ "-I/home/patu/dev/simple_wyvern/Wyvern/Source/Modules", "-I/home/patu/dev/simple_wyvern/Wyvern/Source/Engine", "-I/home/patu/dev/simple_wyvern/Wyvern/Source/Reflection", "-I/home/patu/dev/simple_wyvern/Wyvern/Source/Engine/Platform", "-I/home/patu/dev/simple_wyvern/Wyvern/Source/Engine/Core", "-I/home/patu/dev/simple_wyvern/Wyvern/Source/Engine/GameFramework", "-I/home/patu/dev/simple_wyvern/Wyvern/Source/Engine/Events", "-I/home/patu/dev/simple_wyvern/Wyvern/Source/Engine/ImGui", "-I/home/patu/dev/simple_wyvern/Wyvern/Source/Engine/Scene", "-I/home/patu/dev/simple_wyvern/Wyvern/Source/Engine/Maths", "-I/home/patu/dev/simple_wyvern/Wyvern/Source/Engine/Input", "-I/home/patu/dev/simple_wyvern/Wyvern/Source/Engine/Graphics", "-I/home/patu/dev/simple_wyvern/Wyvern/Source/Engine/Utils", "-I/home/patu/dev/simple_wyvern/Wyvern/Source/Engine/Platform/Android", "-I/home/patu/dev/simple_wyvern/Wyvern/Source/Engine/Platform/GLFW", "-I/home/patu/dev/simple_wyvern/Wyvern/Source/Engine/Platform/Vulkan", "-I/home/patu/dev/simple_wyvern/Wyvern/Source/Engine/Platform/Unix", "-I/home/patu/dev/simple_wyvern/Wyvern/Source/Engine/Platform/Windows", "-I/home/patu/dev/simple_wyvern/Wyvern/Source/Engine/Core/OS", "-I/home/patu/dev/simple_wyvern/Wyvern/Source/Engine/Graphics/RHI", "-I/home/patu/dev/simple_wyvern/Wyvern/Source/Engine/Graphics/Camera", "-I/home/patu/dev/simple_wyvern/Wyvern/External/glfw/include", "-I/home/patu/dev/simple_wyvern/Wyvern/External/glm", "-I/home/patu/dev/simple_wyvern/Wyvern/External/glad/include", "-I/home/patu/dev/simple_wyvern/Wyvern/External/stb", "-I/home/patu/dev/simple_wyvern/Wyvern/External/imgui", "-I/home/patu/dev/simple_wyvern/Wyvern/External/tracy/public", "-I/home/patu/dev/simple_wyvern/Wyvern/External/spdlog/include", "-I/home/patu/dev/simple_wyvern/Wyvern/External/cereal/include", "-I/home/patu/dev/simple_wyvern/Wyvern/External/imgui_plugins", "-I/home/patu/dev/simple_wyvern/Wyvern/External/spirv_cross/include", "-I/home/patu/dev/simple_wyvern/Wyvern/External/VulkanMemoryAllocator/include" ]]

            -- For testing metareflect
            --[[ "example/test.hxx", ]]
            --[[ "--", ]]
            --[[ "-D__METAREFLECT__", ]]
            --[[ "-x", ]]
            --[[ "c++", ]]
            --[[ "-I/home/patu/dev/simple_wyvern/Tools/WyvernHeaderGenerator/External/llvm/clang-tools-extra/metareflect", ]]
            --[[ "-I/home/patu/dev/simple_wyvern/Tools/WyvernHeaderGenerator/External/llvm/clang-tools-extra/metareflect/metareflect", ]]
            --[[ "-I/home/patu/dev/simple_wyvern/Tools/WyvernHeaderGenerator/External/llvm/clang-tools-extra/metareflect/example", ]]

            --[[ "-I/home/patu/dev/simple_wyvern/Tools/WyvernHeaderGenerator/External/llvm/clang/lib/Headers" ]]

            --[[ "Example.cpp -- -DGENERATE_REFLECTION -x c++ -I/home/patu/dev/simple_wyvern/Tools/WyvernHeaderGenerator/External/llvm/clang-tools-extra/my-tool/example/" ]]
            --[[ "namespace n { namespace m { class C {}; } }", ]]

            --[[ "~/dev/simple_wyvern/Tools/WyvernHeaderGenerator/Test.cpp" ]]
            -- For RenderDoc
            --project_root "/home/patu/Documents/Wyvern_Projects/RPG" --project_alias "RPG" --engine_assets "/home/patu/dev/simple_wyvern/WyvernEditor" --engine_root "/home/patu/dev/simple_wyvern"

            -- For debugging runtime
            --[[ "RPG", ]]
            --[[ "--project_root", ]]
            --[[ "/home/patu/Documents/Wyvern_Projects/RPG", -- For debugging runtime inside a project ]]
            -- This if we want to debug packaged game
            --[[ "/home/patu/Documents/Wyvern_Projects/RPG/PackagedGame/RPG/RPG/Binaries/Debug-linux-x86_64", ]]
        },
        --[[ preLaunchTask = { ]]
        --[[     command = 'cd build && make', ]]
        --[[     type = 'shell', ]]
        --[[ }, ]]
    },
}

local DEBUGGER_PATH = vim.fn.stdpath "data" .. "/site/pack/packer/opt/vscode-js-debug"

require("dap-vscode-js").setup {
    node_path = "node",
    debugger_path = DEBUGGER_PATH,
    -- debugger_cmd = { "js-debug-adapter" },
    adapters = { "pwa-node", "pwa-chrome", "pwa-msedge", "node-terminal", "pwa-extensionHost" }, -- which adapters to register in nvim-dap
}

for _, language in ipairs { "typescript", "javascript" } do
    require("dap").configurations[language] = {
        {
            type = "pwa-node",
            request = "launch",
            name = "Launch file",
            program = "${file}",
            cwd = "${workspaceFolder}",
        },
        {
            type = "pwa-node",
            request = "attach",
            name = "Attach",
            processId = require("dap.utils").pick_process,
            cwd = "${workspaceFolder}",
            port = 9228,
        },
        {
            type = "pwa-node",
            request = "launch",
            name = "Debug Jest Tests",
            -- trace = true, -- include debugger info
            runtimeExecutable = "node",
            runtimeArgs = {
                "./node_modules/jest/bin/jest.js",
                "--runInBand",
            },
            rootPath = "${workspaceFolder}",
            cwd = "${workspaceFolder}",
            console = "integratedTerminal",
            internalConsoleOptions = "neverOpen",
        },
    }
end

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
    force_buffers = true,
    icons = {
        -- expanded = "➖",
        -- collapsed = "➕",
        -- circular = "⭕",

        --[[ expanded = "►", ]]
        --[[ collapsed = "▼", ]]
        collapsed = "►",
        expanded = "▼",
        circular = "⭕",

        disconnect = "",
        pause = "",
        play = "",
        run_last = "",
        step_back = "",
        step_into = "",
        step_out = "",
        step_over = "",
        terminate = "",
        breakpoint = "T",
    },
    expand_lines = true,
    --[[ mappings = { ]]
    --[[     expand = {"<CR>", "<Tab>"}, ]]
    --[[     open = "o", ]]
    --[[     remove = "d" ]]
    --[[ }, ]]
    mappings = {
      edit = "e",
      expand = { "<CR>", "<Tab>", "<2-LeftMouse>" },
      open = "o",
      remove = "d",
      repl = "r",
      toggle = "t"
    },
    floating = {
        border = "single",
        mappings = {
            close = { "q", "<Esc>" },
        }
    },
    layouts = {
        {
            elements = {
                --[[ 'scopes', ]]
                --[[ 'breakpoints', ]]
                'watches',
                'stacks',
                --[[ 'console', ]]
            },
            size = 65,
            position = 'left',
        },
        {
            elements = {
                'repl',
                --[[ 'console', ]]
                --[[ 'watches' ]]
            },
            size = 16,
            position = 'bottom',
        },
        {
            elements = {
                --[[ 'watches' ]]
            },
            size = 20,
            position = 'right'
        }
    }
}

----------------------------------------------------------------------------
-- My collection of functions that help c++ engine development inside neovim
--
-- when cloning from git move this to:
--  nvim/bin/lua
-- or any other location that nvim searches for lua scripts
----------------------------------------------------------------------------


workspaceFolder = '/home/patu/simple_wyvern/Projects/DEMO'
--[[ workspaceFolder = '/home/patu/simple_wyvern' ]]

-- Build command
global_cmd = 'make'
-- Run command
wyvernEditor = 'cd ' .. workspaceFolder .. '/WyvernEditor && '  .. workspaceFolder .. '/build/bin/Debug-linux-x86_64/WyvernEditor/WyvernEditor --project_root ' .. workspaceFolder .. ' --project_name DEMO --engine_assets ' .. workspaceFolder .. '/WyvernEditor'
--[[ wyvernEditor = 'cd ' .. workspaceFolder .. '/build/bin/Debug-linux-x86_64/WyvernEditor && '  .. workspaceFolder .. '/build/bin/Debug-linux-x86_64/WyvernEditor/WyvernEditor' ]]

local operating_system = vim.loop.os_uname().sysname

if (operating_system == "WINDOWS_NT") then
    global_cmd = 'devenv ' .. workspaceFolder .. '/build/WyvernEngine.sln /Build'
    wyvernEditor = 'cd ' .. workspaceFolder .. '/build/bin/Debug-windows-x86_64/WyvernEditor && '  .. workspaceFolder .. '/build/bin/Debug-windows-x86_64/WyvernEditor/WyvernEditor.exe'
    workspaceFolder = 'C:/devel/TIES471/GameEngine'
end

function run_wyvern_engine()
    print('Running at: ' .. workspaceFolder)
    os.execute(wyvernEditor)
    --[[ os.execute('cd ' .. 'C:/devel/TIES471/VulkanExample/build/bin && '.. 'C:/devel/TIES471/VulkanExample/build/bin/WyvernEngine.exe') ]]
end

function build_game()
    -- Get current working directory
    local current_working_directory = vim.fn.getcwd()
    print('Running build at: ' .. current_working_directory .. '/Projects/DEMO/build')
    local term = require'toggleterm.terminal'.Terminal
    --[[ print("term is: " .. term.name) ]]
    local toggleterm = term:new({
        --[[ name = "term", ]]
        --[[ cmd = 'devenv ' .. workspaceFolder .. '/build/WyvernEngine.sln /Build', ]]
        cmd = "make -j32",
        dir = current_working_directory .. '/Projects/DEMO/build',
        size = { height = 5, width = 5 },
        hidden = false,
        direction = 'horizontal',
        close_on_exit = false
        -- env = {
            
        -- },
    })
    
    --[[ toggleterm:toggle() ]]
    toggleterm:open()
    -- os.execute('devenv ' .. workspaceFolder .. '/build/WyvernEngine.sln /Build')
end
function build()
    -- Get current working directory
    local current_working_directory = vim.fn.getcwd()
    print('Running build at: ' .. current_working_directory .. '/build')
    local term = require'toggleterm.terminal'.Terminal
    --[[ print("term is: " .. term.name) ]]
    local toggleterm = term:new({
        --[[ name = "term", ]]
        --[[ cmd = 'devenv ' .. workspaceFolder .. '/build/WyvernEngine.sln /Build', ]]
        cmd = "make -j32",
        dir = current_working_directory .. '/build',
        size = { height = 5, width = 5 },
        hidden = false,
        direction = 'horizontal',
        close_on_exit = false
        -- env = {
            
        -- },
    })
    
    --[[ toggleterm:toggle() ]]
    toggleterm:open()
    -- os.execute('devenv ' .. workspaceFolder .. '/build/WyvernEngine.sln /Build')
end

function build_wyvern_engine()
    print('Running build at: ' .. workspaceFolder .. '/build')
    local term = require'toggleterm.terminal'.Terminal
    --[[ print("term is: " .. term.name) ]]
    local toggleterm = term:new({
        --[[ name = "term", ]]
        --[[ cmd = 'devenv ' .. workspaceFolder .. '/build/WyvernEngine.sln /Build', ]]
        cmd = global_cmd,
        dir = workspaceFolder .. '/build',
        size = { height = 5, width = 5 },
        hidden = false,
        direction = '',
        close_on_exit = false
        -- env = {
            
        -- },
    })
    
    toggleterm:toggle()

    -- os.execute('devenv ' .. workspaceFolder .. '/build/WyvernEngine.sln /Build')
end

function swap_to_header_or_source_file()
    local file_extension = vim.fn.expand('%:e')

    if (file_extension == "cpp") then
        vim.api.nvim_command(":e %<.h")
    else
        vim.api.nvim_command(":e %<.cpp")
    end
    -- vim.api.nvim_command(":e %<.h") 
    -- os.execute("devenv build/WyvernEngine.sln /Build && build/bin/Debug-Windows-x86_64/WyvernEditor/WyvernEditor.exe")
end

return {
    run_wyvern_engine = run_wyvern_engine,
    build_wyvern_engine = build_wyvern_engine,
    swap_to_header_or_source_file = swap_to_header_or_source_file,
    run_build_in_current_cwd = build,
    run_build_in_current_game_cwd = build_game
}


----------------------------------------------------------------------------
-- My collection of functions that help c++ engine development inside neovim
--
-- when cloning from git move this to:
--  nvim/bin/lua
-- or any other location that nvim searches for lua scripts
----------------------------------------------------------------------------

workspaceFolder = 'C:/devel/TIES471/GameEngine'

function run_wyvern_engine()
    print('Running at: ' .. workspaceFolder)
    os.execute('cd ' .. workspaceFolder .. '/build/bin/Debug-windows-x86_64/WyvernEditor && '  .. workspaceFolder .. '/build/bin/Debug-windows-x86_64/WyvernEditor/WyvernEditor.exe')
end

function build_wyvern_engine()
    print('Running build at: ' .. workspaceFolder)
    local term = require'toggleterm.terminal'.Terminal
    --[[ print("term is: " .. term.name) ]]
    local toggleterm = term:new({
        --[[ name = "term", ]]
        cmd = 'devenv ' .. workspaceFolder .. '/build/WyvernEngine.sln /Build',
        dir = workspaceFolder,
        size = { height = 5, width = 5 },
        hidden = false,
        direction = 'horizontal',
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
    swap_to_header_or_source_file = swap_to_header_or_source_file
}


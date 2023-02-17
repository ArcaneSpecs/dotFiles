local status_ok, alpha = pcall(require, "alpha")
if not status_ok then
	return
end

--[[
-- TODO: generate header with figlet or something similar in a crossplatform way
if (os.execute("figlet --version")) then
    print("figlet found!")
else
    print("no figlet found!")
end
]]--

local dashboard = require("alpha.themes.dashboard")
dashboard.section.header.val = [[
      _       __                               ______    ___ __
     | |     / /_  ___   _____  _________     / ____/___/ (_) /_____  _____
     | | /| / / / / / | / / _ \/ ___/ __ \   / __/ / __  / / __/ __ \/ ___/
     | |/ |/ / /_/ /| |/ /  __/ /  / / / /  / /___/ /_/ / / /_/ /_/ / /
     |__/|__/\__, / |___/\___/_/  /_/ /_/  /_____/\__,_/_/\__/\____/_/
            /____/
]]

local config_path = vim.fn.stdpath('config')
-- print(string.format("Config path is: %s", config_path))

dashboard.section.buttons.val = {
	dashboard.button("f", "  Find file", ":Telescope find_files <CR>"),
	dashboard.button("e", "  New file", ":ene <BAR> startinsert <CR>"),
	dashboard.button("p", "  Find project", ":Telescope projects <CR>"),
	dashboard.button("r", "  Recently used files", ":Telescope oldfiles <CR>"),
	dashboard.button("t", "  Find text", ":Telescope live_grep <CR>"),
	-- dashboard.button("c", "  Configuration", ":e ~/.config/nvim/init.lua <CR>"),
	-- dashboard.button(string.format("c", "  Configuration", ":e %s <CR>"), config_path),
	dashboard.button("c", "  Configuration", ":e " .. config_path .. "/init.lua" .. " <CR>"),
	dashboard.button("q", "  Quit", ":qa<CR>"),
}

local function footer()
-- NOTE: requires the fortune-mod package to work
	-- local handle = io.popen("fortune")
	-- local fortune = handle:read("*a")
	-- handle:close()
	-- return fortune
	return ""
end

dashboard.section.footer.val = footer()

dashboard.section.footer.opts.hl = "Type"
dashboard.section.header.opts.hl = "Include"
dashboard.section.buttons.opts.hl = "Keyword"

dashboard.opts.opts.noautocmd = true
-- vim.cmd([[autocmd User AlphaReady echo 'ready']])
alpha.setup(dashboard.opts)

-- WyvernChat config
local status_ok, wyvern_chat = pcall(require, "WyvernChat")
if not status_ok then
    return
end

-- vim.notify("WyvernChat config loaded", vim.log.levels.INFO)

local config = {

}
wyvern_chat.setup(config)


-- Hex editor config
local hex_status_ok, hexeditor = pcall(require, "HexEditor")
if not hex_status_ok then
    return
end

local hex_config = {

}
hexeditor.setup(hex_config)

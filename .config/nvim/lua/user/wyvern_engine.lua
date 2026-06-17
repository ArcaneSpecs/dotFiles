-- Wyvern Engine VFS path jump and completion

vim.cmd([[
  set includeexpr=VFSToPath(v:fname)
  function! VFSToPath(fname)
    let root = fnamemodify(getcwd(), ':p')
    let result = substitute(a:fname, '^//engine/', root . 'engine/assets/', '')
    let result = substitute(result, '^//game/', root . 'projects/RPG/content/', '')
    return result
  endfunction
]])

-- nvim-cmp VFS source
local cmp = require("cmp")

local vfs_source = {}
vfs_source.new = function()
	return setmetatable({}, { __index = vfs_source })
end

vfs_source.get_debug_name = function()
	return "vfs"
end

vfs_source.is_available = function()
	local ft = vim.bo.filetype
	return ft == "json" or ft == "yaml"
end

vfs_source.get_keyword_pattern = function()
	return [=[//\?[a-zA-Z0-9_./-]*]=]
end

vfs_source.get_trigger_characters = function()
	return { "/" }
end

vfs_source.complete = function(_, params, callback)
	local before = params.context.cursor_before_line
	-- vim.notify("complete called: " .. before)
	local roots = {
		{ prefix = "//engine/", dir = "engine/assets/" },
		{ prefix = "//game/", dir = "projects/RPG/content/" },
	}

	local items = {}
	for _, r in ipairs(roots) do
		local _, pos = before:find(r.prefix, 1, true)
		if pos then
			local partial = before:sub(pos + 1)
			local real_dir = vim.fn.getcwd() .. "/" .. r.dir
			local files = vim.fn.glob(real_dir .. partial .. "*", false, true)
			for _, f in ipairs(files) do
				local rel = f:sub(#real_dir + 1)
				-- vim.notify("f: " .. f .. " rel: '" .. rel .. "'")
				local label = r.prefix .. rel
				if vim.fn.isdirectory(f) == 1 then
					label = label .. "/"
				end
				table.insert(items, {
					label = label,
					insertText = label,
					kind = vim.fn.isdirectory(f) == 1 and cmp.lsp.CompletionItemKind.Folder
						or cmp.lsp.CompletionItemKind.File,
					filterText = label,
				})
			end
		end
	end
	callback(items)
	-- vim.notify("items sent: " .. #items)
end

cmp.register_source("vfs", vfs_source.new())

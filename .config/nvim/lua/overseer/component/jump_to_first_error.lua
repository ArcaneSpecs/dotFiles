return {
	desc = "Open quickfix at bottom, parse selected line, jump to file at line/col in upper window",
	constructor = function(params)
		return {
			on_complete = function(self, task, status, result)
				-- Check if quickfix has items
				local qf_list = vim.fn.getqflist()
				if #qf_list > 0 then
					vim.cmd("copen") -- Open quickfix window at bottom
					vim.cmd("normal! 2j") -- Move cursor down 2 lines to select an error
					-- Parse current quickfix line for file path, line number, and column
					local current_line = vim.fn.getline(".")
					local fname, lnum_str, col_str = current_line:match("^|| (.-)%((%d+):(%d+)%) Error:")
					local lnum = fname and tonumber(lnum_str)
					local col = fname and tonumber(col_str)
					if fname and lnum and col then
						vim.cmd("wincmd k") -- Switch to window above (main editor)
						vim.cmd("edit " .. vim.fn.fnameescape(fname)) -- Open the file
						vim.api.nvim_win_set_cursor(0, { lnum, col - 1 }) -- Jump to parsed line and column
					end
					-- Quickfix remains open at bottom for reference
				end
			end,
		}
	end,
}

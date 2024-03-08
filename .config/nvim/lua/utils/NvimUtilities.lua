local M = {}

function M.switch_shader()
  local bufname = vim.api.nvim_buf_get_name(0)
  local basename = vim.fn.fnamemodify(bufname, ':r')
  local new_ext = vim.fn.fnamemodify(bufname, ':e') == 'vert' and 'frag' or 'vert'
  local new_bufname = basename .. '.' .. new_ext
  vim.api.nvim_command('edit ' .. new_bufname)
end

function M.switch_file_pair()
  local filetype = vim.bo.filetype
  if filetype == 'glsl' then
    M.switch_shader()
  elseif filetype == 'cpp' then
    vim.cmd("ClangdSwitchSourceHeader")
  elseif filetype == 'h' then
    vim.cmd("ClangdSwitchSourceHeader")
  else
    print('filetype ' .. filetype .. ' is not supported')
  end
end

return M

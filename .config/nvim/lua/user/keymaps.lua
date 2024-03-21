require "utils.my_functions"
local opts = { noremap = true, silent = true }

local term_opts = { silent = true }

-- Shorten function name
local keymap = vim.api.nvim_set_keymap

--Remap space as leader key
keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

-- Terminal toggle
keymap("n", "<C-t>", ":ToggleTerm size=10 direction=horizontal<CR>", opts)

-- Alternate cpp and header files
--[[ keymap("n", "<A-o>", ":ClangdSwitchSourceHeader<CR>", opts) ]]

-- Alternate glsl shader files

vim.cmd([[
  autocmd FileType cpp nnoremap <buffer> <A-o> :ClangdSwitchSourceHeader<CR>
]])

vim.cmd([[
  autocmd FileType glsl nnoremap <buffer> <A-o> :lua require('utils.NvimUtilities').switch_shader()<CR>
]])

keymap("n", "<A-o>", ":lua require('utils.NvimUtilities').switch_file_pair()<CR>", opts)

-- Set tab to tab
keymap("i", "<Tab>", "<Tab>", opts)

-- Alternate cpp and header files but also generate one if it doesn't exist in cwd
keymap("n", "<A-i>", ":lua require'utils.my_functions'.swap_to_header_or_source_file()<CR>", opts)

-- Build and run Wyvern Engine (TODO: specify project build)
keymap("n", "<F6>", ":lua require'utils.my_functions'.run_wyvern_engine()<CR>", opts)
--[[ keymap("n", "<C-b>", ":lua require'utils.my_functions'.build_wyvern_engine()<CR>", opts) ]]
--[[ keymap("n", "<C-b>", ":lua require'utils.my_functions'.run_build_in_current_cwd()<CR>", opts) ]]
--[[ keymap("n", "<C-b>", ":lua require'utils.my_functions'.run_build_in_current_game_cwd()<CR>", opts) ]]

-- Copilot
vim.api.nvim_set_keymap("i", "<A-j>", "copilot#Next()", { silent = true, expr = true })
vim.api.nvim_set_keymap("i", "<A-k>", "copilot#Previous()", { silent = true, expr = true })

-- Hex editor
-- To hex
keymap("n", "<leader>x", ":%!xxd<CR>", opts)
-- From hex to text
keymap("n", "<leader>xw", ":%!xxd -r<CR>", opts)
keymap("n", "<leader>X", ":%!xxd -r<CR>", opts)

-- Undotree
keymap("n", "<leader>u", ":UndotreeToggle<CR>", opts)

-- Go to method
keymap("n", "<leader>m", ":Telescope lsp_document_symbols<CR>", opts)

-- Make J not jump the cursor
keymap("n", "J", "mzJ`z", opts)

-- Telescope
-- Replace in all files in quick fix list
keymap("n", "<leader>a", ":cdo %s///g<Left><Left><Left>", opts)
-- Preview file in quick fix list
keymap("n", "<S-Return>", "<CR>:set wrap<CR><C-w>j", opts)

-- Tagbar
--[[ keymap("n", "<C-d>", ":TagbarToggle<CR>", opts) ]]

-- Diffs movement
keymap("n", "<A-2>", "[c", opts)
keymap("n", "<A-1>", "]c", opts)
keymap("n", "<C-d>", ":diffthis<CR>", opts)

-- Navigate git hunks
keymap("n", "gk", ":Gitsigns prev_hunk<CR>", opts)
keymap("n", "gj", ":Gitsigns next_hunk<CR>", opts)
keymap("n", "gh", ":Gitsigns preview_hunk_inline<CR>", opts)

-- Quick paste first register
keymap("n", "<leader>J", "\"0P", opts)
keymap("n", "<leader>j", "viw\"0P", opts)
keymap("n", "<leader>h", "viw\"1P", opts)
keymap("n", "<leader>p", "\"_dP", opts)

-- DAP keybinds
--[[ keymap("n", "<F5>", ":call vimspector#Launch()<CR>", opts) ]]
--[[ keymap("n", "<F5>", ":lua require'dap'.continue()<CR>", opts) ]]

-- Bind F5 to run dapui
keymap("n", "<F5>", ":lua require'utils.my_functions'.run_my_dapui()<CR>", opts)
keymap("n", "<F10>", ":lua require'dap'.step_over()<CR>", opts)
keymap("n", "<F11>", ":lua require'dap'.step_into()<CR>", opts)
keymap("n", "<F12>", ":lua require'dap'.step_out()<CR>", opts)
keymap("n", "<leader>b", ":lua require'dap'.toggle_breakpoint()<CR>", opts)
keymap("n", "<leader>B", ":lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>", opts)
keymap("n", "<leader>lp", ":lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<CR>", opts)
keymap("n", "<leader>k", ":lua require'dapui'.open()<CR>", opts)

keymap("n", "<leader><F3>", ":lua require'dapui'.toggle()<CR>", opts)
keymap("n", "<leader><F4>", ":lua require'dapui'.toggle(2)<CR>", opts)
keymap("n", "<leader><F2>", ":lua require'dapui'.eval(nil, {enter=true})<CR>", opts)
keymap("n", "<F7>", ":lua require'dap'.terminate()<CR>", opts)

keymap("n", "<leader>1", ":lua require'dapui'.float_element(\"scopes\", {enter=true})<CR>", opts)
keymap("n", "<leader>2", ":lua require'dapui'.float_element(\"stacks\", {enter=true})<CR>", opts)
keymap("n", "<leader>3", ":lua require'dapui'.float_element(\"watches\", {enter=true})<CR>", opts)
keymap("n", "<leader>4", ":lua require'dapui'.float_element(\"breakpoints\", {enter=true})<CR>", opts)

--[[ keymap("n", "<leader>i", ":lua require'telescope'.extensions.goimpl.goimpl{}<CR>", opts) ]]
-- keymap("n", "<leader>i", ":TSCppDefineClassFunc<CR>", opts)

keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)

-- Resize with arrows
keymap("n", "<C-Up>", ":resize +2<CR>", opts)
keymap("n", "<C-Down>", ":resize -2<CR>", opts)
keymap("n", "<C-Left>", ":vertical resize -2<CR>", opts)
keymap("n", "<C-Right>", ":vertical resize +2<CR>", opts)
-- Resize fast with arrows
keymap("n", "<C-A-Up>", ":resize +10<CR>", opts)
keymap("n", "<C-A-Down>", ":resize -10<CR>", opts)
keymap("n", "<C-A-Left>", ":vertical resize -10<CR>", opts)
keymap("n", "<C-A-Right>", ":vertical resize +10<CR>", opts)

-- Navigate buffers
-- Using these keeps the buffer list in order if you move them with Alt-h/l
keymap("n", "<S-l>", ":BufferLineCycleNext<CR>", opts)
keymap("n", "<S-h>", ":BufferLineCyclePrev<CR>", opts)
--[[ keymap("n", "<S-l>", ":bnext<CR>", opts) ]]
--[[ keymap("n", "<S-h>", ":bprevious<CR>", opts) ]]

-- Navigate tabs
keymap("n", "<A-S-l>", ":tabnext<CR>", opts)
keymap("n", "<A-S-h>", ":tabprevious<CR>", opts)
keymap("n", "<A-S-n>", ":tabnew<CR>", opts)
keymap("n", "<A-S-w>", ":tabclose<CR>", opts)

keymap("n", "<A-h>", ":BufferLineMovePrev<CR>", opts)
keymap("n", "<A-l>", ":BufferLineMoveNext<CR>", opts)

-- Close all buffers
keymap("n", "<leader>C", ":bufdo bwipeout<CR>", opts)

--[[ keymap("n", "<leader>Y", ":%bd|e#<CR>", opts) ]]

-- Move text up and down
keymap("n", "<A-k>", "<Esc>:m -2<CR>", opts)
keymap("n", "<A-j>", "<Esc>:m +1<CR>", opts)

-- Todo comments
keymap("n", "<leader>t", ":TodoTelescope<CR>", opts)
keymap("n", "<leader>T", ":TodoLocList cwd=Wyvern/Source<CR>", opts)

-- Move current line / block with Alt-j/k ala vscode.
--[[ ["<A-j>"] = "<Esc>:m .+1<CR>==gi", ]]
-- Move current line / block with Alt-j/k ala vscode.
--[[ ["<A-k>"] = "<Esc>:m .-2<CR>==gi", ]]
-- Better keys for jumping around (on finnish keyboard)
--keymap("n", "<'>[", "<'>w", opts)
--keymap("n", "<'>]", "<'>d", opts)


-- Insert --
-- Press jk fast to exit insert mode
keymap("i", "jk", "<ESC>", opts)

-- Visual --
-- Stay in indent mode
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- Move text up and down
keymap("v", "<A-j>", ":m .+1<CR>==", opts)
keymap("v", "<A-k>", ":m .-2<CR>==", opts)
keymap("v", "p", '"_dP', opts)

-- Visual Block --
-- Move text up and down
keymap("x", "J", ":move '>+1<CR>gv-gv", opts)
keymap("x", "K", ":move '<-2<CR>gv-gv", opts)
keymap("x", "<A-j>", ":move '>+1<CR>gv-gv", opts)
keymap("x", "<A-k>", ":move '<-2<CR>gv-gv", opts)

-- Terminal --
-- Better terminal navigation
-- keymap("t", "<C-h>", "<C-\\><C-N><C-w>h", term_opts)
-- keymap("t", "<C-j>", "<C-\\><C-N><C-w>j", term_opts)
-- keymap("t", "<C-k>", "<C-\\><C-N><C-w>k", term_opts)
-- keymap("t", "<C-l>", "<C-\\><C-N><C-w>l", term_opts)


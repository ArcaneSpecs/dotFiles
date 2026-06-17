require "utils.my_functions"
local opts = { noremap = true, silent = true }
local term_opts = { silent = true }

-- Shorten function name
local keymap = vim.api.nvim_set_keymap

-- NOTE: Comment out for typing finnish
-- -- Remap ä to {
-- keymap("i", "ö", "{", opts);
-- -- Remap ö to }
-- keymap("i", "ä", "}", opts);
-- keymap("i", "Ö", "[", opts);
-- keymap("i", "Ä", "]", opts);

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

-- vim.cmd([[
--     autocmd FileType csv nnoremap <buffer> <C-l> :RainbowCellGoRight<CR>
--     autocmd FileType csv nnoremap <buffer> <C-h> :RainbowCellGoLeft<CR>
--     autocmd FileType csv nnoremap <buffer> <C-j> :RainbowCellGoDown<CR>
--     autocmd FileType csv nnoremap <buffer> <C-k> :RainbowCellGoUp<CR>
--     autocmd FileType csv nnoremap <buffer> <C-g> :RainbowAlign<CR>
--     autocmd FileType csv nnoremap <buffer> <C-y> :RainbowDelimSimple<CR>
-- ]])

-- vim.api.nvim_create_augroup('csv_filetype', { clear = true })
-- vim.api.nvim_create_autocmd('FileType', {
--     pattern = 'csv_semicolon',
--     callback = function()
--         vim.keymap.set('n', '<C-l>', ':RainbowCellGoRight<CR>', { noremap = true, silent = true })
--         vim.keymap.set('n', '<C-h>', ':RainbowCellGoLeft<CR>', { noremap = true, silent = true })
--         vim.keymap.set('n', '<C-j>', ':RainbowCellGoDown<CR>', { noremap = true, silent = true })
--         vim.keymap.set('n', '<C-k>', ':RainbowCellGoUp<CR>', { noremap = true, silent = true })
--         vim.keymap.set('n', '<C-g>', ':RainbowAlign<CR>', { noremap = true, silent = true })
--         vim.keymap.set('n', '<C-y>', ':RainbowDelimSimple<CR>', { noremap = true, silent = true })
--
--         -- vim.opt.number = true
--         -- vim.opt.relativenumber = true
--     end,
-- })

keymap("n", "<A-o>", ":lua require('utils.NvimUtilities').switch_file_pair()<CR>", opts)

keymap("n", "<leader>Z", ":w<CR>:source %<CR>", opts)
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
-- vim.api.nvim_set_keymap("i", "<A-j>", "copilot#Next()", { silent = true, expr = true })
-- vim.api.nvim_set_keymap("i", "<A-k>", "copilot#Previous()", { silent = true, expr = true })

-- Hex editor
-- To hex
keymap("n", "<leader>X", ":HexToggle<CR>", opts)
-- keymap("n", "<leader>x", ":%!xxd<CR>", opts)
-- From hex to text
-- keymap("n", "<leader>xw", ":%!xxd -r<CR>", opts)
-- keymap("n", "<leader>X", ":%!xxd -r<CR>", opts)
-- keymap("n", "<leader>xw", ":%!xxd -r<CR>", opts)
-- keymap("n", "<leader>X", ":%!xxd -r<CR>", opts)

-- Undotree
keymap("n", "<leader>u", ":UndotreeToggle<CR>", opts)

-- Overseer
keymap("n", "<C-B>", ":OverseerRun<CR>", opts)
-- keymap("n", "<C-S-B>", ":OverseerQuickAction restart<CR>:OverseerClose<CR>", opts)
keymap("n", "<C-S-B>", ":OverseerQuickAction restart<CR>", opts)
keymap("n", "<leader>xs", ":OverseerRun<CR>", opts)
keymap("n", "<leader>xa", ":OverseerToggle<CR>", opts)

-- TODO: fix navigation out of overseer list
-- keymap("n", "<C-h>", "<C-\\><C-N><C-w>h", term_opts)
-- keymap("n", "<C-j>", "<C-\\><C-N><C-w>j", term_opts)
-- keymap("n", "<C-k>", "<C-\\><C-N><C-w>k", term_opts)
-- keymap("n", "<C-l>", "<C-\\><C-N><C-w>l", term_opts)

-- Go to method
keymap("n", "<leader>m", ":Telescope lsp_document_symbols<CR>", opts)

-- Make J not jump the cursor
keymap("n", "J", "mzJ`z", opts)

-- Jump backticks
keymap('n', '%', [[:%s/^\(\s*```.*\)\n\(\s*\)/\1\n\2/g<CR>:nohlsearch<CR>]], opts)

-- Telescope
-- Replace in all files in quick fix list
keymap("n", "<leader>a", ":cdo %s///g<Left><Left><Left>", opts)
keymap("n", "<leader>A", ":%s///g<Left><Left><Left>", opts)
keymap("v", "<leader>A", ":s//g<Left><Left>", opts)
-- Preview file in quick fix list
-- keymap("n", "<S-Return>", "<CR>:set wrap<CR><C-w>j", opts)

vim.cmd([[
augroup my_quickfix
    autocmd!
    " autocmd FileType qf nnoremap <buffer> <Tab> <CR>:set wrap<CR><C-w>j
    autocmd FileType qf nnoremap <buffer> <Tab> <CR><C-w>j
    " autocmd FileType qf nnoremap <buffer> <Tab> :echo "hello"<CR>
augroup end
]])

keymap("n", "<leader>0", ":Telescope spell_suggest<CR>", opts)
keymap("n", "<leader>9", ":set spell!<CR>", opts)
keymap("n", "<leader>8", ":lua require('dropbar.api').pick()<CR>", opts)
keymap("n", "<leader>7", ":lua require('dropbar.api').toggle()<CR>", opts)
-- keymap("n", "<leader>H", ":messages<CR>:wincmd b<CR>ggG", opts)
keymap("n", "<leader>H", ":Telescope notify<CR>", opts)

-- Wyvern chat keybinds
-- keymap("n", "<leader>K", ":WyvernChatEditWithInstructions<CR>", opts)
-- keymap("n", "<leader>k", ":WyvernChat<CR>", opts)

-- Rainbow CSV

-- Tagbar
-- keymap("n", "<C-d>", ":TagbarToggle<CR>", opts)

-- Diffs movement
keymap("n", "<C-A-j>", "]c", opts)
keymap("n", "<C-A-k>", "[c", opts)
keymap("n", "<C-S-d>", ":diffthis<CR>", opts)
-- keymap("n", "<C-S-d>", ":set diff!<CR>", opts)

-- Navigate git hunks
keymap("n", "gk", ":Gitsigns prev_hunk<CR>", opts)
keymap("n", "gj", ":Gitsigns next_hunk<CR>", opts)
keymap("n", "gh", ":Gitsigns preview_hunk_inline<CR>", opts)

-- Navigate marks
keymap("n", "g1", "'1", opts)
keymap("n", "g2", "'2", opts)
keymap("n", "g3", "'3", opts)
keymap("n", "g4", "'4", opts)
keymap("n", "g5", "'5", opts)
keymap("n", "g6", "'6", opts)

-- Quick execute q macro
keymap("n", "<leader>h", "1@qj", opts)

-- Quick execute w macro
-- keymap("n", "<leader>N", "1@w", opts)

-- Quick pasting yanks and deletions
keymap("n", "<leader>j", "viw\"0P", opts)
keymap("n", "<leader>J", "viw\"ap", opts)
keymap("v", "<leader>a", "\"ad", opts)
keymap("v", "<leader>s", "\"ap", opts)

-- keymap("n", "<leader>J", "\"0P", opts)

-- Quick pasting registers
keymap("v", "<leader>1", "\"bd", opts)
keymap("n", "<leader><leader>1", "\"bp", opts)
keymap("v", "<leader>2", "\"cd", opts)
keymap("n", "<leader><leader>2", "\"cp", opts)
keymap("v", "<leader>3", "\"dd", opts)
keymap("n", "<leader><leader>3", "\"dp", opts)
keymap("v", "<leader>4", "\"ed", opts)
keymap("n", "<leader><leader>4", "\"ep", opts)

-- Hotkey for registers
keymap("n", "<leader><leader>", "\"", opts)

-- Paste inside
keymap("n", "<leader>k", "vi\"P<Right>f\"", opts)

-- Paste inside "" and go down
-- keymap("n", "<leader>k", "vi\"Pj", opts)

keymap("n", "<leader>k", "vi\"P", opts)
-- keymap("n", "<leader>H", "vi\"P", opts)
-- keymap("n", "<leader>p", "\"_dP", opts)

keymap("n", "Q", "gqq", opts)

-- Open messages and hop into it
-- DAP keybinds
--[[ keymap("n", "<F5>", ":call vimspector#Launch()<CR>", opts) ]]
--[[ keymap("n", "<F5>", ":lua require'dap'.continue()<CR>", opts) ]]

-- Bind F5 to run dapui
keymap("n", "<F5>", ":lua require'utils.my_functions'.run_my_dapui()<CR>", opts)
keymap("n", "<F6>", ":lua require('dap').run_last()<CR>", opts)
keymap("n", "<F10>", ":lua require'dap'.step_over()<CR>", opts)
keymap("n", "<F11>", ":lua require'dap'.step_into()<CR>", opts)
keymap("n", "<F12>", ":lua require'dap'.step_out()<CR>", opts)
keymap("n", "<leader><F12>", ":NoiceDismiss<CR>", opts)
keymap("n", "<leader>b", ":lua require'dap'.toggle_breakpoint()<CR>", opts)
keymap("n", "<leader>B", ":lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>", opts)
keymap("n", "<leader>lp", ":lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<CR>", opts)
-- keymap("n", "<leader>k", ":lua require'dapui'.open()<CR>", opts)

keymap("n", "<leader><F3>", ":lua require'dapui'.toggle()<CR>", opts)
keymap("n", "<leader><F4>", ":lua require'dapui'.toggle(2)<CR>", opts)
keymap("n", "<leader><F2>", ":lua require'dapui'.eval(nil, {enter=true})<CR>", opts)
keymap("n", "<F7>", ":lua require'dap'.terminate()<CR>", opts)

keymap("n", "<leader>1", ":lua require'dapui'.float_element(\"scopes\", {enter=true})<CR>", opts)
keymap("n", "<leader>2", ":lua require'dapui'.float_element(\"stacks\", {enter=true})<CR>", opts)
keymap("n", "<leader>3", ":lua require'dapui'.float_element(\"watches\", {enter=true})<CR>", opts)
keymap("n", "<leader>4", ":lua require'dapui'.float_element(\"breakpoints\", {enter=true})<CR>", opts)
keymap("n", "<leader>5", ":DapVirtualTextToggle<CR>", opts)

--[[ keymap("n", "<leader>i", ":lua require'telescope'.extensions.goimpl.goimpl{}<CR>", opts) ]]
-- keymap("n", "<leader>i", ":TSCppDefineClassFunc<CR>", opts)

-- Window navigation
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)
-- keymap("n", "<C-h>", ":wincmd h<CR>", opts)
-- keymap("n", "<C-j>", ":wincmd j<CR>", opts)
-- keymap("n", "<C-l>", ":wincmd l<CR>", opts)
-- keymap("n", "<C-k>", ":wincmd k<CR>", opts)

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

-- Quick calc
keymap("n", "<A-c>", ":lua print()<Left>", opts)

-- Todo comments
keymap("n", "<leader>t", ":TodoTelescope<CR>", opts)
keymap("n", "<leader>T", ":TodoLocList cwd=Wyvern/Source<CR>", opts)

-- Neogen
keymap("n", "<leader>N", ":lua require('neogen').generate()<CR>", opts)

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

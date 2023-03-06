local status_ok, configs = pcall(require, "nvim-treesitter.configs")
if not status_ok then
	return
end

vim.cmd('autocmd BufRead,BufNewFile *.frag set filetype=glsl')
vim.cmd('autocmd BufRead,BufNewFile *.vert set filetype=glsl')
vim.cmd('autocmd BufRead,BufNewFile *.comp set filetype=glsl')
vim.cmd('autocmd BufRead,BufNewFile *.shader set filetype=glsl')
vim.cmd('autocmd BufRead,BufNewFile *.glslh set filetype=glsl')

configs.setup({
	ensure_installed = "all", -- one of "all" or a list of languages
	ignore_install = { "" }, -- List of parsers to ignore installing
	highlight = {
		enable = true, -- false will disable the whole extension
		disable = { "css" }, -- list of language that will be disabled
	},
	autopairs = {
		enable = true,
	},
	indent = { enable = true, disable = { "python", "css", "cpp"} },
})

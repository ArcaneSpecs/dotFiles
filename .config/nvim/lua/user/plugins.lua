local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
	PACKER_BOOTSTRAP = fn.system({
		"git",
		"clone",
		"--depth",
		"1",
		"https://github.com/wbthomason/packer.nvim",
		install_path,
	})
	print("Installing packer close and reopen Neovim...")
	vim.cmd([[packadd packer.nvim]])
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]])

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
	return
end

-- Have packer use a popup window
packer.init({
	display = {
		open_fn = function()
			return require("packer.util").float({ border = "rounded" })
		end,
	},
})

-- Install your plugins here
return packer.startup(function(use)
	-- My plugins here
    --use({"ViliLipo/Oiko"})
	use({ "wbthomason/packer.nvim", commit = "1d0cf98a561f7fd654c970c49f917d74fafe1530" }) -- Have packer manage itself
	use({ "nvim-lua/plenary.nvim", commit = "9a0d3bf7b832818c042aaf30f692b081ddd58bd9" }) -- Useful lua functions used by lots of plugins
	use({ "windwp/nvim-autopairs", commit = "45ae3122a4c7744db41298b41f9f5a3f092123e6" }) -- Autopairs, integrates with both cmp and treesitter
	use({ "numToStr/Comment.nvim", commit = "6821b3ae27a57f1f3cf8ed030e4a55d70d0c4e43" })
	use({ "JoosepAlviste/nvim-ts-context-commentstring", commit = "88343753dbe81c227a1c1fd2c8d764afb8d36269" })
	use({ "kyazdani42/nvim-web-devicons", commit = "8d2c5337f0a2d0a17de8e751876eeb192b32310e" })
	-- use({ "kyazdani42/nvim-tree.lua", commit = "bdb6d4a25410da35bbf7ce0dbdaa8d60432bc243" })
	use({ "nvim-tree/nvim-tree.lua", commit = "08a0aa1a3b7411ee0a7887c8818528b1558cef96" })
	use({ "akinsho/bufferline.nvim", commit = "c78b3ecf9539a719828bca82fc7ddb9b3ba0c353" })
	use({ "moll/vim-bbye", commit = "25ef93ac5a87526111f43e5110675032dbcacf56" })
	use({ "nvim-lualine/lualine.nvim", commit = "3362b28f917acc37538b1047f187ff1b5645ecdd" })
	use({ "akinsho/toggleterm.nvim", commit = "aaeed9e02167c5e8f00f25156895a6fd95403af8" })
	use({ "ahmedkhalf/project.nvim", commit = "541115e762764bc44d7d3bf501b6e367842d3d4f" })
	use({ "lewis6991/impatient.nvim", commit = "969f2c5c90457612c09cf2a13fee1adaa986d350" })
	use({ "lukas-reineke/indent-blankline.nvim", commit = "6177a59552e35dfb69e1493fd68194e673dc3ee2" })
	use({ "goolord/alpha-nvim", commit = "ef27a59e5b4d7b1c2fe1950da3fe5b1c5f3b4c94" })
	use("folke/which-key.nvim")
    use("nvim-telescope/telescope.nvim")	
    use("puremourning/vimspector")

	-- Colorschemes
	use({ "folke/tokyonight.nvim", commit = "8223c970677e4d88c9b6b6d81bda23daf11062bb" })
	use("lunarvim/darkplus.nvim")
    use("Mofiqul/dracula.nvim")
    use "EdenEast/nightfox.nvim"
    use("joshdick/onedark.vim")
    use("vimcolorschemes/vimcolorschemes")
-- git@github.com:vimcolorschemes/vimcolorschemes.git

    -- LSP
    use {
        'VonHeikemen/lsp-zero.nvim',
        requires = {
            -- LSP support
            {'neovim/nvim-lspconfig'},
            {'williamboman/mason.nvim'},
            {'williamboman/mason-lspconfig.nvim'},
        
            -- Autocompletion
            {"hrsh7th/nvim-cmp"},         -- The completion plugin
            {"hrsh7th/cmp-buffer"},       -- buffer completions
            {"hrsh7th/cmp-path"},         -- path completions
            {"saadparwaiz1/cmp_luasnip"}, -- snippet completions
            {"hrsh7th/cmp-nvim-lsp"},
            {"hrsh7th/cmp-nvim-lua"},

            -- Snippets
            {'L3MON4D3/LuaSnip'},
            {'rafamadriz/friendly-snippets'},
            {'SirVer/ultisnips'},
        }
    }

    use('lervag/vimtex')
    --[[ use('') ]]
    use('mbbill/undotree')

    -- DAP
    use("mfussenegger/nvim-dap")
    use("leoluz/nvim-dap-go")
    use("rcarriga/nvim-dap-ui")
    use("theHamsta/nvim-dap-virtual-text")
    use("nvim-telescope/telescope-dap.nvim")
    
    -- Jump files
    use("ThePrimeagen/harpoon")

    -- Git
    use("lewis6991/gitsigns.nvim")
    use("jose-elias-alvarez/null-ls.nvim") -- for formatters and linters
	use("nvim-treesitter/nvim-treesitter")
end)

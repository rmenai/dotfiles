local filetypes = {
	"asm",
	"bash",
	"c",
	"cmake",
	"dockerfile",
	"json",
	"lua",
	"make",
	"markdown",
	"nasm",
	"python",
	"regex",
	"latex",
	"ruby",
	"rust",
	"toml",
	"vim",
	"vimdoc",
	"yaml",
	"javascript",
	"typescript",
	"vue",
	"scss",
}

return {
	{
		-- TREESITTER
		"nvim-treesitter/nvim-treesitter",
		event = "BufRead",
    cmd = { "TSUpdate", "TSModuleInfo" },
		build = ":TSUpdate",
		config = function()
			require("nvim-treesitter.configs").setup({
				ensure_installed = filetypes,
				auto_install = true,
				highlight = { enable = true },
				rainbow = {
					enable = true,
					extended_mode = true,
					max_file_lines = nil,
				},
			})
		end,
	},
	{
		"lukas-reineke/indent-blankline.nvim",
		event = "BufRead",
    cmd = { "IBLToggle" },
		main = "ibl",
		config = function()
			require("ibl").setup()
		end,
	},
}

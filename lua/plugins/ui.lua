return {
	{
		-- THEME
		"catppuccin/nvim",
		name = "catppuccin",
		lazy = false,
		priority = 1000,
		config = function()
			require("catppuccin").setup({ transparent_background = true })
			vim.cmd.colorscheme("catppuccin")
		end,
	},
	{
		-- STATUS BAR
		"nvim-lualine/lualine.nvim",
		lazy = false,
		dependencies = {
			"nvim-tree/nvim-web-devicons",
			"linrongbin16/lsp-progress.nvim",
		},
		config = function()
			require("lsp-progress").setup({})
			require("lualine").setup({
				options = {
					globalstatus = true,
				},
				sections = {
					lualine_c = {
						function()
							return require("lsp-progress").progress()
						end,
					},
				},
			})

      -- Set up autocmds
      require("core.autocmds").lualine_autocmd()
		end,
	},
	{
		-- SHOW SMALL WINBAR
		"b0o/incline.nvim",
		lazy = false,
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			local helpers = require("incline.helpers")
			local devicons = require("nvim-web-devicons")

			require("incline").setup({
				window = {
					padding = 0,
					margin = { horizontal = 0, vertical = 0 },
				},
				render = function(props)
					local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ":t")
					if filename == "" then
						filename = "[No Name]"
					end
					local ft_icon, ft_color = devicons.get_icon_color(filename)
					local modified = vim.bo[props.buf].modified
					local res = {
						ft_icon and { " ", ft_icon, " ", guibg = ft_color, guifg = helpers.contrast_color(ft_color) }
							or "",
						" ",
						{ filename, gui = modified and "bold,italic" or "bold" },
						guibg = "#313244",
					}
					table.insert(res, " ")
					return res
				end,
			})
		end,
	},
	{
		-- UI IMPROVEMENTS
		"stevearc/dressing.nvim",
		lazy = false,
		config = function()
			require("dressing").setup({})
		end,
	},
	{
		-- DASHBOARD
		"goolord/alpha-nvim",
		cond = function()
			return vim.fn.argc() == 0
		end,
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			local theme = require("alpha.themes.startify")
			theme.mru_opts.autocd = true
			require("alpha").setup(theme.config)
		end,
	},

	-- WINDOWS & NAVIGATION
	{
		-- FILE SYSTEM TREE
		"nvim-tree/nvim-tree.lua",
    keys = { "<Leader>a", "<Leader>A" },
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			require("nvim-tree").setup({})

      -- Set up mappings
      require("core.mappings").map_nvim_tree()
		end,
	},
	{
		-- GIT VERSION CONTROL
		"NeogitOrg/neogit",
    keys = { "<Leader>nn", "<Leader>nc" },
		dependencies = {
			"nvim-lua/plenary.nvim",
			"sindrets/diffview.nvim",
			"nvim-telescope/telescope.nvim",
		},
		config = function()
			require("neogit").setup({})

      -- Set up mappings
      require("core.mappings").map_neogit()
		end,
	},
	{
		-- CODE STRUCTURE VIEW
		"hedyhli/outline.nvim",
    keys = { "<Leader>p" },
		config = function()
			require("outline").setup({})

      -- Set up mappings
      require("core.mappings").map_outline()
		end,
	},
	{
		-- TERMINAL
		"akinsho/toggleterm.nvim",
    keys = { "<Leader>t" },
		config = function()
			require("toggleterm").setup({
				on_create = function()
					vim.cmd([[ setlocal foldcolumn=1 ]])
				end,
			})

      -- Set up mappings
      require("core.mappings").map_term()
		end,
	},
	{
		-- SEARCH
		"nvim-telescope/telescope.nvim",
    keys = { "<Leader><space>", "<Leader>f", "<Leader>g", "<Leader>c" },
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-telescope/telescope-dap.nvim",
      "OliverChao/telescope-picker-list.nvim",
			{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
		},
		config = function()
			local telescope = require("telescope")
			local builtin = require("telescope.builtin")

			telescope.setup({
				defaults = {
					mappings = {
						i = {
							["<C-j>"] = builtin.move_selection_next,
							["<C-k>"] = builtin.move_selection_previous,
							["<C-q>"] = builtin.close,
						},
					},
					ignore_case = true,
					smart_case = false,
				},
				extensions = {
					fzf = {
						fuzzy = true,
						case_mode = "ignore_case",
					},
					picker_list = {
						user_pickers = {
              { "obsidian", require("core.commands").obsidian_picker },
              { "compiler", require("core.commands").compiler_picker },
            },
					},
				},
			})

			telescope.load_extension("fzf")
			telescope.load_extension("dap")
			telescope.load_extension("picker_list")

      -- Set up mappings
      require("core.mappings").map_telescope()
		end,
	},
}

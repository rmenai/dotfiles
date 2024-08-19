local obsidian_vault = { name = "notes", path = "~/Documents/Vaults/notes" }

return {
	-- LANGUAGES SUPPORT
	{
		-- LATEX
		"lervag/vimtex",
		ft = { "tex", "plaintex" },
		init = function()
			vim.g.vimtex_view_method = "sioyek"
			vim.g.vimtex_view_sioyek_exe = "sioyek.exe"
			vim.g.vimtex_callback_progpath = "wsl nvim"
		end,
	},
	{
		-- MARKDOWN PREVIEW
		"iamcco/markdown-preview.nvim",
		ft = { "markdown" },
		build = function()
			vim.fn["mkdp#util#install"]()
		end,
		init = function()
			vim.g.mkdp_auto_start = 0
		end,
	},
	{
		-- OBSIDIAN MARKDOWN
		"epwalsh/obsidian.nvim",
		keys = { "<Leader>oo", "<Leader>oc", "<Leader>oa", "<Leader>oA", "<Leader>ot", "<Leader>op" },
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			local utils = require("core.utils")

			local function generate_path(spec)
				local path = spec.dir / utils.slugify(spec.title)
				return path:with_suffix(".md")
			end

			-- Obsidian config
			local config_path = vim.fn.expand(obsidian_vault.path .. "/.obsidian/daily-notes.json")
			local config = { daily_notes = utils.read_json(config_path) }

			if not config then
				print("Failed to read daily-notes.json")
			end

			require("obsidian").setup({
				workspaces = { obsidian_vault },
				disable_frontmatter = true,
				templates = {
					folder = "templates",
					substitutions = {
						["date:ddd, D MMM, YYYY"] = os.date("%a, %d %b, %Y"),
					},
				},
				daily_notes = {
					folder = config.daily_notes.folder,
					template = config.daily_notes.template:match("([^/]+)$"),
				},

				note_path_func = generate_path,
				wiki_link_func = require("obsidian.util").wiki_link_path_prefix,
			})

			-- Set up mappings
			require("core.mappings").map_obsidian()
		end,
	},
	{
		-- CMAKE
		"Civitasv/cmake-tools.nvim",
		cmd = { "CMakeGenerate", "CMakeBuild", "CMakeClean", "CMakeRun" },
		config = function()
			require("cmake-tools").setup({
				cmake_virtual_text_support = false,
				cmake_runner = {
					name = "overseer",
					opts = {
						new_task_opts = {
							strategy = {
								"toggleterm",
								direction = "horizontal",
								auto_scroll = true,
								quit_on_exit = "never",
								on_create = function()
									-- Move text by one column
									vim.cmd([[ setlocal foldcolumn=1 ]])
								end,
							},
						},
					},
				},
			})
		end,
	},
	{
		"stevearc/overseer.nvim",
		keys = { "<F9>", "<F10>" },
		config = function()
			require("overseer").setup({
				templates = { "builtin", "custom" },
				strategy = {
					"toggleterm",
					direction = "horizontal",
					auto_scroll = true,
					on_create = function()
						-- Move text by one column
						vim.cmd([[ setlocal foldcolumn=1 ]])
					end,
				},
			})

			-- Set up mappings
			require("core.mappings").map_compiler()
		end,
	},
	{
		"michaelb/sniprun",
		branch = "master",
		build = "sh install.sh",
		cmd = "SnipRun",
		config = function()
			require("sniprun").setup({
				repl_enable = {
					"Python3_original",
					"Bash_original",
					"Lua_nvim",
					"OCaml_fifo",
				},
			})
		end,
	},

	{
		-- GITHUB COPILOT INTEGRATION
		"CopilotC-Nvim/CopilotChat.nvim",
		cmd = { "Copilot", "CopilotChat" },
		dependencies = {
			"zbirenbaum/copilot.lua",
			"nvim-lua/plenary.nvim",
		},
		config = function()
			require("CopilotChat").setup({})
		end,
	},

	{
		-- AUTOMATIC PAIRS
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		config = function()
			require("nvim-autopairs").setup({})

			-- Set up cmp
			local cmp_autopairs = require("nvim-autopairs.completion.cmp")
			local cmp = require("cmp")

			cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
		end,
	},
	{
		"windwp/nvim-ts-autotag",
		ft = { "html", "css", "vue", "javascript", "typescript" },
		event = { "InsertEnter" },
		config = function()
			require("nvim-ts-autotag").setup({
				opts = {
					enable_close_on_slash = true,
				},
			})
		end,
	},
	{
		-- EASIER COMMENTING
		"terrortylor/nvim-comment",
		keys = { "gc", "gcc", "gbc" },
		config = function()
			require("nvim_comment").setup({
				create_mappings = true,
			})
		end,
	},
	{
		-- COLOR PREVIEW
		"norcalli/nvim-colorizer.lua",
		ft = { "css", "html", "javascript", "typescript", "vue" },
		config = function()
			require("colorizer").setup({
				user_default_options = {
					RGB = true,
					RRGGBB = true,
					RRGGBBAA = true,
					names = true,
					rgb_fn = true,
					hsl_fn = true,
					css = true,
					css_fn = true,
					tailwind = true,
				},
			})
		end,
	},
	{
		-- BETTER ESCAPE INSERT
		"TheBlob42/houdini.nvim",
		event = { "ModeChanged" },
		config = function()
			require("houdini").setup({
				mappings = { "jj", "jk" },
				timeout = 200,
				escape_sequences = {
					["v"] = false,
					["vs"] = false,
					["V"] = false,
					["Vs"] = false,
					["no"] = false,
					["nov"] = false,
					["noV"] = false,
				},
			})
		end,
	},
}

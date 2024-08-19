local filetypes = {
	"asm",
	"sh",
	"c",
	"cpp",
	"json",
	"lua",
	"markdown",
	"cmake",
	"python",
	"tex",
	"yaml",
	"javascript",
	"typescript",
	"vue",
	"html",
	"css",
	"ocaml",
	"ocamlinterface",
	"ocamllex",
}

return {
	{
		"VonHeikemen/lsp-zero.nvim",
		ft = filetypes,
		init = function()
			vim.g.lsp_zero_extend_cmp = 0
			vim.g.lsp_zero_extend_lspconfig = 0
		end,
	},
	{
		"williamboman/mason.nvim",
		cmd = { "Mason", "MasonInstall", "MasonUpdate" },
		dependencies = { "WhoIsSethDaniel/mason-tool-installer.nvim" },
		config = function()
			require("mason").setup({})
			require("mason-tool-installer").setup({
				ensure_installed = {
					-- LSP
					"asm-lsp",
					"bash-language-server",
					"clangd",
					"cmake-language-server",
					"json-lsp",
					"lua-language-server",
					"marksman",
					"python-lsp-server",
					"texlab",
					"yaml-language-server",
					"typescript-language-server",
					"vue-language-server",
					"tailwindcss-language-server",

					-- LINTERS
					"prettier",
					"stylua",
					"isort",
					"black",
					"clang-format",
					"asmfmt",
					"eslint_d",
					"stylelint",
					"htmlhint",
					"jsonlint",
					"yamllint",
					"markdownlint",
					"pylint",
					"cpplint",

					-- DAP
					"debugpy",
					"cpptools",
				},
			})
		end,
	},

	-- Autocompletion
	{
		"hrsh7th/nvim-cmp",
		event = "InsertEnter",
		dependencies = {
			"VonHeikemen/lsp-zero.nvim",
			"L3MON4D3/LuaSnip",
			"rcarriga/cmp-dap",
			"onsails/lspkind.nvim",
		},
		config = function()
			local lsp_zero = require("lsp-zero")
			lsp_zero.extend_cmp()

			local luasnip = require("luasnip")
			local cmp = require("cmp")
			local cmp_dap = require("cmp_dap")

			local function select_next(fallback)
				if cmp.visible() then
					cmp.select_next_item()
				elseif luasnip.locally_jumpable(1) then
					luasnip.jump(1)
				else
					fallback()
				end
			end

			local function select_prev(fallback)
				if cmp.visible() then
					cmp.select_prev_item()
				elseif luasnip.locally_jumpable(-1) then
					luasnip.jump(-1)
				else
					fallback()
				end
			end

			local function confirm_select(fallback)
				if cmp.visible() then
					if luasnip.expandable() then
						luasnip.expand()
					else
						cmp.confirm({ select = true })
					end
				else
					fallback()
				end
			end

			cmp.setup({
				formatting = {
					-- fields = { "abbr", "kind", "menu" },
					format = require("lspkind").cmp_format({
						-- mode = "symbol",
						-- maxwidth = 50,
						-- ellipsis_char = "...",
						--
						before = require("tailwind-tools.cmp").lspkind_format,
					}),
				},
				enabled = function()
					return vim.api.nvim_buf_get_option(0, "buftype") ~= "prompt" or cmp_dap.is_dap_buffer()
				end,
				mapping = cmp.mapping.preset.insert({
					["<C-k>"] = cmp.mapping.scroll_docs(-4),
					["<C-j>"] = cmp.mapping.scroll_docs(4),
					["<CR>"] = cmp.mapping(confirm_select),
					["<Tab>"] = cmp.mapping(select_next, { "i", "s" }),
					["<S-Tab>"] = cmp.mapping(select_prev, { "i", "s" }),
				}),
				sources = cmp.config.sources({
					{ name = "nvim_lsp" },
					{ name = "luasnip" },
				}),
				snippet = {
					expand = function(args)
						luasnip.lsp_expand(args.body)
					end,
				},
			})

			cmp.setup.filetype({ "dap-repl", "dapui_watches", "dapui_hover" }, {
				sources = {
					{ name = "dap" },
				},
			})
		end,
	},

	-- LSP
	{
		"neovim/nvim-lspconfig",
		ft = filetypes,
		cmd = { "LSPStart", "LSPStop", "LSPRestart", "LSPInfo", "LSPLog" },
		dependencies = {
			"VonHeikemen/lsp-zero.nvim",
			"hrsh7th/cmp-nvim-lsp",
			"williamboman/mason-lspconfig.nvim",
		},
		config = function()
			local lsp_zero = require("lsp-zero")
			lsp_zero.extend_lspconfig()

			require("mason-lspconfig").setup({
				handlers = {
					function(server_name)
						require("lspconfig")[server_name].setup({})
					end,
					["lua_ls"] = function()
						require("lspconfig").lua_ls.setup({
							on_init = function(client)
								local path = client.workspace_folders[1].name
								if
									vim.loop.fs_stat(path .. "/.luarc.json")
									or vim.loop.fs_stat(path .. "/.luarc.jsonc")
								then
									return
								end

								client.config.settings.Lua = vim.tbl_deep_extend("force", client.config.settings.Lua, {
									runtime = {
										version = "LuaJIT",
									},
									workspace = {
										checkThirdParty = false,
										library = vim.env.VIMRUNTIME,
									},
								})
							end,
							settings = {
								Lua = {
									diagnostics = {
										globals = { "vim" },
									},
								},
							},
						})
					end,
					["volar"] = function()
						require("lspconfig").volar.setup({
							filetypes = { "typescript", "javascript", "vue" },
							init_options = {
								vue = { hybridMode = false },
							},
						})
					end,
					-- ["tsserver"] = function()
					-- 	local mason_registry = require("mason-registry")
					-- 	local volar_path = mason_registry.get_package("vue-language-server"):get_install_path()
					--
					-- 	require("lspconfig").tsserver.setup({
					-- 		init_options = {
					-- 			plugins = {
					-- 				{
					-- 					name = "@vue/typescript-plugin",
					-- 					location = volar_path,
					-- 					languages = { "vue" },
					-- 				},
					-- 			},
					-- 		},
					-- 		filetypes = { "javascript", "typescript", "vue" },
					-- 	})
					-- end,
					["marksman"] = function()
						require("lspconfig").marksman.setup({
							on_attach = function()
								-- Disable diagnostics for marksman
								vim.lsp.handlers["textDocument/publishDiagnostics"] = function() end
							end,
						})
					end,
				},
			})

			-- Set up manually installed lsp
			require("lspconfig").ocamllsp.setup({})

			-- Set up mappings
			require("core.mappings").map_lsp()
		end,
	},

	-- LANGUAGE SPECIFIC
	{
		"luckasRanarison/tailwind-tools.nvim",
		name = "tailwind-tools",
		build = ":UpdateRemotePlugins",
		ft = { "html", "css", "vue", "typescript", "javascript" },
		cmd = { "TailwindSort", "TailwindColorToggle", "TailwindConcealToggle" },
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
			"nvim-telescope/telescope.nvim",
		},
		config = function()
			require("tailwind-tools").setup({
				document_color = {
					enabled = true,
					kind = "background",
					debounce = 0,
				},
			})
		end,
	},
}

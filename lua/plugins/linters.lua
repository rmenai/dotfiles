-- local filetypes = {
-- 	"javascript",
-- 	"typescript",
-- 	"vue",
-- 	"css",
-- 	"html",
-- 	"json",
-- 	"yaml",
-- 	"markdown",
-- 	"lua",
-- 	"python",
-- 	"c",
-- 	"cpp",
-- 	"assembly",
-- }
--
return {
  {
    "stevearc/conform.nvim",
    event = "BufWritePre",
    keys = { "<F4>" },
    cmd = { "ConformInfo" },
    config = function()
      require("conform").setup({
        formatters_by_ft = {
          javascript = { "prettier" },
          typescript = { "prettier" },
          vue = { "prettier" },
          css = { "prettier" },
          html = { "prettier" },
          json = { "prettier" },
          yaml = { "prettier" },
          markdown = { "prettier" },
          lua = { "stylua" },
          python = { "isort", "black" },
          c = { "clang-format" },
          cpp = { "clang-format" },
          assembly = { "asmfmt" },
        },
        default_format_opts = {
          lsp_format = "fallback",
          async = true,
        },
      })

      -- Set up mappings
      require("core.mappings").map_formatter()
    end,
  },
  -- {
  -- 	"mfussenegger/nvim-lint",
  -- 	ft = filetypes,
  -- 	config = function()
  -- 		require("lint").linters_by_ft = {
  -- 			javascript = { "eslint_d" },
  -- 			typescript = { "eslint_d" },
  -- 			vue = { "eslint_d" },
  -- 			python = { "pylint" },
  -- 			c = { "cpplint" },
  -- 			cpp = { "cpplint" },
  --
  -- 			css = { "stylelint" },
  -- 			html = { "htmlhint" },
  -- 			json = { "jsonlint" },
  -- 			yaml = { "yamllint" },
  -- 			markdown = { "markdownlint" },
  -- 		}
  --
  --      -- Set up mappings
  --      require("core.mappings").map_linter()
  --      require("core.autocmds").linter_autocmd()
  -- 	end,
  -- },
}

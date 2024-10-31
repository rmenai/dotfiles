return {
  {
    "stevearc/conform.nvim",
    event = "BufWritePre",
    keys = "<F4>",
    cmd = "ConformInfo",
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
          bash = { "shfmt" },
          sh = { "shfmt" },
          lua = { "stylua" },
          python = { "isort", "black" },
          c = { "clang-format" },
          cpp = { "clang-format" },
          assembly = { "asmfmt" },
          ocaml = { "ocamlformat" },
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
}

return {
  {
    "stevearc/conform.nvim",
    event = "BufWritePre",
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
          bash = { "shellharden" },
          zsh = { "shellharden" },
          sh = { "shellharden" },
          lua = { "stylua" },
          nix = { "alejandra" },
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
        format_on_save = {
          timeout_ms = 500,
          lsp_format = "fallback",
        },
      })
    end,
  },
}

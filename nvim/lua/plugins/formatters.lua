return {
  {
    "stevearc/conform.nvim",
    event = "BufWritePre",
    cmd = "ConformInfo",
    config = function()
      require("conform").setup({
        formatters_by_ft = {
          yaml = { "prettier" },
          markdown = { "markdownlint" },
          bash = { "shellharden" },
          zsh = { "shellharden" },
          sh = { "shellharden" },
          lua = { "stylua" },
          nix = { "alejandra" },
          python = {
            "ruff_fix",
            "ruff_format",
            "ruff_organize_imports",
          },
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

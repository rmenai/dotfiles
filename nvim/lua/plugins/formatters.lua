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
          -- bash = { "shellharden" },
          -- zsh = { "shellharden" },
          -- sh = { "shellharden" },
          nu = { "nufmt" },
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
          tex = { "tex-fmt" },
        },
        default_format_opts = {
          lsp_format = "fallback",
          async = true,
        },
        format_on_save = function(bufnr)
          -- Disable with a global or buffer-local variable
          if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then return end
          return { timeout_ms = 500, lsp_format = "fallback" }
        end,
      })
    end,
  },
}

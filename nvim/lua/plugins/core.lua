return {
  {
    "catppuccin",
    opts = {
      transparent_background = true,
    },
  },

  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "catppuccin",
    },
  },

  {
    "neovim/nvim-lspconfig",
    opts = {
      inlay_hints = { enabled = false },
      diagnostics = { virtual_text = false },

      servers = {
        ocamllsp = {
          cmd = { "opam", "exec", "--", "ocamllsp", "--stdio" },
        },
      },
    },
  },
}

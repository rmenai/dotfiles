return {
  {
    "neovim/nvim-lspconfig",
    ---@class PluginLspOpts
    opts = {
      servers = {
        ocamllsp = { mason = false },
        clangd = { mason = false },
        ruff = { mason = false },
        ty = { mason = false },
      },
    },
  },
}

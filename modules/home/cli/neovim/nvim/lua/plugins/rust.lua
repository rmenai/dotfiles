vim.g.rustaceanvim = {
  tools = {
    executor = {
      execute_command = function(command, args, cwd, opts)
        local overseer = require("overseer")

        local task_name = command
        if args[1] then task_name = task_name .. " " .. args[1] end

        for i, arg in ipairs(args) do
          if arg == "--package" or arg == "-p" or arg == "--bin" or arg == "--example" then
            if args[i + 1] then
              task_name = task_name .. " " .. args[i + 1]
              break -- Stop after finding the main target to keep it short
            end
          end
        end

        local task = overseer.new_task({
          cmd = command,
          args = args,
          cwd = cwd,
          env = opts.env,
          name = task_name,
          components = {
            "default",
          },
        })
        task:start()
      end,
    },
  },
}

return {
  {
    "mrcjkb/rustaceanvim",
    opts = {
      server = {
        on_attach = function(_, bufnr)
          local map = function(keys, func, desc) vim.keymap.set("n", keys, func, { desc = desc, buffer = bufnr }) end

          map("<leader>rr", function() vim.cmd.RustLsp("runnables") end, "Run List (Rust)")
          map("<leader>rR", function() vim.cmd.OverseerRun() end, "Run (Overseer)")
          map("<leader>rn", function() vim.cmd.RustLsp("run") end, "Run Nearest (Rust)")
          map("<leader>rL", function() vim.cmd.RustLsp({ "runnables", bang = true }) end, "Run Last (Rust)")
          map("<leader>tR", function() vim.cmd.RustLsp("testables") end, "Test List (Rust)")
          map("<leader>dR", function() vim.cmd.RustLsp("debuggables") end, "Debug List (Rust)")
          map("<leader>dn", function() vim.cmd.RustLsp("debug") end, "Debug Nearest (Rust)")
          map("<leader>dL", function() vim.cmd.RustLsp({ "debuggables", bang = true }) end, "Debug Last (Rust)")
          map("<leader>cm", function() vim.cmd.RustLsp("expandMacro") end, "Expand Macro (Rust)")
          map("<leader>cM", function() vim.cmd.RustLsp("rebuildProcMacros") end, "Rebuild Proc Macros (Rust)")
          map("<leader>cp", function() vim.cmd.RustLsp("parentModule") end, "Parent Module (Rust)")
          map("<leader>ck", function() vim.cmd.RustLsp("moveItem", "up") end, "Move Item Up (Rust)")
          map("<leader>cj", function() vim.cmd.RustLsp("moveItem", "down") end, "Move Item Down (Rust)")
          map("<leader>ce", function() vim.cmd.RustLsp("explainError") end, "Explain Error (Rust)")
          map("<leader>cd", function() vim.cmd.RustLsp("renderDiagnostic") end, "Render Diagnostic (Rust)")
          map("<leader>ch", function() vim.cmd.RustLsp({ "view", "hir" }) end, "View HIR (Rust)")
          map("<leader>co", function() vim.cmd.RustLsp("openDocs") end, "Open Docs.rs (Rust)")
          map("<leader>cO", function() vim.cmd.RustLsp("openCargo") end, "Open Cargo.toml (Rust)")
        end,
      },
    },
  },

  {
    "Saecki/crates.nvim",
    event = { "BufRead Cargo.toml" },
    opts = {
      completion = {
        crates = {
          enabled = true,
        },
      },
      lsp = {
        enabled = true,
        actions = true,
        completion = true,
        hover = true,
      },
    },
    keys = {
      { "<leader>cgt", function() require("crates").toggle() end, desc = "Toggle crate info" },
      { "<leader>cgr", function() require("crates").reload() end, desc = "Reload crate info" },
      { "<leader>cgv", function() require("crates").show_versions_popup() end, desc = "Show crate versions" },
      { "<leader>cgf", function() require("crates").show_features_popup() end, desc = "Show crate features" },
      { "<leader>cgd", function() require("crates").show_dependencies_popup() end, desc = "Show crate dependencies" },
      { "<leader>cgu", function() require("crates").update_crate() end, desc = "Update crate" },
      { "<leader>cgu", function() require("crates").update_crates() end, mode = "v", desc = "Update selected crates" },
      { "<leader>cga", function() require("crates").update_all_crates() end, desc = "Update all crates" },
      { "<leader>cgU", function() require("crates").upgrade_crate() end, desc = "Upgrade crate" },
      { "<leader>cgU", function() require("crates").upgrade_crates() end, mode = "v", desc = "Upgrade selected crates" },
      { "<leader>cgA", function() require("crates").upgrade_all_crates() end, desc = "Upgrade all crates" },
      { "<leader>cgx", function() require("crates").expand_plain_crate_to_inline_table() end, desc = "Expand crate to inline table" },
      { "<leader>cgX", function() require("crates").extract_crate_into_table() end, desc = "Extract crate into table" },
      { "<leader>cgo", function() require("crates").open_crates_io() end, desc = "Open crates.io" },
    },
  },
}

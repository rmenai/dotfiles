local M = {}

M.patch_runnables = function()
  local config = require("rustaceanvim.config.internal")

  local function get_params()
    return {
      textDocument = vim.lsp.util.make_text_document_params(0),
      position = nil, -- get em all
    }
  end

  local function is_testable(runnable)
    local cargoArgs = runnable.args and runnable.args.cargoArgs or {}
    return #cargoArgs > 0 and vim.startswith(cargoArgs[1], "test")
  end

  local function prettify_test_option(option)
    for _, prefix in pairs({ "test-mod ", "test ", "cargo test -p " }) do
      if vim.startswith(option, prefix) then return option:sub(prefix:len() + 1, option:len()):gsub("%-%-all%-targets", "(all targets)") or option end
    end
    return option:gsub("%-%-all%-targets", "(all targets)") or option
  end

  local function get_options(result, executableArgsOverride, opts)
    local option_strings = {}

    for _, runnable in ipairs(result) do
      local str = runnable.label .. (executableArgsOverride and #executableArgsOverride > 0 and " -- " .. table.concat(executableArgsOverride, " ") or "")
      if opts.tests_only then str = prettify_test_option(str) end
      if config.tools.cargo_override then str = str:gsub("^cargo", config.tools.cargo_override) end
      table.insert(option_strings, str)
    end

    return option_strings
  end

  local function patched_mk_handler(executableArgsOverride, opts)
    return function(_, runnables)
      local _, _ = pcall(function()
        -- Modified part
        table.insert(runnables, {
          args = {
            cargoArgs = { "watch", "-q", "-c", "-w", "src/", "-x", "'run -q'" },
            cwd = vim.loop.cwd(),
            executableArgs = {},
            workspaceRoot = vim.loop.cwd(),
          },
          kind = "cargo",
          label = "cargo watch",
        })
        -- End

        runnables = require("rustaceanvim.runnables").apply_exec_args_override(executableArgsOverride, runnables)
        if opts.tests_only then runnables = vim.tbl_filter(is_testable, runnables) end

        local options = get_options(runnables, executableArgsOverride, opts)
        vim.ui.select(options, { prompt = "Runnables", kind = "rust-tools/runnables" }, function(_, choice)
          require("rustaceanvim.runnables").run_command(choice, runnables)

          local cached_commands = require("rustaceanvim.cached_commands")
          if opts.tests_only then
            cached_commands.set_last_testable(choice, runnables)
          else
            cached_commands.set_last_runnable(choice, runnables)
          end
        end)
      end)
    end
  end

  require("rustaceanvim.runnables").runnables = function(executableArgsOverride, opts)
    opts = vim.tbl_deep_extend("force", { tests_only = false }, opts or {})
    vim.lsp.buf_request(0, "experimental/runnables", get_params(), patched_mk_handler(executableArgsOverride, opts))
  end
end

M.patch_toggleterm = function()
  require("rustaceanvim.executors").toggleterm = {
    execute_command = function(command, args, cwd, opts)
      local ok, term = pcall(require, "toggleterm.terminal")
      if not ok then
        vim.schedule(function() vim.notify("toggleterm not found.", vim.log.levels.ERROR) end)
        return
      end

      local shell = require("rustaceanvim.shell")
      term.Terminal
        :new({
          dir = cwd,
          env = opts.env,
          cmd = shell.make_command_from_args(command, args),
          close_on_exit = false,
        })
        :toggle()
    end,
  }
end

return M

local M = {}

local function is_rust_project() return vim.fn.glob("./Cargo.toml") ~= "" or vim.fn.expand("%:e") == "rs" end

local function CompilerChoose()
  local filetype = vim.api.nvim_get_option_value("filetype", { buf = 0 })
  if filetype == "NvimTree" then vim.cmd("wincmd l") end

  local telescope = require("telescope.builtin")
  local overseer = require("overseer")

  if vim.fn.expand("%:e") == "tex" then
    telescope.commands({ default_text = "Vimtex" })
    return
  end

  if vim.fn.expand("%:e") == "typ" then
    M.typst_picker()
    return
  end

  if vim.startswith(vim.fn.getcwd(), vim.fn.stdpath("data") .. "/leetcode") then
    M.leetcode_picker()
    return
  end

  if is_rust_project() then
    vim.cmd.RustLsp("runnables")
    return
  end

  overseer.run_template()
end

local function CompilerRun()
  local filetype = vim.api.nvim_buf_get_option(0, "filetype")
  if filetype == "NvimTree" then vim.cmd("wincmd l") end

  local action_util = require("overseer.action_util")
  local task_list = require("overseer.task_list")

  local tasks = task_list.list_tasks({ recent_first = true })
  if #tasks == 0 then
    if vim.startswith(vim.fn.getcwd(), vim.fn.stdpath("data") .. "/leetcode") then
      vim.cmd.LeetRun()
      return
    end

    if vim.fn.expand("%:e") == "tex" then
      vim.cmd.VimtexCompile()
      return
    end

    if vim.fn.expand("%:e") == "typ" then
      vim.cmd("!xdg-open " .. vim.fn.expand("%:r") .. ".pdf &")
      return
    end

    if is_rust_project() then
      vim.cmd.RustLsp({ "runnables", bang = true })
      return
    end

    CompilerChoose()
    return
  end

  action_util.run_task_action(tasks[1], "restart")
end

local function WastePaste(opts)
  local content

  -- Get the content to paste
  local lstart1 = opts.line1
  local lstart2 = opts.line2

  if not (lstart1 == lstart2) then
    -- Visual mode - get selected text
    local start_pos = vim.fn.getpos("'<")
    local end_pos = vim.fn.getpos("'>")
    local lines = vim.fn.getline(start_pos[2], end_pos[2])

    for i, line in ipairs(lines) do
      lines[i] = string.sub(line, start_pos[3], end_pos[3])
    end

    content = table.concat(lines, "\n")
  else
    -- Normal mode - get whole file
    local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
    content = table.concat(lines, "\n")
  end

  -- Get file extension
  local extension = vim.fn.expand("%:e")
  if extension == "" then
    extension = "" -- default extension
  end

  -- Default options
  local options = {
    extension = extension,
    expires = 604800, -- 1 week in seconds
    title = "",
    burn = false,
    password = "",
  }

  -- Function to create the paste
  local function create_paste(text, opts)
    -- Build command
    local cmd = { "bin" }

    if opts.extension and opts.extension ~= "" then
      table.insert(cmd, "--extension")
      table.insert(cmd, opts.extension)
    end

    if opts.title and opts.title ~= "" then
      table.insert(cmd, "--title")
      table.insert(cmd, opts.title)
    end

    if opts.expires then
      table.insert(cmd, "--expires")
      table.insert(cmd, tostring(opts.expires))
    end

    if opts.burn then table.insert(cmd, "--burn") end

    if opts.password and opts.password ~= "" then
      table.insert(cmd, "--password")
      table.insert(cmd, opts.password)
    end

    -- Execute command
    vim.system(cmd, { stdin = text, text = true }, function(result)
      vim.schedule(function()
        if result.code == 0 then
          if result.stdout then vim.notify(result.stdout) end
        end
      end)
    end)
  end

  -- Show options UI
  local function show_options_ui()
    local choices = {
      "1. Create paste",
      "2. Cancel",
      "",
      "3. Extension: " .. options.extension,
      "4. Expiration: " .. (options.expires == 604800 and "1 week" or options.expires .. " seconds"),
      "5. Title: " .. (options.title == "" and "(none)" or options.title),
      "6. Burn after reading: " .. (options.burn and "yes" or "no"),
      "7. Password: " .. (options.password == "" and "(none)" or "***"),
    }

    vim.ui.select(choices, {
      prompt = "WastePaste Options:",
      format_item = function(item) return item end,
    }, function(choice, idx)
      if not choice then return end

      if idx == 4 then
        vim.ui.input({ prompt = "Extension: ", default = options.extension }, function(input)
          if input then
            options.extension = input
            show_options_ui()
          end
        end)
      elseif idx == 5 then
        local exp_choices = {
          "1 hour (3600)",
          "1 day (86400)",
          "1 week (604800)",
          "1 month (2592000)",
          "Custom...",
        }
        vim.ui.select(exp_choices, { prompt = "Expiration:" }, function(exp_choice, exp_idx)
          if not exp_choice then
            show_options_ui()
            return
          end

          if exp_idx == 1 then
            options.expires = 3600
          elseif exp_idx == 2 then
            options.expires = 86400
          elseif exp_idx == 3 then
            options.expires = 604800
          elseif exp_idx == 4 then
            options.expires = 2592000
          elseif exp_idx == 5 then
            vim.ui.input({ prompt = "Expiration (seconds): " }, function(input)
              if input and tonumber(input) then options.expires = tonumber(input) end
              show_options_ui()
            end)
            return
          end
          show_options_ui()
        end)
      elseif idx == 6 then
        vim.ui.input({ prompt = "Title: ", default = options.title }, function(input)
          if input then
            options.title = input
            show_options_ui()
          end
        end)
      elseif idx == 7 then
        options.burn = not options.burn
        show_options_ui()
      elseif idx == 8 then
        vim.ui.input({ prompt = "Password: ", default = options.password }, function(input)
          if input then
            options.password = input
            show_options_ui()
          end
        end)
      elseif idx == 1 then
        create_paste(content, options)
      elseif idx == 2 then
        return
      end
    end)
  end

  -- Start the UI flow
  show_options_ui()
end

vim.api.nvim_create_user_command("WastePaste", WastePaste, { range = true })

-- Custom pickers
M.leetcode_picker = function() require("telescope.builtin").commands({ default_text = "Leet" }) end

M.compiler_picker = function() vim.cmd("CompilerRun") end

M.gitsigns_picker = function() vim.cmd("Gitsigns") end

M.games_picker = function()
  local actions = require("telescope.actions")
  local action_state = require("telescope.actions.state")
  local pickers = require("telescope.pickers")
  local finders = require("telescope.finders")
  local conf = require("telescope.config").values

  pickers
    .new({}, {
      prompt_title = "Choose a Game",
      finder = finders.new_table({
        results = {
          { "Speed Typer", "Speedtyper" },
          { "Vim Be Good", "VimBeGood" },
          { "Game of Life", "CellularAutomaton game_of_life" },
          { "Scramble", "CellularAutomaton scramble" },
          { "Make it Rain", "CellularAutomaton make_it_rain" },
          { "Sudoku", "Sudoku" },
          { "LeetCode", "Leet" },
        },
        entry_maker = function(entry)
          return {
            value = entry[2],
            display = entry[1],
            ordinal = entry[1],
          }
        end,
      }),
      sorter = conf.generic_sorter({}),
      attach_mappings = function(_, map)
        map("i", "<CR>", function(bufnr)
          actions.close(bufnr)
          local selection = action_state.get_selected_entry()
          vim.cmd(selection.value)
        end)
        return true
      end,
    })
    :find()
end

M.copilot_picker = function()
  local actions = require("telescope.actions")
  local action_state = require("telescope.actions.state")
  local pickers = require("telescope.pickers")
  local finders = require("telescope.finders")
  local conf = require("telescope.config").values

  local commands = {
    "CopilotChat",
    "CopilotChatFix",
    "CopilotChatDocs",
    "CopilotChatLoad",
    "CopilotChatOpen",
    "CopilotChatSave",
    "CopilotChatStop",
    "CopilotChatClose",
    "CopilotChatReset",
    "CopilotChatTests",
    "CopilotChatAgents",
    "CopilotChatCommit",
    "CopilotChatModels",
    "CopilotChatReview",
    "CopilotChatToggle",
    "CopilotChatExplain",
    "CopilotChatPrompts",
    "CopilotChatOptimize",
  }

  local results = {}
  for _, cmd in ipairs(commands) do
    table.insert(results, { cmd, cmd })
  end

  pickers
    .new({}, {
      prompt_title = "Copilot Chat Commands",
      finder = finders.new_table({
        results = results,
        entry_maker = function(entry)
          return {
            value = entry[2],
            display = entry[1],
            ordinal = entry[1],
          }
        end,
      }),
      sorter = conf.generic_sorter({}),
      attach_mappings = function(_, map)
        map("i", "<CR>", function(bufnr)
          actions.close(bufnr)
          local selection = action_state.get_selected_entry()
          vim.cmd(selection.value)
        end)
        return true
      end,
    })
    :find()
end

M.typst_picker = function()
  local actions = require("telescope.actions")
  local action_state = require("telescope.actions.state")
  local pickers = require("telescope.pickers")
  local finders = require("telescope.finders")
  local conf = require("telescope.config").values

  pickers
    .new({}, {
      prompt_title = "Typst Actions",
      finder = finders.new_table({
        results = {
          { "Open PDF", "!xdg-open " .. vim.fn.expand("%:r") .. ".pdf &" },
          { "Preview typst file", "TypstPreview" },
        },
        entry_maker = function(entry)
          return {
            value = entry[2],
            display = entry[1],
            ordinal = entry[1],
          }
        end,
      }),
      sorter = conf.generic_sorter({}),
      attach_mappings = function(_, map)
        map("i", "<CR>", function(bufnr)
          local selection = action_state.get_selected_entry(bufnr)
          actions.close(bufnr)
          vim.cmd(selection.value)
        end)
        return true
      end,
    })
    :find()
end

return M

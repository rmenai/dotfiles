local M = {}

local function CommitCurrentFile()
  local file_path = vim.fn.expand("%:p") -- Get the full path of the current file
  if file_path == "" then
    print("No file is currently open")
    return
  end

  local commit_message = "Update " .. vim.fn.expand("%:t")

  vim.cmd("w") -- Save current file
  vim.cmd("!git add " .. file_path)
  vim.cmd("!git commit -m '" .. commit_message .. "' " .. file_path)
end

local function is_rust_project() return vim.fn.glob("./Cargo.toml") ~= "" or vim.fn.expand("%:e") == "rs" end

local function CompilerChoose()
  local filetype = vim.api.nvim_buf_get_option(0, "filetype")
  if filetype == "NvimTree" then vim.cmd("wincmd l") end

  local telescope = require("telescope.builtin")
  local overseer = require("overseer")

  if vim.fn.expand("%:e") == "tex" then
    telescope.commands({ default_text = "Vimtex" })
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

    if is_rust_project() then
      vim.cmd.RustLsp({ "runnables", bang = true })
      return
    end

    CompilerChoose()
    return
  end

  action_util.run_task_action(tasks[1], "restart")
end

-- Custom pickers
M.leetcode_picker = function() require("telescope.builtin").commands({ default_text = "Leet" }) end

M.compiler_picker = function() vim.cmd("CompilerRun") end

M.gitsigns_picker = function() vim.cmd("Gitsigns") end

M.notify_picker = function() vim.cmd("Telescope notify") end

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
          local selection = action_state.get_selected_entry(bufnr)
          actions.close(bufnr)
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
          local selection = action_state.get_selected_entry(bufnr)
          actions.close(bufnr)
          vim.cmd(selection.value)
        end)
        return true
      end,
    })
    :find()
end

M.setup_leetcode_cmds = function()
  local leet_cmds = require("leetcode.command").commands

  local commands = {
    { name = "LeetMenu", cmd = leet_cmds.menu[1], desc = "Open the LeetCode menu" },
    { name = "LeetExit", cmd = leet_cmds.exit[1], desc = "Exit LeetCode.nvim" },
    { name = "LeetConsole", cmd = leet_cmds.console[1], desc = "Open console for the current question" },
    {
      name = "LeetInfo",
      cmd = leet_cmds.info[1],
      desc = "Show information for the current question",
    },
    { name = "LeetHints", cmd = leet_cmds.hints[1], desc = "Show hints for the current question" },
    { name = "LeetTabs", cmd = leet_cmds.tabs[1], desc = "Open tabs for all current questions" },
    {
      name = "LeetLang",
      cmd = leet_cmds.lang[1],
      desc = "Change language for the current question",
    },
    { name = "LeetRun", cmd = leet_cmds.run[1], desc = "Run the current question" },
    { name = "LeetTest", cmd = leet_cmds.test[1], desc = "Test the current question (same as Run)" },
    { name = "LeetSubmit", cmd = leet_cmds.submit[1], desc = "Submit the current question" },
    { name = "LeetDaily", cmd = leet_cmds.daily[1], desc = "Open today's daily question" },
    { name = "LeetYank", cmd = leet_cmds.yank[1], desc = "Yank the current solution" },
    { name = "LeetOpen", cmd = leet_cmds.open[1], desc = "Open the current question in browser" },
    {
      name = "LeetReset",
      cmd = leet_cmds.reset[1],
      desc = "Reset the current question to the default template",
    },
    { name = "LeetLastSubmit", cmd = leet_cmds.last_submit[1], desc = "Retrieve the last submitted code" },
    { name = "LeetRestore", cmd = leet_cmds.restore[1], desc = "Restore the default question layout" },
    { name = "LeetInject", cmd = leet_cmds.inject[1], desc = "Re-inject code for the current question" },

    -- Session-related commands
    { name = "LeetList", cmd = leet_cmds.list[1], desc = "Open the problem list picker" },
    { name = "LeetRandom", cmd = leet_cmds.random[1], desc = "Open a random question" },
    { name = "LeetDesc", cmd = leet_cmds.desc[1], desc = "Toggle question description visibility" },
    { name = "LeetDescStats", cmd = leet_cmds.desc.stats[1], desc = "Toggle description stats visibility" },
    { name = "LeetToggleDesc", cmd = leet_cmds.desc.toggle[1], desc = "Toggle the question description" },
    { name = "LeetCookieUpdate", cmd = leet_cmds.cookie.update[1], desc = "Update LeetCode session cookie" },
    { name = "LeetSignOut", cmd = leet_cmds.cookie.delete[1], desc = "Sign out from LeetCode" },
    { name = "LeetCacheUpdate", cmd = leet_cmds.cache.update[1], desc = "Update the LeetCode cache" },
    { name = "LeetFix", cmd = leet_cmds.fix[1], desc = "Run LeetCode fix command (internal)" },
  }

  -- Loop over the commands list and create user commands with descriptions
  for _, command in ipairs(commands) do
    vim.api.nvim_create_user_command(command.name, command.cmd, { desc = command.desc })
  end
end

-- Set up commands
vim.api.nvim_create_user_command("CommitCurrentFile", CommitCurrentFile, {})
vim.api.nvim_create_user_command("CompilerRun", CompilerRun, {})
vim.api.nvim_create_user_command("CompilerChoose", CompilerChoose, {})
vim.api.nvim_create_user_command("UndoTreeToggle", function() require("undotree").toggle() end, {})

return M

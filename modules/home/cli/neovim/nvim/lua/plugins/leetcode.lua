return {
  {
    "kawre/leetcode.nvim",
    lazy = vim.fn.argv()[1] ~= "leet",
    cmd = "Leet",
    dependencies = { "MunifTanjim/nui.nvim" },
    config = function()
      local utils = require("config.utils")

      local home_dir = vim.fn.stdpath("data") .. "/leetcode"
      local repo_url = "git@github.com:rmenai/leetcode.git"

      -- Sync repo on start
      if vim.fn.isdirectory(home_dir) == 0 then utils.sync_repo(home_dir, repo_url) end

      require("leetcode").setup({
        storage = { home = home_dir .. "/solutions" },
        plugins = { non_standalone = true },
        injector = {
          ["c"] = {
            before = {
              "#include <stdlib.h>",
              "#include <stdbool.h>",
              "#include <string.h>",
            },
          },
          ["python3"] = {
            before = {
              "from typing import List, Optional, Dict, Set, Tuple",
              "from collections import defaultdict, deque, Counter",
              "import heapq",
              "import bisect",
              "import math",
            },
          },
          ["rust"] = {
            before = {
              "use std::collections::{HashMap, HashSet, BTreeMap, BTreeSet, VecDeque};",
              "use std::cmp::{min, max, Reverse};",
              "use std::collections::BinaryHeap;",
            },
          },
        },
        arg = "leet",
        lang = "c",
      })

      -- Commit leetcode changes on neovim leave
      vim.api.nvim_create_autocmd("VimLeavePre", {
        group = vim.api.nvim_create_augroup("AutoGitCommit", { clear = true }),
        callback = function() utils.sync_repo(home_dir, repo_url) end,
      })
    end,
  },
}

local function map(mode, lhs, rhs, opts)
  opts = opts or { noremap = true, silent = true }
  vim.api.nvim_set_keymap(mode, lhs, rhs, opts)
end

-- Main buttons mappings
local winButton = "<Leader>"
local navButton = winButton .. "w"
local codeButton = "g"
local diagnosticsButton = codeButton .. "d"

local function map_navigation()
  -- Remap window navigation using the navigation button
  map("n", navButton .. "j", "<C-w>j")
  map("n", navButton .. "k", "<C-w>k")
  map("n", navButton .. "h", "<C-w>h")
  map("n", navButton .. "l", "<C-w>l")

  -- Remap cycling through windows
  map("n", navButton .. "w", "<C-w>w")
  map("n", navButton .. "W", "<C-w>W")

  -- Remap moving to specific windows
  map("n", navButton .. "t", "<C-w>t")
  map("n", navButton .. "b", "<C-w>b")
  map("n", navButton .. "p", "<C-w>p")
  map("n", navButton .. "P", "<C-w>P")

  -- Remap spliting windows
  map("n", navButton .. "s", "<C-w>s")
  map("n", navButton .. "S", ":new<CR>")
  map("n", navButton .. "v", "<C-w>v")
  map("n", navButton .. "V", ":vnew<CR>")

  -- Remap deleting windows
  map("n", navButton .. "q", "ZZ")
  map("n", navButton .. "Q", ":wqa!<CR>")
  map("n", navButton .. "d", ":q!<CR>")
  map("n", navButton .. "D", ":silent! wa<CR>:qa!<CR>")
  map("n", navButton .. "o", "<C-w>o")

  -- Remap rotate windows
  map("n", navButton .. "r", "<C-w>r")
  map("n", navButton .. "R", "<C-w>R")

  -- Remap move windows
  map("n", navButton .. "x", "<C-w>x")
  map("n", navButton .. "K", "<C-w>K")
  map("n", navButton .. "J", "<C-w>J")
  map("n", navButton .. "H", "<C-w>H")
  map("n", navButton .. "L", "<C-w>L")
  map("n", navButton .. "T", "<C-w>T")

  -- Remap resize windows
  map("n", navButton .. "=", "<C-w>=")
  map("n", navButton .. "[", "<C-w>+")
  map("n", navButton .. "]", "<C-w>-")
  map("n", navButton .. ".", "<C-w>>")
  map("n", navButton .. ",", "<C-w><")
  map("n", navButton .. "|", "<C-w>|")
end

local function map_ui()
  -- TELESCOPE
  map("n", winButton .. "<space>", "<cmd>lua require('telescope').extensions.picker_list.picker_list()<CR>")
  map("n", winButton .. "f", "<cmd>Telescope find_files<CR>")
  map("n", winButton .. "g", "<cmd>Telescope live_grep<CR>")
  map("n", winButton .. "c", "<cmd>Telescope commands<CR>")

  -- OBSIDIAN
  map("n", winButton .. "oo", "<cmd>lua require('telescope').find_picker('obsidian')()<CR>")
  map("n", winButton .. "oc", "<cmd>CommitCurrentFile<CR><cmd>ObsidianCreate<CR>")
  map("n", winButton .. "oa", "<cmd>ObsidianCreate<CR>")
  map("n", winButton .. "oA", "<cmd>ObsidianCreateWithTemplate<CR>")
  map("n", winButton .. "ot", "<cmd>ObsidianTemplate<CR>")

  -- NVIM-TREE
  map("n", winButton .. "a", "<cmd>NvimTree<CR>")
  map("n", winButton .. "A", "<cmd>NvimTreeFindFile<CR>")

  -- NEOGIT
  map("n", winButton .. "nn", "<cmd>Neogit kind=auto<CR>")
  map("n", winButton .. "nc", "<cmd>CommitCurrentFile<CR>")

  -- OTHER
  map("n", winButton .. "t", "<cmd>ToggleTerm<CR>")
  map("n", winButton .. "p", "<cmd>Outline<CR>")
end

local function map_lsp()
  -- LSP
  map("n", codeButton .. "p", "<cmd>lua vim.lsp.buf.definition()<CR>")
  map("n", codeButton .. "o", "<cmd>lua vim.lsp.buf.references()<CR>")
  map("n", codeButton .. "i", "<cmd>lua vim.lsp.buf.implementation()<CR>")
  map("n", codeButton .. "r", "<cmd>lua vim.lsp.buf.rename()<CR>")
  map("n", codeButton .. "a", "<cmd>lua vim.lsp.buf.code_action()<CR>")
  map("n", codeButton .. "f", "<cmd>lua vim.lsp.buf.format()<CR>")
  map("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>")

  map("n", codeButton .. "j", "<C-o>") -- Go prev
  map("n", codeButton .. "k", "<C-i>") -- Go next 

  -- DIAGNOSTICS
  map("n", diagnosticsButton .. "j", "<cmd>lua vim.diagnostic.goto_prev()<CR>")
  map("n", diagnosticsButton .. "k", "<cmd>lua vim.diagnostic.goto_next()<CR>")

  -- Completition mappings next to nvim-cmp plugin
  -- ["<C-k>"] = cmp.mapping.scroll_docs(-4),
  -- ["<C-j>"] = cmp.mapping.scroll_docs(4)
  -- ["<CR>"] = cmp.mapping(confirm_select)
  -- ["<Tab>"] = cmp.mapping(select_next, { "i", "s" })
  -- ["<S-Tab>"] = cmp.mapping(select_prev, { "i", "s" })


  -- CODE EDITING
  -- COMMENT : "gc", "gcc", "gbc"
  -- EXIT INS : "jj", "jk"source test.l
end

map_navigation()
map_ui()
map_lsp()

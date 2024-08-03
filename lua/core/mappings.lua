local function map(mode, lhs, rhs, opts)
  opts = opts or { noremap = true, silent = true }
  vim.api.nvim_set_keymap(mode, lhs, rhs, opts)
end

-- Main buttons mappings
local winButton = "<Leader>"
local codeButton = "g"
local diagnosticsButton = codeButton .. "d"

local function map_navigation()
  -- Remap window navigation using the navigation button
  map("n", winButton .. "j", "<C-w>j")
  map("n", winButton .. "k", "<C-w>k")
  map("n", winButton .. "h", "<C-w>h")
  map("n", winButton .. "l", "<C-w>l")
  map("n", winButton .. "w", "<C-w>w")
  map("n", winButton .. "W", "<C-w>W")

  map("n", winButton .. "x", "<C-w>x")
  map("n", winButton .. "K", "<C-w>K")
  map("n", winButton .. "J", "<C-w>J")
  map("n", winButton .. "H", "<C-w>H")
  map("n", winButton .. "L", "<C-w>L")
  map("n", winButton .. "T", "<C-w>T")

  -- Remap spliting and resizing windows
  map("n", winButton .. "s", "<C-w>s")
  map("n", winButton .. "v", "<C-w>v")
  map("n", winButton .. "S", ":new<CR>")
  map("n", winButton .. "V", ":vnew<CR>")

  map("n", winButton .. "=", "<C-w>=")
  map("n", winButton .. "[", "<C-w>+")
  map("n", winButton .. "]", "<C-w>-")
  map("n", winButton .. ".", "<C-w>>")
  map("n", winButton .. ",", "<C-w><")
  map("n", winButton .. "|", "<C-w>|")
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
  map("n", winButton .. "op", "<cmd>MarkdownPreview<CR>")

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

local function map_runner()
  map("n", "<F9>", "<cmd>CompilerChoose<CR>")

  map("n", "<F10>", "<cmd>CompilerRun<CR>")
  map("v", "<F10>", "<cmd>CompilerRunRange<CR>")
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
map_runner()
map_lsp()

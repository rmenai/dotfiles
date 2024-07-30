-- OPTIONS
-- To see what an option is set to execute `:lua = vim.o.<name>`

vim.g.loaded_netrw = 1 -- Enable vim's builtin file explorer
vim.g.loaded_netrwPlugin = 1 -- Load the netrw plugi`n
vim.g.python3_host_prog = "/usr/bin/python" -- Specify python speed for faster loading

vim.o.autoindent = true -- Automatically indent
vim.o.cmdheight = 0 -- Disable cmd bar showing when not typing command
vim.o.expandtab = true -- Convert tabs to spaces
vim.o.mouse = "" -- Completely disable mouse
vim.o.number = true -- Enable line numbers
vim.o.relativenumber = true -- Enable relative line numbers
vim.o.scrolloff = 10 -- Display 10 lines after EOF
vim.o.signcolumn = "number" -- Remove the gap on the left
vim.o.showmode = false -- Disable modes from showing bellow status line
vim.o.smartindent = true -- Automatically indent new lines
vim.o.termguicolors = true -- Enable 24-bit colour
vim.o.wrap = false -- Disable line wrapping

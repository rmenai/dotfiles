local M = {}

M.clipboard_autocmd = function()
	vim.api.nvim_create_autocmd({ "BufReadPost", "BufNewFile" }, {
		once = true,
		callback = function()
			if vim.fn.has("win32") == 1 or vim.fn.has("wsl") == 1 then
				vim.g.clipboard = {
					copy = {
						["+"] = "win32yank.exe -i --crlf",
						["*"] = "win32yank.exe -i --crlf",
					},
					paste = {
						["+"] = "win32yank.exe -o --lf",
						["*"] = "win32yank.exe -o --lf",
					},
				}
			elseif vim.fn.has("unix") == 1 then
				if vim.fn.executable("xclip") == 1 then
					vim.g.clipboard = {
						copy = {
							["+"] = "xclip -selection clipboard",
							["*"] = "xclip -selection clipboard",
						},
						paste = {
							["+"] = "xclip -selection clipboard -o",
							["*"] = "xclip -selection clipboard -o",
						},
					}
				elseif vim.fn.executable("xsel") == 1 then
					vim.g.clipboard = {
						copy = {
							["+"] = "xsel --clipboard --input",
							["*"] = "xsel --clipboard --input",
						},
						paste = {
							["+"] = "xsel --clipboard --output",
							["*"] = "xsel --clipboard --output",
						},
					}
				end
			end

			vim.opt.clipboard = "unnamedplus"
		end,
		desc = "Lazy load clipboard",
	})
end

-- Listen lsp-progress event and refresh lualine
M.lualine_autocmd = function()
	vim.api.nvim_create_autocmd("User", {
		group = vim.api.nvim_create_augroup("lualine_augroup", { clear = true }),
		pattern = "LspProgressStatusUpdated",
		callback = function()
			require("lualine").refresh()
		end,
	})
end

-- Activate linter on file changes
M.linter_autocmd = function()
	vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
		group = vim.api.nvim_create_augroup("lint", { clear = true }),
		pattern = "*",
		callback = function()
			require("lint").try_lint()
		end,
	})
end

return M

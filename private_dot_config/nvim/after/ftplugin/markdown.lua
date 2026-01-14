vim.opt_local.wrap = true
vim.opt_local.linebreak = true
vim.keymap.set("n", "<leader>dt", ":r !date '+%Y-%m-%d %H:%M:%S'<CR>", { buffer = true })
vim.keymap.set("n", "gx", _G.open_url_under_cursor, { buffer = true })

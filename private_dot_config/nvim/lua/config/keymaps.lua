local map = vim.keymap.set

map("n", "<C-b>", ":Neotree toggle<CR>")
map("n", "<leader>mp", ":MarkdownPreview<CR>") -- 预览
map("n", "<leader>gl", ":Glow<CR>")            -- glow 预览
map("n", "<leader>tm", ":TableModeToggle<CR>") -- 表格模式
map("n", "<leader>f", ":CocCommand editor.action.format<CR>")
map("n", "<C-s>", ":CocCommand editor.action.format<CR>")

map("n", "gd", ":CocDefinition<CR>")
map("n", "gr", ":CocReferences<CR>")
map("n", "gi", ":CocImplementation<CR>")
map("n", "gh", ":CocTypeDefinition<CR>")
map("n", "K", ":CocHover<CR>")
map("n", "<leader>rn", ":CocRename<CR>")
map("n", "<leader>ca", ":CocCodeAction<CR>")
map("n", "[g", ":CocDiagnosticPrev<CR>")
map("n", "]g", ":CocDiagnosticNext<CR>")

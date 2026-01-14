local map = vim.keymap.set

function _G.open_url_under_cursor()
  local line = vim.fn.getline(".")
  local col = vim.fn.col(".")
  local url = nil

  for s, label, link in line:gmatch("()%[([^%]]+)%]%(([^%)]+)%)") do
    local label_start = s + 1
    local label_end = label_start + #label - 1
    if col >= label_start and col <= label_end then
      url = link
      break
    end
  end

  if not url then
    local s = line:sub(1, col):find("https?://[^%s%)]*$")
    if s then
      local tail = line:sub(s)
      url = tail:match("https?://[^%s%)]*")
    end
  end

  if not url or url == "" then
    vim.notify("No URL under cursor", vim.log.levels.WARN)
    return
  end

  if not url:match("^%w+://") then
    local base = vim.fn.expand("%:p:h")
    url = vim.fn.fnamemodify(base .. "/" .. url, ":p")
  end

  if vim.ui and vim.ui.open then
    vim.ui.open(url)
    return
  end

  if vim.fn.has("mac") == 1 then
    vim.fn.jobstart({ "open", url }, { detach = true })
  else
    vim.fn.jobstart({ "xdg-open", url }, { detach = true })
  end
end

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
map("n", "gx", open_url_under_cursor)

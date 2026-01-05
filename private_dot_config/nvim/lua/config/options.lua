-- Base editor options
vim.opt.termguicolors = true

-- GUI transparency (neovide)
do
  local alpha = 0.2 -- 80% transparent (20% opacity)
  vim.g.transparency = alpha

  local function set_transparent_highlights()
    for _, name in ipairs({ "Normal", "NormalNC", "SignColumn", "EndOfBuffer" }) do
      vim.api.nvim_set_hl(0, name, { bg = "none" })
    end
  end

  local group = vim.api.nvim_create_augroup("UserTransparentBackground", { clear = true })
  vim.api.nvim_create_autocmd("ColorScheme", {
    group = group,
    callback = set_transparent_highlights,
  })
  set_transparent_highlights()

end

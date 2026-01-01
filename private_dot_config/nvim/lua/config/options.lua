-- Base editor options
vim.opt.termguicolors = true

-- GUI transparency (neovide)
do
  local alpha = 0.2 -- 80% transparent (20% opacity)
  vim.g.transparency = alpha

  if vim.g.neovide then
    vim.g.neovide_transparency = alpha
    local bg_hex = "#1a1b26" -- tokyonight background
    local alpha_hex = string.format("%02x", math.floor(255 * alpha))
    vim.g.neovide_background_color = bg_hex .. alpha_hex

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
end

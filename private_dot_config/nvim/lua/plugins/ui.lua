return {
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    opts = {
      transparent = false,
      on_highlights = function(hl, c)
        hl.Normal = { bg = "#000000", fg = c.fg }
        hl.NormalNC = { bg = "#000000", fg = c.fg }
        hl.SignColumn = { bg = "#000000" }
        hl.EndOfBuffer = { bg = "#000000", fg = "#000000" }
      end,
    },
    config = function(_, opts)
      require("tokyonight").setup(opts)
      vim.cmd("colorscheme tokyonight")
    end
  }
}

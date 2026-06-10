return {
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    opts = {
      transparent = true,
      on_highlights = function(hl, c)
        hl.Normal = { bg = "NONE", fg = c.fg }
        hl.NormalNC = { bg = "NONE", fg = c.fg }
        hl.SignColumn = { bg = "NONE" }
        hl.EndOfBuffer = { bg = "NONE", fg = "NONE" }
      end,
    },
    config = function(_, opts)
      require("tokyonight").setup(opts)
      vim.cmd("colorscheme tokyonight")
    end
  }
}

return {

  -- Markdown 基础增强（标题、列表、latex）
  {
    "preservim/vim-markdown",
    ft = "markdown",
    config = function()
      vim.g.vim_markdown_folding_disabled = 1
      vim.g.vim_markdown_conceal = 0
      vim.g.vim_markdown_math = 1
    end,
  },

  -- 浏览器预览
  {
    "iamcco/markdown-preview.nvim",
    ft = "markdown",
    build = "cd app && npm install",
    config = function()
      vim.g.mkdp_auto_start = 0
      vim.g.mkdp_browser = "microsoft-edge"
    end,
  },

  -- 自动目录 (TOC)
  {
    "mzlogin/vim-markdown-toc",
    ft = "markdown",
  },

  -- 表格模式
  {
    "dhruvasagar/vim-table-mode",
    ft = "markdown",
  },

  -- Glow 终端预览（可选）
  {
    "ellisonleao/glow.nvim",
    ft = "markdown",
    config = true,
  },
}

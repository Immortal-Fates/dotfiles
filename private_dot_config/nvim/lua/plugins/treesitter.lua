return {
  "nvim-treesitter/nvim-treesitter",
  lazy = false,
  build = ":TSUpdate",
  config = function()
    require("nvim-treesitter").setup()
    if vim.fn.executable("tree-sitter") == 1 then
      require("nvim-treesitter").install({
        "lua",
        "bash",
        "markdown",
        "markdown_inline",
        "json",
      })
    end

    vim.api.nvim_create_autocmd("FileType", {
      pattern = { "lua", "sh", "bash", "markdown", "json" },
      callback = function()
        if pcall(vim.treesitter.start) then
          vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
        end
      end,
    })
  end,
}

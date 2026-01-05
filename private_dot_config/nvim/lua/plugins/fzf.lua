return {
  {
    "junegunn/fzf",
    build = "./install --bin",
  },
  {
    "ibhagwan/fzf-lua",
    dependencies = { "junegunn/fzf", "nvim-tree/nvim-web-devicons" },
    cmd = "FzfLua",
    keys = {
      { "<C-p>", ":FzfLua files<CR>", desc = "Find files" },
      { "<C-f>", ":FzfLua live_grep<CR>", desc = "Live grep" },
    },
    config = function()
      require("fzf-lua").setup({
        winopts = {
          height = 0.95,
          width = 0.95,
        },
      })
    end,
  },
}

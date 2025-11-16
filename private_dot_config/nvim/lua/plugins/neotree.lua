return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
    "MunifTanjim/nui.nvim",
  },
  cmd = "Neotree",
  keys = {
    { "<leader>e", ":Neotree toggle<CR>", desc = "Toggle Neo-tree" },
  },
  config = function()
    require("neo-tree").setup({
      close_if_last_window = true,
      popup_border_style = "rounded",
      enable_git_status = true,
      enable_diagnostics = true,

      window = {
        width = 30,
        mappings = {
          ["<space>"] = "toggle_node",
          ["<cr>"] = "open",
          ["o"] = "open",
          ["s"] = "open_split",
          ["v"] = "open_vsplit",
        },
      },

      filesystem = {
        follow_current_file = true,      -- 追踪当前文件
        use_libuv_file_watcher = true,   -- 自动刷新目录
        filtered_items = {
          hide_dotfiles = false,
          hide_gitignored = false,
        },
      },
    })
  end,
}


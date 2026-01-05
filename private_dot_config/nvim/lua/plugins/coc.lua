return {
  "neoclide/coc.nvim",
  branch = "release",
  cmd = {
    "CocCommand",
    "CocInfo",
    "CocInstall",
    "CocUpdate",
    "CocList",
    "CocOpenLog",
  },
  event = { "InsertEnter" },
  build = "npm install",
  config = function()
    vim.opt.completeopt = { "menuone", "noinsert", "noselect" }

    vim.g.coc_global_extensions = {
      "coc-tsserver",
      "coc-lua",
      "coc-pyright",
      "coc-diagnostic",
      "coc-html",
      "coc-css",
      "coc-json",
      "coc-clangd",
      "coc-prettier",
      "coc-markdownlint",
    }

    vim.opt.updatetime = 300
    vim.opt.signcolumn = "yes"
    vim.g.coc_suggest_auto_trigger = "always"

    local map = vim.keymap.set
    map("n", "<leader>e", ":CocDiagnostics<CR>")
    map("n", "<leader>q", ":CocList diagnostics<CR>")

    function _G.check_back_space()
      local col = vim.fn.col(".") - 1
      return col == 0 or vim.fn.getline("."):sub(col, col):match("%s") ~= nil
    end

    map("i", "<Tab>",
      "coc#pum#visible() ? coc#pum#next(1) : (v:lua.check_back_space() ? '<Tab>' : coc#refresh())",
      { expr = true, silent = true })
    map("i", "<S-Tab>", "coc#pum#visible() ? coc#pum#prev(1) : '<C-h>'",
      { expr = true, silent = true })
    map("i", "<CR>", "coc#pum#visible() ? coc#pum#confirm() : '<CR>'",
      { expr = true, silent = true })

  end,
}

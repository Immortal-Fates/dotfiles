return {
  "Yggdroot/indentLine",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    vim.g.indentLine_char = "│"
  end,
}

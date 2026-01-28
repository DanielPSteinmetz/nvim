return {
  "akinsho/toggleterm.nvim",
  version = "*",
  config = function()
    require("toggleterm").setup({
      size = 10,
      vim.keymap.set('n', '<leader>t', '<cmd>ToggleTerm<CR>')
    })
  end,
}





















vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

require('config.remap')
require('config.set')
require('config.lazy')

vim.api.nvim_create_autocmd(
  { "BufRead", "BufNewFile", "BufWritePost" },
  {
    callback = function()
      vim.cmd("filetype detect")
    end,
  }
)


return {
  'nvim-tree/nvim-tree.lua',
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    require("nvim-tree").setup({
      sort = { sorter = "case_sensitive" },
      view = { width = 30 },
      renderer = { group_empty = true },
      filters = {
         dotfiles = true,
         custom = {
           "*.o",
         }
      },
      actions = {
        open_file = { quit_on_open = true }
      },
    })

    vim.keymap.set('n', '<leader>e', '<cmd>NvimTreeToggle<CR>', { desc = 'Toggle file tree' })
    vim.keymap.set('n', '<leader>o', '<cmd>NvimTreeFindFileToggle<CR>', { desc = 'Reveal file in tree' })

  end
}

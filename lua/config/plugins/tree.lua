return {
  'nvim-tree/nvim-tree.lua',
  config = function()
    require("nvim-tree").setup({
      sort = { sorter = "case_sensitive" },
      view = { width = 30 },
      renderer = { group_empty = true },
    })

    vim.keymap.set('n', '<leader>e', '<cmd>NvimTreeToggle<CR>', { desc = 'Toggle file tree' })
    vim.keymap.set('n', '<leader>o', '<cmd>NvimTreeFindFileToggle<CR>', { desc = 'Reveal file in tree' })

  end
}

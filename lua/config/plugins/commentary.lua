return {
  'tpope/vim-commentary',
  config = function ()
    vim.keymap.set('n', '<C-_>', '<Plug>CommentaryLine')
    vim.keymap.set('v', '<C-_>', '<Plug>Commentary')
  end
}

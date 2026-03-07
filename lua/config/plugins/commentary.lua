return {
  'tpope/vim-commentary',
  config = function ()
    vim.keymap.set('n', '<C-_>', '<Plug>CommentaryLine')
    vim.keymap.set('v', '<C-_>', '<Plug>Commentary')

    -- handlebars
    vim.api.nvim_create_autocmd("FileType", {
      pattern = { "handlebars", "hbs" },
      callback = function()
        vim.bo.commentstring = "{{! %s }}"
      end,
    })
  end
}

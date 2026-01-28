return {
  "junegunn/vim-easy-align",
  -- use `ga*X` to align on all X 
  config = function ()
    vim.keymap.set({'n', 'v'}, 'ga', '<Plug>(EasyAlign)')
  end
}

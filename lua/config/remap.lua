vim.g.mapleader = ' '

-- Found (ThePrimagen)
vim.g.maplocalleader = "\\"

vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv")
vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv")

vim.keymap.set('n', 'J', 'mzJ`z')

vim.keymap.set('n', '<C-d>', '<C-d>zz')
vim.keymap.set('n', '<C-u>', '<C-u>zz')

vim.keymap.set('n', 'n', 'nzzzv')
vim.keymap.set('n', 'N', 'Nzzzv')

vim.keymap.set('x', '<leader>p', '"_dP')
vim.keymap.set('n', '<leader>p', '"+p')

vim.keymap.set('n', '<leader>y', '"+y')
vim.keymap.set('v', '<leader>y', '"+y')
vim.keymap.set('n', '<leader>Y', '"+Y')

vim.keymap.set('n', '<leader>d', '"_d')
vim.keymap.set('v', '<leader>d', '"_d')

vim.keymap.set('n', '<leader>vd', vim.diagnostic.open_float)
vim.keymap.set('n', '<C-k>', '<cmd>cnext<CR>zz')
vim.keymap.set('n', '<C-j>', '<cmd>cprev<CR>zz')
vim.keymap.set('n', '<leader>k', '<cmd>lnext<CR>zz')
vim.keymap.set('n', '<leader>j', '<cmd>lprev<CR>zz')

vim.keymap.set('n', '<leader>x', '<cmd>!chmod +x %<CR>', {silent = true})

-- Custom mappings
vim.keymap.set('n', '<leader>r', '<cmd>!make<CR>')

vim.keymap.set('n', 'H', '^')
vim.keymap.set('n', 'L', '$')

vim.keymap.set('n', '<leader>w', '<cmd>:wa<CR>')

vim.keymap.set('n', '#p', 'i#pragma once<CR><CR><Esc>')

local function toggle_quickfix()
  local qf_exists = false
  -- Check if any window in the current tab is a quickfix window
  for _, win in pairs(vim.fn.getwininfo()) do
    if win["quickfix"] == 1 then
      qf_exists = true
      break
    end
  end

  if qf_exists then
    vim.cmd("cclose")
  else
    -- Check if the quickfix list is empty before opening
    if vim.tbl_isempty(vim.fn.getqflist()) then
      print("no quickfixes")
    else
      vim.cmd("copen")
    end
  end
end

vim.keymap.set('n', '<leader>q', toggle_quickfix, { desc = "Toggle Quickfix" })

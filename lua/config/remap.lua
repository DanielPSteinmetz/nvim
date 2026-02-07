vim.g.mapleader = ' '

-- Found (ThePrimagen)
vim.g.maplocalleader = "\\"

vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv")
vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv")

vim.keymap.set('n', 'J', 'mzJ`z')
vim.keymap.set('s', 'J', 'J')

vim.keymap.set('n', '<C-d>', '<C-d>zz')
vim.keymap.set('n', '<C-u>', '<C-u>zz')
vim.keymap.set('n', '<C-f>', '<C-f>zz')
vim.keymap.set('n', '<C-b>', '<C-b>zz')

vim.keymap.set('n', 'n', 'nzzzv')
vim.keymap.set('n', 'N', 'Nzzzv')

vim.keymap.set('x', '<leader>p', '"_dP')
vim.keymap.set('n', '<leader>pp', '"+p')

vim.keymap.set('n', '<leader>y', '"+y')
vim.keymap.set('v', '<leader>y', '"+y')
vim.keymap.set('n', '<leader>Y', '"+Y')

vim.keymap.set('n', '<leader>d', '"_d')
vim.keymap.set('v', '<leader>d', '"_d')

vim.keymap.set('n', '<leader>vd', vim.diagnostic.open_float)
vim.keymap.set('n', '<C-j>', '<cmd>cnext<CR>zz')
vim.keymap.set('n', '<C-k>', '<cmd>cprev<CR>zz')
vim.keymap.set('n', '<leader>j', '<cmd>lnext<CR>zz')
vim.keymap.set('n', '<leader>k', '<cmd>lprev<CR>zz')

vim.keymap.set('n', '<leader>x', '<cmd>!chmod +x %<CR>', {silent = true})

-- Custom mappings

vim.keymap.set('n', 'H', '^')
vim.keymap.set('n', 'L', '$')

vim.keymap.set({"n", "i", "v"}, "<M-w>", "<cmd>wa<CR>", { desc = "Save file" })

vim.keymap.set('n', '#p', 'i#pragma once<CR><CR><Esc>')

vim.keymap.set('n', '<leader>vs', '<cmd>vs<CR>')

vim.keymap.set('n', '<leader>=', 'gg=G``zz')

-- Window movement
vim.keymap.set("n", "<M-h>", '<C-w>h')
vim.keymap.set("n", "<M-j>", '<C-w>j')
vim.keymap.set("n", "<M-k>", '<C-w>k')
vim.keymap.set("n", "<M-l>", '<C-w>l')

-- Terminal movement
vim.keymap.set("t", "<M-h>", '<C-\\><C-n><C-w>h')
vim.keymap.set("t", "<M-j>", '<C-\\><C-n><C-w>j')
vim.keymap.set("t", "<M-k>", '<C-\\><C-n><C-w>k')
vim.keymap.set("t", "<M-l>", '<C-\\><C-n><C-w>l')
vim.keymap.set("t", "<Esc><Esc>", '<C-\\><C-n>', { desc = "Exit terminal mode" })

-- Window resize
vim.keymap.set({'n', 't'}, "<C-Up>",    "<cmd>resize +1<CR>")
vim.keymap.set({'n', 't'}, "<C-Down>",  "<cmd>resize -1<CR>")
vim.keymap.set({'n', 't'}, "<C-Left>",  "<cmd>vertical resize -1<CR>")
vim.keymap.set({'n', 't'}, "<C-Right>", "<cmd>vertical resize +1<CR>")


-- nerd remap for joplin
-- \(.*\)\n\\t\(.*\)/<details>\r<summary><b>\r\1\r<\/b><\/summary>\r\2\r<\/details>\r<br>


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

vim.keymap.set("n", "<leader>sh", function()
  local ext = vim.fn.expand("%:e")
  if ext == "hpp" then
    vim.cmd("edit %:r.cpp")
  else
    vim.cmd("edit %:r.hpp")
  end
end, { desc = "switch header/source" })

-- Run file
vim.keymap.set("n", "<leader>r", function()
  -- Save before running
  vim.cmd("wa")

  local ft = vim.bo.filetype

  if ft == "cpp" or ft == "c" then
    vim.cmd("!make")
  elseif ft == "rust" then
    vim.cmd("!cargo run")
  elseif ft == "python" then
    vim.cmd("!python3 %")
  else
    print("No run command for filetype: " .. ft)
  end
end, { desc = "Run project" })

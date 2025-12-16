return {
  "folke/tokyonight.nvim",
  lazy = false,
  priority = 1000,
  config = function()
    -- Load colorscheme
    vim.cmd.colorscheme("tokyonight")

    -- Reapply transparency & overrides on colorscheme load
    vim.api.nvim_create_autocmd("ColorScheme", {
      callback = function()
        -- Global transparency
        vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
        vim.api.nvim_set_hl(0, "NormalNC", { bg = "none" })
        vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })

        -- Splits
        vim.api.nvim_set_hl(0, "WinSeparator", {
          fg = "#3b3b3b",
          bg = "none",
        })

        -- Sign column
        vim.api.nvim_set_hl(0, "SignColumn", { bg = "none" })

        -- Nvim-tree
        vim.api.nvim_set_hl(0, "NvimTreeNormal", { bg = "none" })
        vim.api.nvim_set_hl(0, "NvimTreeNormalNC", { bg = "none" })
        vim.api.nvim_set_hl(0, "NvimTreeEndOfBuffer", { bg = "none" })
      end,
    })

    vim.cmd("doautocmd ColorScheme")
  end,
}

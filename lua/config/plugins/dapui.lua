return {
  "rcarriga/nvim-dap-ui",
  dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio", },
  config = function()
    local dap, dapui = require("dap"), require("dapui")

    dapui.setup({
      icons = {
        expanded = "▾",
        collapsed = "▸",
        current_frame = "➜",
      },

      controls = {
        enabled = false,
      },

      layouts = {
        -- RIGHT: scopes only (default open)
        {
          position = "right",
          size = 0.40,
          elements = {
            {
              id = "scopes",
              size = 1.0,
            },
          },
        },

        -- LEFT: watches / stacks / breakpoints (closed by default)
        {
          position = "left",
          size = 40,
          elements = {
            { id = "watches",     size = 0.33 },
            { id = "stacks",      size = 0.33 },
            { id = "breakpoints", size = 0.34 },
          },
        },

        -- BOTTOM: console only (closed by default)
        {
          position = "bottom",
          size = 0.25,
          elements = {
            { id = "console", size = 1.0 },
          },
        },
      },

      floating = {
        max_height = 0.9,
        max_width = 0.9,
        border = "rounded",
        mappings = {
          close = { "q", "<Esc>" },
        },
      },

      windows = { indent = 1, },
    })


    -- Auto open/close UI
    dap.listeners.after.event_initialized["dapui_scopes_only"] = function() dapui.open( { layout = 1 } ) end
    dap.listeners.before.event_terminated["dapui_config"]      = function() dapui.close() end
    dap.listeners.before.event_exited["dapui_config"]          = function() dapui.close() end

    -- Optional keybinding to toggle UI manually
    vim.keymap.set("n", "<leader>du", dapui.toggle, { desc = "DAP UI: Toggle" })
    vim.keymap.set('n', '<leader>d<Right>', function() dapui.toggle( { layout = 1 } ) end, { desc = "Dap UI: Toggle scopes" })
    vim.keymap.set('n', '<leader>d<Down>',  function() dapui.toggle( { layout = 3 } ) end, { desc = "Dap UI: Toggle console" })
    vim.keymap.set('n', '<leader>d<Left>',  function() dapui.toggle( { layout = 2 } ) end, { desc = "Dap UI: Toggle watches, stacks, breakpoints column" })


  end,
}

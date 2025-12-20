return {
  -- Core DAP
  {
    "mfussenegger/nvim-dap",
  },

  -- DAP UI
  {
    "rcarriga/nvim-dap-ui",
    dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio", },
    config = function()
      local dap, dapui = require("dap"), require("dapui")

      dapui.setup({
        icons = { expanded = "▾", collapsed = "▸" },
        mappings = {
          expand = { "<CR>", "<2-LeftMouse>" },
          open = "o",
          remove = "d",
          edit = "e",
          repl = "r",
        },
        layouts = {
          {
            elements = {
              { id = "scopes", size = 0.25 },
              { id = "breakpoints", size = 0.25 },
              { id = "stacks", size = 0.25 },
              { id = "watches", size = 0.25 },
            },
            size = 40,
            position = "left",
          },
          {
            elements = { "repl" },
            size = 10,
            position = "bottom",
          },
        },
        floating = {
          border = "rounded",
          mappings = { close = { "q", "<Esc>" } },
        },
        windows = { indent = 1 },
      })

      -- Auto open/close UI
      dap.listeners.after.event_initialized["dapui_config"] = function() dapui.open() end
      dap.listeners.before.event_terminated["dapui_config"] = function() dapui.close() end
      dap.listeners.before.event_exited["dapui_config"] = function() dapui.close() end

      -- Optional keybinding to toggle UI manually
      vim.keymap.set("n", "<leader>du", dapui.toggle, { desc = "DAP UI: Toggle" })
    end,
  },

  -- Mason DAP integration
  {
    "jay-babu/mason-nvim-dap.nvim",
    dependencies = { "williamboman/mason.nvim", "mfussenegger/nvim-dap" },
    config = function()
      require("mason-nvim-dap").setup({
        ensure_installed = { "codelldb" },
        automatic_installation = true,
      })
    end,
  },

  -- C++ DAP configuration
  {
    "mfussenegger/nvim-dap",
    config = function()
      local dap = require("dap")

      -- Adapter
      dap.adapters.codelldb = {
        type = "server",
        port = "${port}",
        executable = {
          command = "codelldb",
          args = { "--port", "${port}" },
        },
      }

      -- Configurations
      dap.configurations.cpp = {
        {
          name = "Launch",
          type = "codelldb",
          request = "launch",
          program = function()
            local input = vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
            if input == "" then
              local cwd = vim.fn.getcwd()
              return cwd .. "/" .. vim.fn.fnamemodify(cwd, ":t")
            end
            return input
          end,
          cwd = "${workspaceFolder}",
          stopOnEntry = false,
          args = { "test.json" },
        },
      }
      dap.configurations.c = dap.configurations.cpp

      -- Keymaps
      vim.keymap.set("n", "<leader>dc", dap.continue, { desc = "DAP: Continue" })
      vim.keymap.set("n", "<leader>ds", dap.step_over, { desc = "DAP: Step Over" })
      vim.keymap.set("n", "<C-_>", dap.step_over, { desc = "DAP: Step Over" })
      vim.keymap.set("n", "<leader>di", dap.step_into, { desc = "DAP: Step Into" })
      vim.keymap.set("n", "<leader>do", dap.step_out, { desc = "DAP: Step Out" })
      vim.keymap.set("n", "<leader>dr", dap.repl.toggle, { desc = "DAP: Toggle REPL" })
      vim.keymap.set("n", "<leader>db", dap.toggle_breakpoint, { desc = "DAP: Toggle Breakpoint" })
      vim.keymap.set("n", "<leader>dq", function()
        dap.terminate()
        require("dapui").close()
      end, { desc = "DAP: Quit and close UI" })
    end,
  },
}

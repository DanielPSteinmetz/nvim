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
        icons = {
          expanded = "▾",
          collapsed = "▸",
          current_frame = "➜",
        },

        controls = {
          enabled = false, -- we don't need dap-ui buttons
        },

        layouts = {
          -- RIGHT: scopes only (default open)
          {
            position = "right",
            size = 0.40, -- fraction of screen width
            elements = {
              {
                id = "scopes",
                size = 1.0, -- take full layout
              },
            },
          },

          -- LEFT: watches / stacks / breakpoints (closed by default)
          {
            position = "left",
            size = 40, -- fixed width feels best here
            elements = {
              { id = "watches",     size = 0.33 },
              { id = "stacks",      size = 0.33 },
              { id = "breakpoints", size = 0.34 },
            },
          },

          -- BOTTOM: console only (closed by default)
          {
            position = "bottom",
            size = 0.25, -- height
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

        windows = {
          indent = 1,
        },
      })


      -- Auto open/close UI
      dap.listeners.after.event_initialized["dapui_scopes_only"] = function() dapui.open( { layout = 1 } ) end
      dap.listeners.before.event_terminated["dapui_config"] = function() dapui.close() end
      dap.listeners.before.event_exited["dapui_config"] = function() dapui.close() end

      -- Optional keybinding to toggle UI manually
      vim.keymap.set("n", "<leader>du", dapui.toggle, { desc = "DAP UI: Toggle" })
      vim.keymap.set('n', '<leader>d<Right>', function() dapui.toggle( { layout = 1 } ) end, { desc = "Dap UI: Toggle scopes" })
      vim.keymap.set('n', '<leader>d<Down>',  function() dapui.toggle( { layout = 3 } ) end, { desc = "Dap UI: Toggle console" })
      vim.keymap.set('n', '<leader>d<Left>',  function() dapui.toggle( { layout = 2 } ) end, { desc = "Dap UI: Toggle watches, stacks, breakpoints column" })


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

      -- Icons

      vim.fn.sign_define("DapBreakpoint", {
        text = "",
        texthl = "DiagnosticSignError",
      })

      vim.fn.sign_define("DapBreakpointCondition", {
        text = "",
        texthl = "DiagnosticSignWarn",
      })

      vim.fn.sign_define("DapBreakpointRejected", {
        text = "",
        texthl = "DiagnosticSignHint",
      })

      vim.fn.sign_define("DapStopped", {
        text = "",
        texthl = "DiagnosticSignInfo",
        linehl = "Visual",
      })

      -- Keymaps
      vim.keymap.set("n", "<PageDown>", dap.continue, { desc = "DAP: Continue" })
      vim.keymap.set("n", "<leader>dc", dap.continue, { desc = "DAP: Continue" })
      vim.keymap.set("n", "<Down>", dap.step_over, { desc = "DAP: Step Over" })
      vim.keymap.set("n", "<Right>", dap.step_into, { desc = "DAP: Step Into" })
      vim.keymap.set("n", "<Left>", dap.step_out, { desc = "DAP: Step Out" })
      vim.keymap.set("n", "<leader>dr", dap.repl.toggle, { desc = "DAP: Toggle REPL" })
      vim.keymap.set("n", "<leader>db", dap.toggle_breakpoint, { desc = "DAP: Toggle Breakpoint" })
      vim.keymap.set("n", "<leader>dq", function()
        dap.terminate()
        require("dapui").close()
      end, { desc = "DAP: Quit and close UI" })
    end,
  },
}

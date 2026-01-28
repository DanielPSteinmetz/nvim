return {
  -- Mason DAP integration
  {
    "jay-babu/mason-nvim-dap.nvim",
    dependencies = { "williamboman/mason.nvim", "mfussenegger/nvim-dap" },
    config = function()
      require("mason-nvim-dap").setup({
        ensure_installed = {
          "codelldb",
          "python",
          "js-debug-adapter",
        },
        automatic_installation = true,
      })
    end,
  },

  -- DAP configuration
  {
    "mfussenegger/nvim-dap",
    config = function()
      local dap = require("dap")


      -- Adapters
      dap.adapters.codelldb = {
        type = "server",
        port = "${port}",
        executable = {
          command = "codelldb",
          args = { "--port", "${port}" },
        },
      }

      dap.adapters.python = {
        type = "executable",
        command = "python3",
        args = { "-m", "debugpy.adapter" },
      }

      dap.adapters['pwa-node'] = {
        type = "server",
        host = "localhost",
        port = "${port}",
        executable = {
          command = "node",
          args = {
            vim.fn.stdpath("data")
              .. "/mason/packages/js-debug-adapter/js-debug/src/dapDebugServer.js",
            "${port}",
          },
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

      dap.configurations.python = {
        {
          name = "Launch",
          type = "python",
          request = "launch",
          program = "${file}",
          console = "internalConsole",
          pythonPath = function()
            return "python3"
          end,
        },
      }

      dap.configurations.typescript = {
        {
          type = "pwa-node",
          request = "launch",
          name = "Launch",
          cwd = "${workspaceFolder}",
          program = "${workspaceFolder}/dist/main.js",
          sourceMaps = true,
          outFiles = { "${workspaceFolder}/dist/**/*.js" },
          skipFiles = { "<node_internals>/**" },
        },
      }

      dap.configurations.javascript = dap.configurations.typescript


      -- Keymaps
      vim.keymap.set("n", "<PageDown>", dap.continue,          { desc = "DAP: Continue"          })
      vim.keymap.set("n", "<leader>dc", dap.continue,          { desc = "DAP: Continue"          })
      vim.keymap.set("n",     "<Down>", dap.step_over,         { desc = "DAP: Step Over"         })
      vim.keymap.set("n",    "<Right>", dap.step_into,         { desc = "DAP: Step Into"         })
      vim.keymap.set("n",     "<Left>", dap.step_out,          { desc = "DAP: Step Out"          })
      vim.keymap.set("n", "<leader>dr", dap.repl.toggle,       { desc = "DAP: Toggle REPL"       })
      vim.keymap.set("n", "<leader>db", dap.toggle_breakpoint, { desc = "DAP: Toggle Breakpoint" })
      vim.keymap.set("n", "<leader>dB", function ()
        local condition = vim.fn.input("Breakpoint condition (optional): ")
        local hit_condition = vim.fn.input("Hit count (optional): ")

        -- Convert empty strings to nil
        condition = condition ~= "" and condition or nil
        hit_condition = hit_condition ~= "" and hit_condition or nil

        dap.toggle_breakpoint(condition, hit_condition)
      end, { desc = "DAP: Toggle Breakpoint" })

      vim.keymap.set("n", "<leader>dq", function()
        dap.terminate()
        require("dapui").close()
      end, { desc = "DAP: Quit and close UI" })


      -- Icons
      vim.fn.sign_define("DapBreakpoint",          { text = "", texthl = "DiagnosticSignError", })
      vim.fn.sign_define("DapBreakpointCondition", { text = "", texthl = "DiagnosticSignWarn",  })
      vim.fn.sign_define("DapBreakpointRejected",  { text = "", texthl = "DiagnosticSignHint",  })
      vim.fn.sign_define("DapStopped",             { text = "", texthl = "DiagnosticSignInfo",  linehl = "Visual", })

    end,
  },
}

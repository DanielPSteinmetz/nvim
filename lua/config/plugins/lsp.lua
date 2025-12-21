return {
	-- LSP Support
	"neovim/nvim-lspconfig",
	dependencies = {
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",
		"hrsh7th/nvim-cmp",
		"hrsh7th/cmp-nvim-lsp",
		"L3MON4D3/LuaSnip",
	},
	config = function()
		-- Mason
		require("mason").setup()

		require("mason-lspconfig").setup({
			ensure_installed = {
				"lua_ls",
				"ts_ls",
				"bashls",
				"clangd",
        "pyright",
			},
		})

    -- Icons
    vim.diagnostic.config({
      signs = {
        text = {
          [vim.diagnostic.severity.ERROR] = "",
          [vim.diagnostic.severity.WARN]  = "",
          [vim.diagnostic.severity.INFO]  = "",
          [vim.diagnostic.severity.HINT]  = "",
        },
      },
    })

		-- Capabilities (for nvim-cmp)
		local capabilities = require("cmp_nvim_lsp").default_capabilities()

		-- Lua
		vim.lsp.config('lua_ls', {
			capabilities = capabilities,
			settings = {
				Lua = {
					diagnostics = {
						globals = { "vim" },
					},
				},
			},
		})

		-- TypeScript / JavaScript
		vim.lsp.config('ts_ls', {
			capabilities = capabilities,
		})

		-- C / C++
    vim.lsp.config('clangd', {
      capabilities = capabilities,
      init_options = {
        fallbackFlags = { '-std=c++20' },
      },
    })

    -- bash
		vim.lsp.config("bashls", {
			capabilities = capabilities,
		})

    --python
    vim.lsp.config("pyright", {
      capabilities = capabilities,
    })

		-- Keymaps
		vim.api.nvim_create_autocmd("LspAttach", {
			callback = function(ev)
				local opts = { buffer = ev.buf }

				vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
				vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
				vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
				vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
				vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
			end,
		})
	end,
}

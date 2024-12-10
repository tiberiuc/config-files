return {
  {
    "elixir-tools/elixir-tools.nvim",
    version = "*",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      local elixir = require("elixir")
      local elixirls = require("elixir.elixirls")

      elixir.setup {
        credo = {
          enable = false,
        },
        nextls = {
          enable = false
        },
        elixirls = {
          tag = "v0.24.1",
          enable = true,
          settings = elixirls.settings {
            dialyzerEnabled = true,
            fetchDeps = false,
            suggestSpecs = true,
            enableTestLenses = true,
          },
          on_attach = function(client, bufnr)
            vim.keymap.set("n", "<space>Ef", ":ElixirFromPipe<cr>", { buffer = true, noremap = true })
            vim.keymap.set("n", "<space>Et", ":ElixirToPipe<cr>", { buffer = true, noremap = true })
            vim.keymap.set("n", "<space>Eo", ":ElixirOutputPanel<cr>", { buffer = true, noremap = true })
            vim.keymap.set("v", "<space>Em", ":ElixirExpandMacro<cr>", { buffer = true, noremap = true })
          end,
        },


        projectionist = {
          enable = false
        }
      }

      local capabilities = require('cmp_nvim_lsp').default_capabilities()
      require('lspconfig')['elixirls'].setup {
        capabilities = capabilities
      }
    end,
    dependencies = {
      "nvim-lua/plenary.nvim",
      "hrsh7th/nvim-cmp",
      "hrsh7th/cmp-nvim-lsp",
    },
  }
}

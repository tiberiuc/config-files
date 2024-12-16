return {
  {
    "elixir-tools/elixir-tools.nvim",
    version = "*",
    -- event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "nvim-lua/plenary.nvim",
      "hrsh7th/nvim-cmp",
      "hrsh7th/cmp-nvim-lsp",
    },
    config = function()
      local elixir = require("elixir")
      local elixirls = require("elixir.elixirls")

      elixir.setup {
        credo = {
          enable = true,
        },
        nextls = {
          enable = false
        },
        elixirls = {
          tag = "v0.25.0",
          enable = true,
          settings = elixirls.settings {
            dialyzerEnabled = true,
            fetchDeps = false,
            suggestSpecs = true,
            enableTestLenses = true,
          },
          on_attach = function(client, bufnr)
            vim.keymap.set("n", "<space>xf", ":ElixirFromPipe<cr>", { buffer = true, noremap = true })
            vim.keymap.set("n", "<space>xt", ":ElixirToPipe<cr>", { buffer = true, noremap = true })
            vim.keymap.set("n", "<space>xo", ":ElixirOutputPanel<cr>", { buffer = true, noremap = true })
            vim.keymap.set("v", "<space>xm", ":ElixirExpandMacro<cr>", { buffer = true, noremap = true })
          end,
        },


        projectionist = {
          enable = false
        }
      }

      -- local capabilities = require('cmp_nvim_lsp').default_capabilities()
      -- require('lspconfig')['elixirls'].setup {
      --   capabilities = capabilities
      -- }
    end,
  }
}

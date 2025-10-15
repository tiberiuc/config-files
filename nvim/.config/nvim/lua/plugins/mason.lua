return {
  {
    "williamboman/mason.nvim",
    enable = false,
    config = function()
      require("mason").setup({
        ui = {
          icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗"
          }
        }
      })
    end
  },
  {
    "williamboman/mason-lspconfig.nvim",
    config = function()
      require("mason-lspconfig").setup {
        ensure_installed = { "tailwindcss", "ts_ls" },
      }
      vim.lsp.config.lua_ls = {}
    end
  },
}

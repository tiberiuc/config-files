return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      { 'saghen/blink.cmp' },
      {
        "folke/lazydev.nvim",
        ft = "lua", -- only load on lua files
        opts = {
          library = {
            -- See the configuration section for more details
            -- Load luvit types when the `vim.uv` word is found
            { path = "${3rd}/luv/library", words = { "vim%.uv" } },
          },
        },
      },
    },
    opts = {
      servers = {
        -- Disable automatic install for specific servers
        elixirls = { mason = false },
        -- Add more servers as needed
      },
    },
    -- capabilities = require("cmp_nvim_lsp").default_capabilities(),
    capabilities = require('blink.cmp').get_lsp_capabilities(),
    config = function(_, opts)
      -- local lspconfig = require('lspconfig')
      -- for server, config in pairs(opts.servers) do
      --   -- passing config.capabilities to blink.cmp merges with the capabilities in your
      --   -- `opts[server].capabilities, if you've defined it
      --   config.capabilities = require('blink.cmp').get_lsp_capabilities(config.capabilities)
      --   lspconfig[server].setup(config)
      -- end
      require('lspconfig').lua_ls.setup {}

      local tailwindcss_lsp_opts = {
        root_dir = require("lspconfig.util").root_pattern("assets/tailwind.config.js", "tailwind.config.js",
          "tailwind.config.cjs", "tailwind.js",
          "tailwind.cjs"),
        init_options = {
          userLanguages = { heex = "html", elixir = "html" }
        },
      }

      require("lspconfig").tailwindcss.setup(tailwindcss_lsp_opts)



      vim.api.nvim_create_autocmd('LspAttach', {
        callback = function(args)
          local client = vim.lsp.get_client_by_id(args.data.client_id)
          if not client then return end

          local bufnr = args.buf
          local opts = { noremap = true, silent = true }
          local keymap = vim.api.nvim_buf_set_keymap
          keymap(bufnr, "n", "ga", "<cmd>lua vim.lsp.codelens.run()<cr>", opts)
          keymap(bufnr, "n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
          keymap(bufnr, "n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
          keymap(bufnr, "n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
          keymap(bufnr, "n", "gI", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
          keymap(bufnr, "n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
          keymap(bufnr, "n", "gl", "<cmd>lua vim.diagnostic.open_float()<CR>", opts)


          ---@diagnostic disable-next-line: missing-parameter
          if client.supports_method('textDocument/formatting') then
            vim.api.nvim_create_autocmd('BufWritePre', {
              buffer = args.buf,


              callback = function()
                vim.lsp.buf.format({ bufnr = args.buf, id = client.id })
              end
            })
          end
        end
      })
    end,
  },
}

--[[
 THESE ARE EXAMPLE CONFIGS FEEL FREE TO CHANGE TO WHATEVER YOU WANT
 `lvim` is the global options object
]]
-- vim options
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.relativenumber = true

-- general
lvim.log.level = "info"
lvim.format_on_save = {
  enabled = true,
  pattern = "*.lua",
  timeout = 1000,
}
-- to disable icons and use a minimalist setup, uncomment the following
-- lvim.use_icons = false

-- keymappings <https://www.lunarvim.org/docs/configuration/keybindings>
lvim.leader = "space"
-- add your own keymapping
lvim.keys.normal_mode["<C-s>"] = ":w<cr>"

-- lvim.keys.normal_mode["<S-l>"] = ":BufferLineCycleNext<CR>"
-- lvim.keys.normal_mode["<S-h>"] = ":BufferLineCyclePrev<CR>"

-- -- Use which-key to add extra bindings with the leader-key prefix
-- lvim.builtin.which_key.mappings["W"] = { "<cmd>noautocmd w<cr>", "Save without formatting" }
-- lvim.builtin.which_key.mappings["P"] = { "<cmd>Telescope projects<CR>", "Projects" }

-- -- Change theme settings
-- lvim.colorscheme = "lunar"

lvim.builtin.alpha.active = true
lvim.builtin.alpha.mode = "dashboard"
lvim.builtin.terminal.active = true
lvim.builtin.nvimtree.setup.view.side = "left"
lvim.builtin.nvimtree.setup.renderer.icons.show.git = false

-- Automatically install missing parsers when entering buffer
lvim.builtin.treesitter.auto_install = true

-- lvim.builtin.treesitter.ignore_install = { "haskell" }

-- -- always installed on startup, useful for parsers without a strict filetype
-- lvim.builtin.treesitter.ensure_installed = { "comment", "markdown_inline", "regex" }

-- -- generic LSP settings <https://www.lunarvim.org/docs/languages#lsp-support>

-- --- disable automatic installation of servers
-- lvim.lsp.installer.setup.automatic_installation = false

-- ---configure a server manually. IMPORTANT: Requires `:LvimCacheReset` to take effect
-- ---see the full default list `:lua =lvim.lsp.automatic_configuration.skipped_servers`
-- vim.list_extend(lvim.lsp.automatic_configuration.skipped_servers, { "pyright" })
-- local opts = {} -- check the lspconfig documentation for a list of all possible options
-- require("lvim.lsp.manager").setup("pyright", opts)

-- ---remove a server from the skipped list, e.g. eslint, or emmet_ls. IMPORTANT: Requires `:LvimCacheReset` to take effect
-- ---`:LvimInfo` lists which server(s) are skipped for the current filetype
-- lvim.lsp.automatic_configuration.skipped_servers = vim.tbl_filter(function(server)
--   return server ~= "emmet_ls"
-- end, lvim.lsp.automatic_configuration.skipped_servers)

-- -- you can set a custom on_attach function that will be used for all the language servers
-- -- See <https://github.com/neovim/nvim-lspconfig#keybindings-and-completion>
-- lvim.lsp.on_attach_callback = function(client, bufnr)
--   local function buf_set_option(...)
--     vim.api.nvim_buf_set_option(bufnr, ...)
--   end
--   --Enable completion triggered by <c-x><c-o>
--   buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")
-- end

-- -- linters and formatters <https://www.lunarvim.org/docs/languages#lintingformatting>
-- local formatters = require "lvim.lsp.null-ls.formatters"
-- formatters.setup {
--   { command = "stylua" },
--   {
--     command = "prettier",
--     extra_args = { "--print-width", "100" },
--     filetypes = { "typescript", "typescriptreact" },
--   },
-- }
-- local linters = require "lvim.lsp.null-ls.linters"
-- linters.setup {
--   { command = "flake8", filetypes = { "python" } },
--   {
--     command = "shellcheck",
--     args = { "--severity", "warning" },
--   },
-- }

-- -- Additional Plugins <https://www.lunarvim.org/docs/plugins#user-plugins>
-- lvim.plugins = {
--     {
--       "folke/trouble.nvim",
--       cmd = "TroubleToggle",
--     },
-- }

-- -- Autocommands (`:help autocmd`) <https://neovim.io/doc/user/autocmd.html>
-- vim.api.nvim_create_autocmd("FileType", {
--   pattern = "zsh",
--   callback = function()
--     -- let treesitter use bash highlight for zsh files as well
--     require("nvim-treesitter.highlight").attach(0, "bash")
--   end,
-- })
--
--
--  ------------------------
--

--- disable automatic installation of servers
lvim.lsp.installer.setup.automatic_installation = false

lvim.format_on_save = true

lvim.builtin.treesitter.ensure_installed = {
  "javascript",
  "json",
  "lua",
  "typescript",
  "tsx",
  "css",
  "elixir",
  "heex",
}

lvim.lsp.installer.setup.ensure_installed = {
  "lua_ls",
  "cssls",
  "tsserver",
  "tailwindcss",
}

local tailwindcss_lsp_opts = {
  root_dir = require("lspconfig.util").root_pattern("assets/tailwind.config.js", "tailwind.config.js",
    "tailwind.config.cjs", "tailwind.js",
    "tailwind.cjs"),
  init_options = {
    userLanguages = { heex = "html", elixir = "html" }
  },
}

require("lvim.lsp.manager").setup("tailwindcss", tailwindcss_lsp_opts)


-- Don't allow Mason to handle elixir-ls
vim.list_extend(lvim.lsp.automatic_configuration.skipped_servers, { "elixirls" })

-- Additional Plugins
elixir_ls_base_opts = {
  tag = "v0.16.0",
  -- branch = "master",
}

lvim.plugins = {
  {
    -- use "mhanberg/elixir.nvim" if you don't need the debugger
    "ThePrimeagen/harpoon",
    --- "tiberiuc/elixir.nvim", branch = "add-support-for-dap-debugger-path",
    dependencies = { "nvim-lua/plenary.nvim" },
  },
  {
    -- use "mhanberg/elixir.nvim" if you don't need the debugger
    "mhanberg/elixir.nvim",
    --- "tiberiuc/elixir.nvim", branch = "add-support-for-dap-debugger-path",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      local elixir = require("elixir")
      local elixirls = require("elixir.elixirls")
      local opts = {
        capabilities = require("lvim.lsp").common_capabilities(),
        on_attach = require("lvim.lsp").common_on_attach,
        on_init = require("lvim.lsp").common_on_init,
        settings = elixirls.settings({
          dialyzerEnabled = true,
          fetchDeps = false,
          enableTestLenses = true,
          suggestSpecs = true,
        }),
      }
      opts = vim.tbl_extend("keep", elixir_ls_base_opts, opts)
      opts = {
        credols = { enabled = false },
        elixirls = opts
      }
      elixir.setup(opts)
    end,
  },
  { "LunarVim/peek.lua" },
  { "lunarvim/darkplus.nvim" },
  {
    "nvim-telescope/telescope-live-grep-args.nvim",
    -- This will not install any breaking changes.
    -- For major updates, this must be adjusted manually.
    version = "^1.0.0",
  },
}

lvim.builtin.which_key.mappings["E"] = {
  name = "Elixir",
  p = {
    name = "Pipe",
    f = { "<cmd>ElixirFromPipe<Cr>", "Convert pipe operator to function call" },
    t = { "<cmd>ElixirToPipe<cr>", "Convert function call to pipe operator" },
  },
  m = { "<cmd>ElixirExpandMacro<Cr>", "Expand macro" },
  o = { "<cmd>ElixirOutputPanel<Cr>", "Show Elixir output panel" },
  r = { "<cmd>ElixirRestart<Cr>", "Restart LSP" },
}


-- -- DAP configuration
-- local dap = require('dap')

-- dap.adapters.mix_task = {
--   type = 'executable',
--   command = require("elixir.language_server").debugger_path(elixir_ls_base_opts),
--   args = {}
-- }

-- dap.configurations.elixir = {
--   {
--     type = "mix_task",
--     name = "mix test",
--     task = 'test',
--     taskArgs = { "--trace" },
--     request = "launch",
--     startApps = true, -- for Phoenix projects
--     projectDir = "${workspaceFolder}",
--     requireFiles = {
--       "test/**/test_helper.exs",
--       "test/**/*_test.exs"
--     }
--   },
-- }

local opts_peek = { noremap = true, silent = true }
vim.api.nvim_set_keymap("n", "gp", ":lua require('peek').Peek('definition')<CR>", opts_peek)

lvim.builtin.which_key.mappings["s"]["T"] = {
  require("telescope").extensions.live_grep_args.live_grep_args, "Search" }


lvim.builtin.which_key.mappings["s"]["m"] = {
  ":lua require(\"harpoon.ui\").toggle_quick_menu()<CR>", "Harpoon" }
lvim.builtin.which_key.mappings["s"]["a"] = {
  ":lua require(\"harpoon.mark\").add_file()<CR>", "Harpoon mark file" }
lvim.builtin.which_key.mappings["s"]["x"] = {
  ":lua require(\"harpoon.mark\").rm_file()<CR>", "Harpoon un-mark file" }

vim.api.nvim_set_keymap("n", "gj", ":lua require(\"harpoon.ui\").nav_prev()<CR>", {})
vim.api.nvim_set_keymap("n", "gk", ":lua require(\"harpoon.ui\").nav_next()<CR>", {})

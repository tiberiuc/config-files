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

-- keymappings <https://www.lunarvim.org/docs/configuration/keybindings>
lvim.leader = "space"
-- add your own keymapping
lvim.keys.normal_mode["<C-s>"] = ":w<cr>"

-- -- Change theme settings
-- lvim.colorscheme = "lunar"

lvim.builtin.alpha.active = true
lvim.builtin.alpha.mode = "dashboard"
lvim.builtin.terminal.active = true
lvim.builtin.nvimtree.setup.view.side = "left"
lvim.builtin.nvimtree.setup.renderer.icons.show.git = false

-- Automatically install missing parsers when entering buffer
lvim.builtin.treesitter.auto_install = true


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
  tag = "v0.17.2",
  -- branch = "master",
}

lvim.plugins = {
  {
    "ThePrimeagen/harpoon",
    dependencies = { "nvim-lua/plenary.nvim" },
  },
  {
    "mhanberg/elixir.nvim",
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

return {
  {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.8',
    -- or                              , branch = '0.1.x',
    dependencies = { 'nvim-lua/plenary.nvim',
      { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
      { "smartpde/telescope-recent-files" },
      {
        "nvim-telescope/telescope-live-grep-args.nvim",
        -- This will not install any breaking changes.
        -- For major updates, this must be adjusted manually.
        version = "^1.0.0",
      },
    },
    config = function()
      require('telescope').setup({
        extensions = {
          fzf = {}
        }
      })
      require("telescope").load_extension("fzf")
      require("telescope").load_extension("recent_files")
      local builtin = require('telescope.builtin')
      local ivy = require('telescope.themes').get_ivy()
      vim.keymap.set('n', '<leader>ff', function() builtin.find_files(ivy) end, { desc = 'Telescope find files' })
      vim.keymap.set('n', '<leader>fg', function() builtin.live_grep(ivy) end, { desc = 'Telescope live grep' })
      vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
      vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })
      vim.keymap.set('n', '<leader>fF', function() require("telescope").extensions.live_grep_args.live_grep_args(ivy) end,
        { desc = "Advance searc ex: \"Repo\" --iglob *.exs " })
      vim.api.nvim_set_keymap("n", "<Leader>fr",
        [[<cmd>lua require('telescope').extensions.recent_files.pick()<CR>]],
        { noremap = true, silent = true, desc = "Telescope recent files" })
    end
  }

}

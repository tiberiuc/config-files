return {
  {
    'echasnovski/mini.nvim',
    config = function()
      local statusline = require 'mini.statusline'
      statusline.setup { use_icons = true,
      }
      require('mini.git').setup({})
      require('mini.icons').setup({})
      local mini_files = require('mini.files')
      vim.keymap.set('n', '<space>e', function() mini_files.open(mini_files.get_latest_path()) end)
      -- vim.keymap.set('n', '<space>e', function() mini_files.open() end)
      vim.keymap.set('n', '<space>E', function() mini_files.open(vim.api.nvim_buf_get_name(0)) end)
    end
  }
}

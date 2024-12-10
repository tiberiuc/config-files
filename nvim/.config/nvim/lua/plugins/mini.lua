return {
  {
    'echasnovski/mini.nvim',
    config = function()
      local statusline = require 'mini.statusline'
      statusline.setup { use_icons = true,
      }
      require('mini.git').setup({})
      require('mini.icons').setup({})
      vim.keymap.set('n', '<space>e', function() require('mini.files').open() end)
    end
  }
}

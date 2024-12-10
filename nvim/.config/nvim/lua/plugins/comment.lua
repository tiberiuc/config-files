return {
  {
    'numToStr/Comment.nvim',
    opts = {

    },
    config = function()
      require('Comment').setup()
      local wk = require "which-key"
      wk.add { { "<leader>/", "<Plug>(comment_toggle_linewise_current)", desc = "Comment" } }
      wk.add { { "<leader>/", "<Plug>(comment_toggle_linewise_visual)", desc = "Comment", mode = "v" } }
    end
  }
}

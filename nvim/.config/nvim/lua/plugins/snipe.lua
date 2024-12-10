return {
  "leath-dub/snipe.nvim",
  keys = {
    { "t", function() require("snipe").open_buffer_menu() end, desc = "Open Snipe buffer menu" }
  },
  opts = {},
}

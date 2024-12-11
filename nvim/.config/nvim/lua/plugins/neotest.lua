return {
  {
    "nvim-neotest/neotest",
    dependencies = {
      "nvim-neotest/neotest-plenary",
      "nvim-neotest/nvim-nio",
      "jfpedroza/neotest-elixir",
    },
    config = function()
      require("neotest").setup({
        adapters = {
          require("neotest-elixir"),
        }

      })
      vim.keymap.set("n", "<leader>tt", ':lua require("neotest").run.run() <CR>', {})
      vim.keymap.set("n", "<leader>tc", ':lua require("neotest").run.stop() <CR>', {})
      vim.keymap.set("n", "<leader>ta", ':lua require("neotest").run.run(vim.fn.expand("%")) <CR>', {})
      vim.keymap.set("n", "<leader>to", ':lua require("neotest").output.open() <CR>', {})
      vim.keymap.set("n", "<leader>ts", ':lua require("neotest").summary.toggle() <CR>', {})
    end
  }
}

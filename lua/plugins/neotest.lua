return {
  "nvim-neotest/neotest",
  lazy = true,
  dependencies = {
    "nvim-neotest/nvim-nio",
    "nvim-lua/plenary.nvim",
    "antoinemadec/FixCursorHold.nvim",
    "nvim-treesitter/nvim-treesitter",
    "nvim-neotest/neotest-go",
    "nvim-neotest/neotest-python",
    "marilari88/neotest-vitest",
  },
  config = function()
    require("neotest").setup({
      floating = {
        border = "rounded",
      },
      adapters = {
        require("neotest-go"),
        require("neotest-python"),
        require("neotest-vitest"),
      },
    })
  end,
}

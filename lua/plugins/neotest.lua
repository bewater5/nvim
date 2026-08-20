return {
  "nvim-neotest/neotest",
  dependencies = {
    "nvim-neotest/nvim-nio",
    "nvim-lua/plenary.nvim",
    "antoinemadec/FixCursorHold.nvim",
    "nvim-treesitter/nvim-treesitter",
    "nvim-neotest/neotest-go",
    "nvim-neotest/neotest-python",
    "marilari88/neotest-vitest",
  },
  keys = {
    {
      "<leader>tr",
      function()
        require("neotest").run.run()
      end,
      desc = "运行最近的测试",
    },
    {
      "<leader>tR",
      function()
        require("neotest").run.run(vim.fn.expand("%"))
      end,
      desc = "运行当前文件测试",
    },
    {
      "<leader>ta",
      function()
        require("neotest").run.run(vim.fn.getcwd())
      end,
      desc = "运行项目全部测试",
    },
    {
      "<leader>ts",
      function()
        require("neotest").summary.toggle()
      end,
      desc = "切换测试摘要",
    },
    {
      "<leader>te",
      function()
        require("neotest").output.open({ enter = true })
      end,
      desc = "查看测试输出",
    },
    {
      "<leader>tp",
      function()
        require("neotest").output_panel.toggle()
      end,
      desc = "切换测试输出面板",
    },
    {
      "<leader>tx",
      function()
        require("neotest").run.stop()
      end,
      desc = "停止测试",
    },
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

-- LSP 配置主入口文件
return {
  -- LSP配置
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "mason-org/mason.nvim",
      "mason-org/mason-lspconfig.nvim",
      { "saghen/blink.cmp", version = "1.*" },
      "L3MON4D3/LuaSnip",
    },
    config = function()
      -- 按顺序加载各个模块
      require("plugins.lsp.mason").setup()
      require("plugins.lsp.cmp").setup()
      require("plugins.lsp.servers").setup()
      require("plugins.lsp.utils").setup()
    end,
  },
}

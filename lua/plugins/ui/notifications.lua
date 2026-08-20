-- 通知系统配置 (noice)
-- 通知弹窗由 snacks.notifier 渲染（noice notify 视图的默认后端）
return {
  "folke/noice.nvim",
  event = "VeryLazy",
  dependencies = {
    "MunifTanjim/nui.nvim",
  },
  config = function()
    require("noice").setup({
      lsp = {
        -- override markdown rendering so that plugins use **Treesitter**
        override = {
          ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
          ["vim.lsp.util.stylize_markdown"] = true,
        },
      },
      -- 过滤消息路由
      routes = {
        -- 完全跳过文件写入相关的消息
        {
          filter = {
            event = "msg_show",
            any = {
              { find = "%d+L, %d+B" },
              { find = "written" },
              { find = '".*" %d+L, %d+B' },
            },
          },
          opts = { skip = true },
        },
      },
      -- 右下角的 LSP 加载进度使用 mini 视图
      views = {
        mini = {
          border = {
            style = "rounded",
            padding = { 0, 1 },
          },
          win_options = {
            winblend = 0,
            winhighlight = {
              Normal = "NoiceMini",
              FloatBorder = "FloatBorder",
            },
          },
        },
      },
      presets = {
        bottom_search = true, -- use a classic bottom cmdline for search
        long_message_to_split = true, -- long messages will be sent to a split
        lsp_doc_border = true, -- add a border to hover docs and signature help
      },
    })
  end,
}

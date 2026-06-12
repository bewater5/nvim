-- 通知系统配置 (noice，通知弹窗渲染由 snacks.notifier 接管)
return {
  "folke/noice.nvim",
  event = "VeryLazy",
  dependencies = {
    "MunifTanjim/nui.nvim",
  },
  config = function()
    -- noice 配置（notify 视图默认后端为 { "snacks", "notify" }，自动走 snacks.notifier）
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
      presets = {
        bottom_search = true, -- use a classic bottom cmdline for search
        long_message_to_split = true, -- long messages will be sent to a split
        lsp_doc_border = true, -- add a border to hover docs and signature help
      },
    })
    -- 诊断配置已移至 lua/plugins/lsp/utils.lua 统一管理
  end,
}

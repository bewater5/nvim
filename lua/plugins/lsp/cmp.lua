-- blink.cmp 自动补全配置
local M = {}

function M.setup()
  require("blink.cmp").setup({
    -- enter 预设：<CR> 确认，<C-n>/<C-p> 选择，<Tab>/<S-Tab> 片段跳转，
    -- <C-space> 手动触发，<C-e> 关闭，<C-b>/<C-f> 滚动文档，<C-k> 签名提示
    keymap = { preset = "enter" },

    -- LuaSnip 作为片段引擎
    snippets = { preset = "luasnip" },

    completion = {
      -- 预选中第一项但不自动插入，<CR> 确认后才上屏
      list = {
        selection = { preselect = true, auto_insert = false },
      },
      menu = {
        border = "rounded",
        winhighlight = "Normal:NormalFloat,FloatBorder:FloatBorder,CursorLine:Visual,Search:None",
      },
      documentation = {
        auto_show = true,
        window = { border = "rounded" },
      },
    },

    sources = {
      default = { "lsp", "snippets", "buffer", "path" },
    },
  })
end

return M

-- LSP 工具函数和自动命令
local M = {}
local colors = require("core.colors")

function M.setup()
  -- 🔧 自动关闭 Location List 和 Quickfix List
  vim.api.nvim_create_autocmd("BufWinEnter", {
    group = vim.api.nvim_create_augroup("AutoCloseLocationList", { clear = true }),
    pattern = "*",
    callback = function()
      -- 当跳转到新缓冲区时，自动关闭 location list 和 quickfix list
      if vim.bo.buftype == "" then  -- 只在普通文件缓冲区中执行
        vim.schedule(function()
          vim.cmd("silent! lclose") -- 关闭 location list
          vim.cmd("silent! cclose") -- 关闭 quickfix list
        end)
      end
    end,
  })

  -- 🎨 自定义诊断标识
  vim.diagnostic.config({
    signs = {
      text = {
        [vim.diagnostic.severity.ERROR] = "✗",
        [vim.diagnostic.severity.WARN] = "▶",
        [vim.diagnostic.severity.HINT] = "▶",
        [vim.diagnostic.severity.INFO] = "▶",
      },
    },
    virtual_text = false,     -- 虚拟文本
    update_in_insert = true, -- 插入模式下更新诊断
    severity_sort = true,     -- 按严重程度排序
    float = {
      border = "rounded",
      close_events = { "BufLeave", "CursorMoved", "InsertEnter" },
      -- 使用统一的颜色配置
      style = "minimal",
      header = "",
      prefix = "",
      suffix = "",
      source = "always", -- 显示诊断来源
    },
  })

  -- 🎨 设置诊断浮窗颜色高亮组
  vim.schedule(function()
    -- 诊断浮窗背景和边框
    vim.cmd(
      string.format(
        [[
      highlight! DiagnosticFloatNormal guibg=%s guifg=%s
      highlight! DiagnosticFloatBorder guifg=%s guibg=%s
      highlight! DiagnosticFloatTitle guifg=%s guibg=%s gui=bold
    ]],
        colors.diagnostic.float_bg,
        colors.palette.fg_main,
        colors.diagnostic.float_border,
        colors.diagnostic.float_bg,
        colors.diagnostic.title,
        colors.diagnostic.float_bg
      )
    )

    -- 诊断文本颜色
    vim.cmd(
      string.format(
        [[
      highlight! DiagnosticError guifg=%s
      highlight! DiagnosticWarn guifg=%s
      highlight! DiagnosticInfo guifg=%s
      highlight! DiagnosticHint guifg=%s
    ]],
        colors.diagnostic.error_text,
        colors.diagnostic.warning_text,
        colors.diagnostic.info_text,
        colors.diagnostic.hint_text
      )
    )

    -- 诊断符号颜色
    -- 背景须跟随 colors.bg_color：noice 边框/图标组默认链接到 DiagnosticSign*
    vim.cmd(
      string.format(
        [[
      highlight! DiagnosticSignError guifg=%s guibg=%s
      highlight! DiagnosticSignWarn guifg=%s guibg=%s
      highlight! DiagnosticSignInfo guifg=%s guibg=%s
      highlight! DiagnosticSignHint guifg=%s guibg=%s
    ]],
        colors.diagnostic.error_sign,
        colors.bg_color,
        colors.diagnostic.warning_sign,
        colors.bg_color,
        colors.diagnostic.info_sign,
        colors.bg_color,
        colors.diagnostic.hint_sign,
        colors.bg_color
      )
    )
  end)
end

return M

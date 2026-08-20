local colors = require('core.colors')

return {
  "Shatur/neovim-ayu",
  lazy = false,
  priority = 1000,
  config = function()
    require("ayu").setup({
      overrides = {
        -- 背景统一引用 colors.bg_color（"NONE" 时透明，透明度由终端模拟器控制）
        Normal = {
          bg = colors.bg_color,
        },
        NormalNC = {
          bg = colors.bg_color,
        },
        -- 搜索命中只加亮文字，不涂背景
        Search = {
          bg = "NONE",
          fg = colors.palette.fg_bright,
          bold = true,
        },
        IncSearch = {
          bg = "NONE",
          fg = colors.palette.fg_bright,
          bold = true,
        },
        CurSearch = {
          bg = "NONE",
          fg = colors.palette.fg_bright,
          bold = true,
        },
        CursorLine = {
          bg = colors.palette.bg_cursor,
        },
        CursorColumn = {
          bg = colors.palette.bg_cursor,
        },
        Visual = {
          bg = colors.palette.bg_light,
        },
        LineNr = {
          fg = colors.palette.fg_dim,
          bg = colors.bg_color,
        },
        -- 当前行行号与光标行背景保持一致
        CursorLineNr = {
          fg = colors.palette.fg_bright,
          bg = colors.palette.bg_cursor,
          bold = true,
        },
        SignColumn = {
          fg = colors.palette.fg_dark,
          bg = colors.bg_color,
        },
        WinSeparator = {
          fg = colors.semantic.separator,
          bg = "NONE",
        },
        FoldColumn = {
          fg = colors.palette.fg_dim,
          bg = colors.bg_color,
        },
        -- 原生补全/命令行补全菜单
        Pmenu = {
          fg = colors.palette.fg_main,
          bg = colors.bg_color,
        },
        -- 标签栏/状态栏基底组：bufferline 与 lualine 的高亮组
        -- 缺背景时回退到这里，不透明会让整条栏带色
        TabLineFill = {
          bg = colors.bg_color,
        },
        TabLine = {
          bg = colors.bg_color,
        },
        StatusLine = {
          bg = colors.bg_color,
        },
        StatusLineNC = {
          bg = colors.bg_color,
        },

        -- 浮窗（诊断、hover、补全文档等）
        NormalFloat = {
          fg = colors.palette.fg_main,
          bg = colors.diagnostic.float_bg,
        },
        FloatBorder = {
          fg = colors.diagnostic.float_border,
          bg = colors.diagnostic.float_bg,
        },
        DiagnosticError = {
          fg = colors.diagnostic.error_text,
        },
        DiagnosticWarn = {
          fg = colors.diagnostic.warning_text,
        },
        DiagnosticInfo = {
          fg = colors.diagnostic.info_text,
        },
        DiagnosticHint = {
          fg = colors.diagnostic.hint_text,
        },
        DiagnosticSignError = {
          fg = colors.diagnostic.error_sign,
          bg = colors.bg_color,
        },
        DiagnosticSignWarn = {
          fg = colors.diagnostic.warning_sign,
          bg = colors.bg_color,
        },
        DiagnosticSignInfo = {
          fg = colors.diagnostic.info_sign,
          bg = colors.bg_color,
        },
        DiagnosticSignHint = {
          fg = colors.diagnostic.hint_sign,
          bg = colors.bg_color,
        },
        -- 光标停留时突出同一 LSP 符号的文本、读取与写入位置
        LspReferenceText = {
          underline = true,
        },
        LspReferenceRead = {
          underline = true,
        },
        LspReferenceWrite = {
          underline = true,
          bold = true,
        },
      },
    })
    vim.cmd("colorscheme ayu")
  end,
}

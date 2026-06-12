local colors = require('core.colors')

return {
  "Shatur/neovim-ayu",
  lazy = false,
  priority = 1000,
  config = function()
    require("ayu").setup({
      overrides = {
        -- 透明背景：不绘制背景色，透出终端背景（透明度由终端模拟器控制）
        -- 统一引用 colors.transparent，恢复不透明时只需改 core/colors.lua 一处
        Normal = {
          bg = colors.transparent,
        },
        NormalNC = {
          bg = colors.transparent,
        },
        -- 搜索颜色
        Search = {
          bg = "NONE",                -- 透明背景
          fg = colors.palette.fg_bright, -- 白色文字
          bold = true,
        },
        IncSearch = {
          bg = "None",
          fg = colors.palette.fg_bright,
          bold = true,
        },
        CurSearch = {
          bg = "None",
          fg = colors.palette.fg_bright,
          bold = true,
        },
        -- 编辑器光标行
        CursorLine = {
          bg = colors.palette.bg_cursor,
        },
        -- 光标列颜色
        CursorColumn = {
          bg = colors.palette.bg_cursor,
        },
        -- 可视选择颜色
        Visual = {
          bg = colors.palette.bg_light,
        },
        -- 普通行号
        LineNr = {
          fg = colors.palette.fg_dim, -- 使用次要文字颜色
          bg = colors.transparent,    -- 与主背景一致（透明）
        },
        -- 当前行行号（光标所在行）
        CursorLineNr = {
          fg = colors.palette.fg_bright, -- 使用高亮文字颜色
          bg = colors.palette.bg_cursor, -- 与光标行背景一致
          bold = true,                   -- 加粗突出
        },
        -- 标志列（行号左边的竖线区域）
        SignColumn = {
          fg = colors.palette.fg_dark, -- 标志前景色
          bg = colors.transparent,     -- 与主背景一致（透明）
        },
        -- 窗口分界线
        WinSeparator = {
          fg = colors.semantic.separator, -- 使用统一的分隔符颜色
          bg = "NONE",                    -- 透明背景
        },
        -- 折叠列
        FoldColumn = {
          fg = colors.palette.fg_dim,
          bg = colors.transparent,
        },
        -- 原生补全/命令行补全菜单
        Pmenu = {
          fg = colors.palette.fg_main,
          bg = colors.transparent,
        },

        -- ========== 诊断浮窗颜色覆盖 ==========
        -- 诊断浮窗背景
        NormalFloat = {
          fg = colors.palette.fg_main,
          bg = colors.diagnostic.float_bg,
        },
        -- 诊断浮窗边框
        FloatBorder = {
          fg = colors.diagnostic.float_border,
          bg = colors.diagnostic.float_bg,
        },
        -- 诊断错误颜色
        DiagnosticError = {
          fg = colors.diagnostic.error_text,
        },
        -- 诊断警告颜色
        DiagnosticWarn = {
          fg = colors.diagnostic.warning_text,
        },
        -- 诊断信息颜色
        DiagnosticInfo = {
          fg = colors.diagnostic.info_text,
        },
        -- 诊断提示颜色
        DiagnosticHint = {
          fg = colors.diagnostic.hint_text,
        },
        -- 诊断符号颜色
        DiagnosticSignError = {
          fg = colors.diagnostic.error_sign,
          bg = colors.transparent,
        },
        DiagnosticSignWarn = {
          fg = colors.diagnostic.warning_sign,
          bg = colors.transparent,
        },
        DiagnosticSignInfo = {
          fg = colors.diagnostic.info_sign,
          bg = colors.transparent,
        },
        DiagnosticSignHint = {
          fg = colors.diagnostic.hint_sign,
          bg = colors.transparent,
        },
      },
    })
    vim.cmd("colorscheme ayu")

    -- bufferline 文件树偏移区的标题样式（NvimTree 颜色覆盖已随插件移除）
    vim.cmd(string.format(
      [[:hi FileExplorerTitle guibg=%s guifg=%s gui=bold]],
      colors.transparent,
      colors.semantic.folder
    ))
  end,
}

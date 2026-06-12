-- 🎨 统一颜色管理：全配置的颜色值都从这里取
-- 只保留实际被引用的定义，每项注明用在哪里；新增颜色优先复用 palette

local M = {}

-- ========== 基础调色板 ==========
-- 基于 Ayu 主题
M.palette = {
  -- 背景色系
  bg_main = "#1c1c1c",   -- bg_color 恢复不透明时的取值
  bg_light = "#1f2430",  -- Visual 选区
  bg_cursor = "#202020", -- 光标行/列、当前行号

  -- 前景色系
  fg_main = "#bfbdb6",   -- 正文、Pmenu、浮窗文字
  fg_dim = "#5c6773",    -- 行号、折叠列、bufferline 次要文字
  fg_bright = "#ffffff", -- 搜索命中、当前行号、bufferline 活动文字、诊断标题
  fg_muted = "#808080",  -- bufferline 非活动标签文字
  fg_dark = "#3e4451",   -- 标志列
  border = "#2c313c",    -- 浮窗边框、窗口分隔线

  -- Ayu 主题色
  blue = "#39bae6",   -- semantic.info / semantic.folder
  yellow = "#ffb454", -- semantic.warning、bufferline 修改指示
  orange = "#ff8f40", -- bufferline 修改/关闭按钮
  red = "#f07178",    -- semantic.error
  cyan = "#95e6cb",   -- semantic.hint
}

-- ========== 统一背景色 ==========
-- 编辑区/浮窗/菜单背景的单一开关：
-- "NONE" 为透明（透出终端背景），改回色值（如 M.palette.bg_main）即恢复不透明
M.bg_color = "NONE"

-- ========== 语义化颜色 ==========
M.semantic = {
  -- 诊断四级：diagnostic 表、bufferline 诊断指示
  error = M.palette.red,
  warning = M.palette.yellow,
  info = M.palette.blue,
  hint = M.palette.cyan,

  folder = M.palette.blue,      -- FileExplorerTitle（colorscheme.lua）
  separator = M.palette.border, -- WinSeparator（colorscheme.lua）
}

-- ========== 组件颜色 ==========

-- 状态栏（ui/statusline.lua），a 段为 ayu 主题自带的模式色块
M.lualine = {
  bg = M.palette.bg_cursor,        -- c 段（中段）背景
  section_bg = M.palette.bg_light, -- b 段（分支/diff）背景
}

-- 缓冲区标签（ui/bufferline.lua）
-- 背景全透明，活动标签靠亮色文字 + 橙色下划线区分
M.bufferline = {
  fill_bg = M.bg_color,
  active_bg = M.bg_color,
  inactive_bg = M.bg_color,
  visible_bg = M.bg_color,
  inactive_fg = M.palette.fg_muted,
}

-- 诊断浮窗与符号（colorscheme.lua、lsp/utils.lua）
M.diagnostic = {
  float_bg = M.bg_color,
  float_border = M.palette.border,
  title = M.palette.fg_bright,

  -- 浮窗内文本
  error_text = M.semantic.error,
  warning_text = M.semantic.warning,
  info_text = M.semantic.info,
  hint_text = M.semantic.hint,

  -- 行号列符号
  error_sign = M.semantic.error,
  warning_sign = M.semantic.warning,
  info_sign = M.semantic.info,
  hint_sign = M.semantic.hint,
}

return M

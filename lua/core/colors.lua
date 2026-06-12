-- ========================================
-- 🎨 统一颜色管理 (Colors Management)
-- ========================================
-- 此文件统一管理整个 Neovim 配置中使用的所有颜色值，便于维护和主题切换
-- 文件内只保留实际被引用的定义，新增颜色时优先复用 palette

local M = {}

-- ========== 基础调色板 (Base Palette) ==========
-- 基于 Ayu 主题的核心颜色
M.palette = {
  -- 背景色系
  bg_main = "#1c1c1c",   -- 主背景色（bg_color 恢复不透明时的取值）
  bg_light = "#1f2430",  -- 稍亮背景（可视选区、活动标签、lualine b 段）
  bg_alt = "#181818",    -- 替代背景色（非活动标签）
  bg_cursor = "#202020", -- 光标行/列背景

  -- 前景色系
  fg_main = "#bfbdb6",   -- 主要文字颜色
  fg_dim = "#5c6773",    -- 次要文字颜色（行号、折叠列）
  fg_bright = "#ffffff", -- 高亮文字颜色
  fg_muted = "#808080",  -- 静音文字颜色（非活动标签文字）
  fg_dark = "#3e4451",   -- 深色文字（边框、分隔线、标志列）

  -- Ayu 主题色
  blue = "#39bae6",
  green = "#c2d94c",
  yellow = "#ffb454",
  orange = "#ff8f40",
  red = "#f07178",
  purple = "#d2a6ff",
  cyan = "#95e6cb",
}

-- ========== 统一背景色 (Background Color) ==========
-- 编辑区/浮窗/菜单等的背景统一引用此变量：
-- "NONE" 为透明（透出终端背景），改回色值（如 M.palette.bg_main）即可一键恢复不透明
M.bg_color = "NONE"

-- ========== 语义化颜色 (Semantic Colors) ==========
-- 基于用途的颜色定义，便于理解和使用
M.semantic = {
  -- 诊断状态
  error = M.palette.red,
  warning = M.palette.yellow,
  info = M.palette.blue,
  hint = M.palette.cyan,

  -- UI 元素
  folder = M.palette.blue,        -- 文件夹/文件浏览器标题
  separator = M.palette.fg_dark,  -- 窗口分隔线
}

-- ========== 组件颜色配置 (Component Colors) ==========

-- Lualine 颜色主题
M.lualine = {
  bg = M.bg_color,                 -- 状态栏中段背景（跟随统一背景色，透明）
  section_bg = M.palette.bg_light, -- b 段背景（分支/diff 等，柔和深灰蓝）
}

-- Bufferline 颜色配置
M.bufferline = {
  fill_bg = M.palette.bg_main,      -- 整体背景
  active_bg = M.palette.bg_light,   -- 活动标签背景
  inactive_bg = M.palette.bg_alt,   -- 非活动标签背景
  inactive_fg = M.palette.fg_muted, -- 非活动标签文字
}

-- 诊断浮窗颜色配置
M.diagnostic = {
  -- 浮窗背景和边框
  float_bg = M.bg_color,            -- 浮窗背景色（随统一背景色）
  float_border = M.palette.fg_dark, -- 浮窗边框色
  title = M.palette.fg_bright,      -- 浮窗标题颜色

  -- 诊断文本颜色
  error_text = M.semantic.error,
  warning_text = M.semantic.warning,
  info_text = M.semantic.info,
  hint_text = M.semantic.hint,

  -- 诊断符号颜色（行号列的符号）
  error_sign = M.semantic.error,
  warning_sign = M.semantic.warning,
  info_sign = M.semantic.info,
  hint_sign = M.semantic.hint,
}

return M

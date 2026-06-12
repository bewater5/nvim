-- UI 插件统一入口
-- 将原来的大文件拆分为多个功能模块

return {
  -- 状态栏
  require("plugins.ui.statusline"),

  -- 缓冲区标签
  require("plugins.ui.bufferline"),

  -- 文件浏览器已由 snacks.nvim 的 explorer 模块接管（lua/plugins/snacks.lua）

  -- 通知系统
  require("plugins.ui.notifications"),

  -- UI 增强（dressing/indent-blankline 已由 snacks.nvim 的 input/picker/indent 模块接管）

  -- 启动屏幕
  -- require("plugins.ui.dashboard"),
}

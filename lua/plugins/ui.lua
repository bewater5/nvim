-- UI 插件统一入口
return {
  require("plugins.ui.statusline"),    -- 状态栏 (lualine)
  require("plugins.ui.bufferline"),    -- 缓冲区标签
  require("plugins.ui.notifications"), -- 通知/消息 (noice)
}

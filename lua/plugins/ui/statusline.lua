-- 状态栏配置 (lualine)
local colors = require("core.colors")

return {
  "nvim-lualine/lualine.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    local custom_theme = require("lualine.themes.ayu")
    -- 使用统一的颜色管理：所有模式统一处理
    -- c 段（中段）背景跟随 colors.bg_color（透明）
    -- b 段（分支/diff）背景从 ayu 默认的纯黑 #000000 柔和化
    for _, mode in pairs(custom_theme) do
      if type(mode) == "table" then
        if mode.b then
          mode.b.bg = colors.lualine.section_bg
        end
        if mode.c then
          mode.c.bg = colors.lualine.bg
        end
      end
    end

    require("lualine").setup({
      options = {
        theme = custom_theme,
        component_separators = { left = "", right = "" },
        section_separators = { left = "", right = "" },
        globalstatus = true, -- 只在最底部显示一条全局状态栏
      },
    })
  end,
}

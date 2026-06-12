-- 缓冲区标签配置 (bufferline)
local colors = require("core.colors")

return {
  "akinsho/bufferline.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  version = "*",
  config = function()
    require("bufferline").setup({
      options = {
        -- 强制启用诊断和状态显示
        diagnostics = "nvim_lsp",
        diagnostics_update_in_insert = false,

        -- 📈 标签尺寸和高度配置
        max_name_length = 18, -- 文件名最大长度

        mode = "buffers",
        separator_style = { "", "" },
        -- 启用底部高亮线指示器
        indicator = {
          icon = "", -- 不显示左侧指示器图标
          style = "underline", -- 使用下划线样式
        },
        -- 关闭按钮配置
        show_buffer_close_icons = false, -- 隐藏缓冲区关闭按钮
        show_close_icon = false, -- 隐藏右侧关闭按钮
        -- 其他配置
        show_tab_indicators = true, -- 显示标签指示器
        show_duplicate_prefix = true, -- 显示重复文件名前缀
        persist_buffer_sort = true, -- 持久化缓冲区排序
        always_show_bufferline = true, -- 始终显示 bufferline
        offsets = {
          {
            filetype = "snacks_layout_box",
            text = "📂 File Explorer",
            highlight = "FileExplorerTitle",
            text_align = "center",
            separator = false,
            padding = 1,
          },
        },
      },
      -- 使用统一的颜色管理
      highlights = {
        fill = {
          bg = colors.bufferline.fill_bg,
        },
        background = {
          fg = colors.bufferline.inactive_fg,
          bg = colors.bufferline.inactive_bg,
        },
        -- 普通活动标签（无状态）
        buffer_selected = {
          fg = colors.palette.fg_bright, -- 使用明亮的白色
          bg = colors.bufferline.active_bg,
          bold = true,
          underline = true,
          sp = colors.palette.orange,
        },
        buffer_visible = {
          fg = colors.palette.fg_muted,
          bg = colors.bufferline.visible_bg,
        },

        -- ========== 指示器配置 ==========
        -- 活动标签的指示器（底部线）
        indicator_selected = {
          fg = colors.palette.orange, -- 指示器颜色
          bg = colors.bufferline.active_bg,
          underline = true,
          sp = colors.palette.orange,
        },
        -- 可见标签的指示器
        indicator_visible = {
          fg = "None",
          bg = colors.bufferline.visible_bg,
        },
        modified = {
          fg = colors.semantic.warning,
          bg = colors.bufferline.inactive_bg,
        },
        modified_selected = {
          fg = colors.semantic.warning, -- 黄色表示修改
          bg = colors.bufferline.active_bg,
          underline = true,
          sp = colors.palette.orange, -- 统一的橙色底线
        },
        modified_visible = {
          fg = colors.semantic.warning,
          bg = colors.bufferline.visible_bg,
        },
        -- LSP 诊断颜色
        error = {
          fg = colors.semantic.error,
          bg = colors.bufferline.inactive_bg,
        },
        error_selected = {
          fg = colors.semantic.error, -- 红色表示错误
          bg = colors.bufferline.active_bg,
          underline = true,
          sp = colors.palette.orange, -- 统一的橙色底线
        },
        warning = {
          fg = colors.semantic.warning,
          bg = colors.bufferline.inactive_bg,
        },
        warning_selected = {
          fg = colors.palette.yellow, -- 使用更鲜明的黄色
          bg = colors.bufferline.active_bg,
          underline = true,
          sp = colors.palette.orange, -- 统一的橙色底线
        },
        info = {
          fg = colors.semantic.info,
          bg = colors.bufferline.inactive_bg,
        },
        info_selected = {
          fg = colors.semantic.info, -- 蓝色表示信息
          bg = colors.bufferline.active_bg,
          underline = true,
          sp = colors.palette.orange, -- 统一的橙色底线
        },
        hint = {
          fg = colors.semantic.hint,
          bg = colors.bufferline.inactive_bg,
        },
        hint_selected = {
          fg = colors.semantic.hint, -- 青色表示提示
          bg = colors.bufferline.active_bg,
          underline = true,
          sp = colors.palette.orange, -- 统一的橙色底线
        },
        duplicate_selected = {
          fg = colors.palette.fg_dim, -- 目录前缀使用较暗的颜色
          bg = colors.bufferline.active_bg, -- 与活动标签背景一致
          sp = colors.palette.orange,
        },
        duplicate_visible = {
          fg = colors.palette.fg_dim,
          bg = colors.bufferline.visible_bg,
          italic = true,
        },
        duplicate = {
          fg = colors.palette.fg_dim,
          bg = colors.bufferline.inactive_bg,
          italic = true,
        },
      },
    })

    -- 强制应用 bufferline 颜色配置
    vim.schedule(function()
      -- 确保颜色配置被正确应用
      vim.cmd([[
        highlight! BufferLineErrorSelected guifg=]] .. colors.semantic.error .. [[ gui=underline
        highlight! BufferLineWarningSelected guifg=]] .. colors.palette.yellow .. [[ gui=underline
        highlight! BufferLineModifiedSelected guifg=]] .. colors.semantic.warning .. [[ gui=underline
        highlight! BufferLineInfoSelected guifg=]] .. colors.semantic.info .. [[ gui=underline
        highlight! BufferLineHintSelected guifg=]] .. colors.semantic.hint .. [[ gui=underline
        " 重复文件名前缀的背景色
        highlight! BufferLineDuplicateSelected guifg=]] .. colors.palette.fg_dim .. [[ guibg=]] .. colors.bufferline.active_bg .. [[ gui=italic,underline
        highlight! BufferLineDuplicateVisible guifg=]] .. colors.palette.fg_dim .. [[ guibg=]] .. colors.bufferline.visible_bg .. [[ gui=italic
        highlight! BufferLineDuplicate guifg=]] .. colors.palette.fg_dim .. [[ guibg=]] .. colors.bufferline.inactive_bg .. [[ gui=italic
      ]])
    end)
  end,
}

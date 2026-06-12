-- snacks.nvim 多功能工具集
-- terminal / lazygit / bufdelete 模块按需调用，键位在 core/keymaps.lua
return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  config = function()
    require("snacks").setup({
      -- 大文件自动降级（关闭高亮等重型功能，避免卡顿）
      bigfile = { enabled = true },
      -- 加速文件首次打开渲染
      quickfile = { enabled = true },
      -- 缩进参考线
      indent = {
        enabled = true,
        animate = { enabled = false },
      },
      -- 左侧列：sign（诊断/书签）+ 行号 + git 状态条 + 折叠，各占固定位置
      statuscolumn = { enabled = true },
      -- vim.ui.input 美化（重命名等输入框）
      input = { enabled = true },
      -- 通知渲染
      notifier = { enabled = true },
      -- 文件浏览器（q 关闭）
      explorer = { enabled = true },
      -- 模糊查找；vim.ui.select 也由 picker 渲染
      picker = {
        ui_select = true,
        win = {
          input = {
            keys = {
              ["<C-j>"] = { "list_down", mode = { "i", "n" } },
              ["<C-k>"] = { "list_up", mode = { "i", "n" } },
              ["<C-q>"] = { "qflist", mode = { "i", "n" } },
              ["<Esc>"] = { "close", mode = { "i", "n" } },
            },
          },
        },
        sources = {
          explorer = {
            hidden = true, -- 显示隐藏文件
          },
        },
      },
      -- 窗口样式覆盖（snacks 浮窗默认无边框）
      styles = {
        lazygit = { border = "rounded" },
      },
    })

    -- LazyGit 关闭后刷新 Git 状态
    vim.api.nvim_create_autocmd("TermClose", {
      pattern = "*lazygit*",
      callback = function()
        vim.defer_fn(function()
          if pcall(require, "gitsigns") then
            require("gitsigns").refresh()
          end
          vim.cmd("checktime")
        end, 100)
      end,
      desc = "LazyGit 关闭后刷新 Git 状态",
    })
  end,
}

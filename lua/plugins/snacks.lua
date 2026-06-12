-- snacks.nvim 多功能工具集
-- 各模块替代的旧插件：
--   bufdelete ← mini.bufremove
--   indent    ← indent-blankline.nvim
--   input     ← dressing.nvim（vim.ui.input 部分）
--   picker    ← telescope.nvim + dressing.nvim（vim.ui.select 部分）
--   explorer  ← nvim-tree.lua
--   notifier  ← nvim-notify（noice 自动优先使用 snacks 后端）
--   terminal  ← toggleterm.nvim
--   lazygit   ← lazygit.nvim
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
      -- vim.ui.input 美化（重命名等输入框）
      input = { enabled = true },
      -- 通知渲染
      notifier = { enabled = true },
      -- 文件浏览器（替代 nvim-tree，q 关闭）
      explorer = { enabled = true },
      -- 模糊查找（替代 telescope），vim.ui.select 也走 picker
      picker = {
        ui_select = true,
        win = {
          input = {
            keys = {
              -- 保持原 telescope 的操作习惯
              ["<C-j>"] = { "list_down", mode = { "i", "n" } },
              ["<C-k>"] = { "list_up", mode = { "i", "n" } },
              ["<C-q>"] = { "qflist", mode = { "i", "n" } },
              ["<Esc>"] = { "close", mode = { "i", "n" } },
            },
          },
        },
        sources = {
          explorer = {
            hidden = true, -- 显示隐藏文件（对应 nvim-tree filters.dotfiles = false）
          },
        },
      },
    })

    -- LazyGit 关闭后刷新 Git 状态（从 lazygit.nvim 迁移）
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

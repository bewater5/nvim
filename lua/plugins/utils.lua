return {
  -- 自动配对
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = function()
      require("nvim-autopairs").setup({
        check_ts = true, -- 使用tree-sitter检查
        ts_config = {
          lua = { "string", "source" },
          javascript = { "string", "template_string" },
        },
        disable_filetype = { "snacks_picker_input", "spectre_panel" },
      })
    end,
  },

  -- 注释
  {
    "numToStr/Comment.nvim",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      require("Comment").setup({
        padding = true, -- 注释和行之间添加空格
        sticky = true,  -- 当换行时，光标是否应该留在原位
        ignore = nil,   -- 忽略在注释字符串中的行

        toggler = {
          line = "gcc",  -- 切换行注释
          block = "gbc", -- 切换块注释
        },

        opleader = {
          line = "gc",  -- 操作行注释
          block = "gb", -- 操作块注释
        },

        mappings = {
          basic = true,     -- 启用基本的映射
          extra = true,     -- 启用额外的映射
          extended = false, -- 启用扩展的映射
        },

        pre_hook = nil,  -- 在注释前运行的函数
        post_hook = nil, -- 在注释后运行的函数
      })
    end,
  },

  -- 快速环绕
  {
    "kylechui/nvim-surround",
    event = "VeryLazy",
    config = function()
      require("nvim-surround").setup({
        -- 配置
      })
    end,
  },

  -- 快速跳转
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    config = function()
      require("flash").setup({})
      -- 键盘映射已移至 lua/core/keymaps.lua 文件中统一管理
    end,
  },


  -- 增强会话管理
  {
    "folke/persistence.nvim",
    event = "VimEnter",
    config = function()
      require("persistence").setup({
        dir = vim.fn.expand(vim.fn.stdpath("state") .. "/sessions/"),
        options = { "buffers", "curdir", "tabpages", "winsize" },
      })

      -- 仅在无参数启动 nvim 且当前目录有会话时恢复
      vim.api.nvim_create_autocmd("VimEnter", {
        group = vim.api.nvim_create_augroup("RestoreSession", { clear = true }),
        callback = function()
          -- 检查是否是无参数启动
          if vim.fn.argc() == 0 then
            vim.schedule(function()
              -- 使用 persistence.nvim 内部方法获取当前目录的会话文件路径
              local persistence = require("persistence")
              local session_file = persistence.current()
              if vim.fn.filereadable(session_file) == 1 then
                persistence.load()
              end
            end)
          end
        end,
        nested = true,
      })

      -- 键盘映射已移至 lua/core/keymaps.lua 文件中统一管理
    end,
  },

  -- 自动闭合标签
  {
    "windwp/nvim-ts-autotag",
    event = "InsertEnter",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    config = function()
      local file_types = { "html", "xml", "vue", "jsx", "tsx", "javascript", "typescript", "svelte", "php" }
      local per_filetype = {}
      for _, file_type in ipairs(file_types) do
        per_filetype[file_type] = {
          enable_close = true,
        }
      end
      require("nvim-ts-autotag").setup({
        opts = {
          -- 启用闭合标签
          enable_close = true,
          -- 启用重命名标签
          enable_rename = true,
          -- 启用闭合斜杠
          enable_close_on_slash = false,
        },
        -- 支持的文件类型
        per_filetype = per_filetype,
      })
    end,
  },
}

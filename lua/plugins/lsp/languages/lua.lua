-- Lua LSP 配置
local M = {}

function M.setup(capabilities, on_attach)
  vim.lsp.config("lua_ls", {
    capabilities = capabilities,
    on_attach = on_attach,
    settings = {
      Lua = {
        -- 运行时设置
        runtime = {
          version = "LuaJIT", -- Neovim 使用 LuaJIT
          path = vim.split(package.path, ";"),
        },
        -- 诊断设置
        diagnostics = {
          globals = {
            "vim",                        -- Neovim 全局变量
            "use",                        -- Packer 插件管理器
            "describe",                   -- Busted 测试框架
            "it",                         -- Busted 测试框架
            "before_each",                -- Busted 测试框架
            "after_each",                 -- Busted 测试框架
          },
          disable = { "missing-fields" }, -- 禁用某些诊断
        },
        -- 工作区设置
        workspace = {
          library = vim.api.nvim_get_runtime_file("", true),
          maxPreload = 100000,
          preloadFileSize = 10000,
          checkThirdParty = false, -- 不检查第三方库
        },
        -- 遥测设置
        telemetry = {
          enable = false -- 禁用遥测
        },
        -- 格式化设置
        format = {
          enable = true,
          defaultConfig = {
            indent_style = "space",
            indent_size = "2",
            continuation_indent_size = "2",
          },
        },
        -- 提示设置
        hint = {
          enable = true,
          paramType = true,
          paramName = "Disable",  -- 禁用参数名提示
          semicolon = "Disable",  -- 禁用分号提示
          arrayIndex = "Disable", -- 禁用数组索引提示
        },
        -- 补全设置
        completion = {
          callSnippet = "Disable",    -- 禁用函数调用片段
          keywordSnippet = "Replace", -- 关键字片段
          displayContext = 1,         -- 显示上下文
        },
        -- 语义设置
        semantic = {
          enable = true,
          variable = true,
          annotation = true,
          keyword = false, -- 不对关键字进行语义高亮
        },
      },
    },
    filetypes = { "lua" },
    root_markers = { ".luarc.json", ".luarc.jsonc", ".luacheckrc", ".stylua.toml", "stylua.toml",
      "selene.toml", "selene.yml", ".git" },
  })
end

-- Lua 文件的特殊设置（折叠）
function M.setup_autocmds()
  vim.api.nvim_create_autocmd("FileType", {
    group = vim.api.nvim_create_augroup("LuaSettings", { clear = true }),
    pattern = "lua",
    callback = function()
      vim.wo.foldmethod = "indent"
      vim.wo.foldlevel = 99
    end,
  })
end

-- Lua 特定的快捷键（可选）
function M.setup_keymaps(bufnr)
  local opts = { buffer = bufnr, silent = true, noremap = true }

  -- Lua 特定的快捷键
  vim.keymap.set("n", "<leader>lr", "<cmd>luafile %<cr>", vim.tbl_extend("force", opts, { desc = "运行当前 Lua 文件" }))
  vim.keymap.set("n", "<leader>ll", "<cmd>lua print(vim.inspect(vim.lsp.get_clients()))<cr>",
    vim.tbl_extend("force", opts, { desc = "查看 LSP 客户端" }))
end

return M

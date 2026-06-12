-- Python LSP 配置
local M = {}

function M.setup(capabilities, on_attach)
  -- Pyright (推荐的 Python LSP)
  vim.lsp.config("pyright", {
    capabilities = capabilities,
    on_attach = on_attach,
    settings = {
      python = {
        analysis = {
          -- 类型检查模式
          typeCheckingMode = "basic", -- "off", "basic", "strict"
          -- 自动导入补全
          autoImportCompletions = true,
          -- 自动搜索路径
          autoSearchPaths = true,
          -- 使用库代码进行类型
          useLibraryCodeForTypes = true,
          -- 诊断模式
          diagnosticMode = "workspace", -- "openFilesOnly", "workspace"
          -- 存根路径
          stubPath = vim.fn.stdpath("data") .. "/lazy/python-type-stubs",
        },
        -- 默认 Python 路径
        defaultInterpreter = { "python3" },
        -- 虚拟环境路径
        venvPath = ".",
      },
    },
    filetypes = { "python" },
    root_markers = {
      "pyproject.toml",
      "setup.py",
      "setup.cfg",
      "requirements.txt",
      "Pipfile",
      "pyrightconfig.json",
      ".git"
    },
  })

  -- Ruff (快速的 Python linter 和 formatter) - 可选
  -- 只有在安装了 ruff 时才启用
  if vim.fn.executable("ruff") == 1 then
    vim.lsp.config("ruff", {
      capabilities = capabilities,
      on_attach = function(client, bufnr)
        -- 禁用 hover，让 Pyright 处理
        client.server_capabilities.hoverProvider = false
        on_attach(client, bufnr)
      end,
      init_options = {
        settings = {
          -- 任何额外的 CLI 参数
          args = {},
        }
      },
      filetypes = { "python" },
    })
  end
end

-- Python 文件的特殊设置（PEP8 缩进、折叠）
function M.setup_autocmds()
  vim.api.nvim_create_autocmd("FileType", {
    group = vim.api.nvim_create_augroup("PythonSettings", { clear = true }),
    pattern = "python",
    callback = function()
      -- PEP 8 缩进设置
      vim.bo.tabstop = 4
      vim.bo.shiftwidth = 4
      vim.bo.expandtab = true
      vim.bo.softtabstop = 4

      -- 设置行长度
      vim.bo.textwidth = 88 -- Black 的默认行长度

      -- 设置折叠
      vim.wo.foldmethod = "indent"
      vim.wo.foldlevel = 99
    end,
  })
end

-- Python 特定的快捷键（可选）
function M.setup_keymaps(bufnr)
  local opts = { buffer = bufnr, silent = true, noremap = true }

  -- Python 特定的快捷键
  vim.keymap.set("n", "<leader>pr", "<cmd>!python3 %<cr>", vim.tbl_extend("force", opts, { desc = "运行当前 Python 文件" }))
  vim.keymap.set("n", "<leader>pi", "<cmd>!python3 -i %<cr>", vim.tbl_extend("force", opts, { desc = "交互式运行 Python 文件" }))
  vim.keymap.set("n", "<leader>pt", "<cmd>!python3 -m pytest<cr>", vim.tbl_extend("force", opts, { desc = "运行 pytest" }))
  vim.keymap.set("n", "<leader>pT", "<cmd>!python3 -m pytest %<cr>",
    vim.tbl_extend("force", opts, { desc = "运行当前文件的测试" }))
end

return M

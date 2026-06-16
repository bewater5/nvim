-- 基础语言 LSP 配置（HTML, CSS, JSON 等）
local M = {}

function M.setup(capabilities, on_attach)
  -- JSON Language Server
  vim.lsp.config("jsonls", {
    capabilities = capabilities,
    on_attach = on_attach,
    settings = {
      json = {
        -- 基础 JSON schema 支持（不依赖 schemastore）
        validate = { enable = true },
        format = { enable = true },
        schemas = {
          {
            fileMatch = { "package.json" },
            url = "https://json.schemastore.org/package.json"
          },
          {
            fileMatch = { "tsconfig.json", "tsconfig.*.json" },
            url = "https://json.schemastore.org/tsconfig.json"
          },
        },
      },
    },
    filetypes = { "json", "jsonc" },
  })

  -- HTML Language Server
  vim.lsp.config("html", {
    capabilities = capabilities,
    on_attach = on_attach,
    settings = {
      html = {
        format = {
          templating = true,
          wrapLineLength = 120,
          wrapAttributes = "auto",
        },
        hover = {
          documentation = true,
          references = true,
        },
        completion = {
          attributeDefaultValue = "doublequotes",
        },
      },
    },
    filetypes = { "html", "htm" },
  })

  -- CSS Language Server
  vim.lsp.config("cssls", {
    capabilities = capabilities,
    on_attach = on_attach,
    settings = {
      css = {
        validate = true,
        lint = {
          unknownAtRules = "ignore", -- 忽略未知的 CSS 规则（如 Tailwind）
          duplicateProperties = "warning",
          emptyRules = "warning",
        },
        completion = {
          triggerPropertyValueCompletion = true,
          completePropertyWithSemicolon = true,
        },
      },
      scss = {
        validate = true,
        lint = {
          unknownAtRules = "ignore",
          duplicateProperties = "warning",
          emptyRules = "warning",
        },
        completion = {
          triggerPropertyValueCompletion = true,
          completePropertyWithSemicolon = true,
        },
      },
      less = {
        validate = true,
        lint = {
          unknownAtRules = "ignore",
          duplicateProperties = "warning",
          emptyRules = "warning",
        },
        completion = {
          triggerPropertyValueCompletion = true,
          completePropertyWithSemicolon = true,
        },
      },
    },
    filetypes = { "css", "scss", "less" },
  })

  -- YAML Language Server (可选)
  if vim.fn.executable("yaml-language-server") == 1 then
    vim.lsp.config("yamlls", {
      capabilities = capabilities,
      on_attach = on_attach,
      settings = {
        yaml = {
          schemas = {
            ["https://json.schemastore.org/github-workflow.json"] = "/.github/workflows/*",
            ["https://json.schemastore.org/github-action.json"] = "/action.{yml,yaml}",
            ["https://json.schemastore.org/docker-compose.json"] = "/docker-compose.{yml,yaml}",
            ["https://json.schemastore.org/kustomization.json"] = "/kustomization.{yml,yaml}",
          },
          validate = true,
          completion = true,
          hover = true,
        },
      },
      filetypes = { "yaml", "yml" },
    })
  end

  -- Markdown Language Server (可选)
  if vim.fn.executable("marksman") == 1 then
    vim.lsp.config("marksman", {
      capabilities = capabilities,
      on_attach = on_attach,
      filetypes = { "markdown", "md" },
    })
  end
end

-- 基础语言文件的特殊设置（Markdown）
function M.setup_autocmds()
  vim.api.nvim_create_autocmd("FileType", {
    group = vim.api.nvim_create_augroup("MarkdownSettings", { clear = true }),
    pattern = "markdown",
    callback = function()
      -- 设置缩进
      vim.bo.tabstop = 2
      vim.bo.shiftwidth = 2
      vim.bo.expandtab = true

      -- 设置文本宽度
      vim.bo.textwidth = 80

      -- 启用自动换行
      vim.wo.wrap = true
      vim.wo.linebreak = true
    end,
  })
end

return M

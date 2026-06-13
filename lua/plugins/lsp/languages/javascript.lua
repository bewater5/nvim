-- JavaScript/TypeScript LSP 配置
local M = {}

function M.setup(capabilities, on_attach)
  -- TypeScript Language Server
  vim.lsp.config("ts_ls", {
    capabilities = capabilities,
    on_attach = on_attach,
    settings = {
      typescript = {
        preferences = {
          importModuleSpecifier = "relative",
          includePackageJsonAutoImports = "auto",
        },
        suggest = {
          autoImports = true,
          completeFunctionCalls = false,
        },
        inlayHints = {
          includeInlayParameterNameHints = "all",
          includeInlayParameterNameHintsWhenArgumentMatchesName = false,
          includeInlayFunctionParameterTypeHints = true,
          includeInlayVariableTypeHints = true,
          includeInlayPropertyDeclarationTypeHints = true,
          includeInlayFunctionLikeReturnTypeHints = true,
          includeInlayEnumMemberValueHints = true,
        },
      },
      javascript = {
        preferences = {
          importModuleSpecifier = "relative",
        },
        suggest = {
          autoImports = true,
          completeFunctionCalls = false,
        },
        inlayHints = {
          includeInlayParameterNameHints = "all",
          includeInlayParameterNameHintsWhenArgumentMatchesName = false,
          includeInlayFunctionParameterTypeHints = true,
          includeInlayVariableTypeHints = true,
          includeInlayPropertyDeclarationTypeHints = true,
          includeInlayFunctionLikeReturnTypeHints = true,
          includeInlayEnumMemberValueHints = true,
        },
      },
    },
    filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact", "vue" },
    -- 优先匹配 tsconfig.json，解决 monorepo 子包切换问题
    root_markers = { "tsconfig.json", "package.json", "jsconfig.json" },
    init_options = {
      plugins = {
        { name = "@vue/typescript-plugin", location = require("plugins.lsp.languages.vue").vue_language_server_path, languages = { "vue" } },
      },
    },
  })

  -- ESLint
  vim.lsp.config("eslint", {
    capabilities = capabilities,
    on_attach = function(client, bufnr)
      on_attach(client, bufnr)

      -- 自动修复 ESLint 错误
      -- vim.api.nvim_create_autocmd("BufWritePre", {
      --   buffer = bufnr,
      --   command = "EslintFixAll",
      -- })
    end,
    -- 自定义 root_dir 函数，确保只在有配置文件的项目中启动
    root_dir = function(fname)
      local util = vim.fs
      local root = util.root(fname, {
        ".eslintrc",
        ".eslintrc.js",
        ".eslintrc.cjs",
        ".eslintrc.json",
        ".eslintrc.yaml",
        ".eslintrc.yml",
        "eslint.config.js",
        "eslint.config.mjs",
        "eslint.config.cjs",
      })
      -- 如果找不到 ESLint 配置文件，返回 nil 阻止 LSP 启动
      if not root then
        return nil
      end
      return root
    end,
    settings = {
      workingDirectory = { mode = "auto" },
      format = { enable = true },
      lint = { enable = true },
      codeAction = {
        disableRuleComment = {
          enable = true,
          location = "separateLine"
        },
        showDocumentation = {
          enable = true
        }
      }
    },
    filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
  })
end

return M

-- JavaScript/TypeScript LSP 配置
local M = {}

local bundled_tsserver_path = vim.fn.stdpath("data")
    .. "/mason/packages/typescript-language-server/node_modules/typescript/lib/tsserver.js"

local function read_package(package_path)
  if vim.fn.filereadable(package_path) ~= 1 then return nil end

  local ok, package = pcall(vim.json.decode, table.concat(vim.fn.readfile(package_path), "\n"))
  return ok and package or nil
end

local function workspace_uses_vue(root_dir)
  if not root_dir then return false end

  local package = read_package(vim.fs.joinpath(root_dir, "package.json"))
  if not package then return false end

  return (package.dependencies and package.dependencies.vue ~= nil)
    or (package.devDependencies and package.devDependencies.vue ~= nil)
    or (package.peerDependencies and package.peerDependencies.vue ~= nil)
end

local function workspace_typescript_major(root_dir)
  if not root_dir then return nil end

  local package = read_package(vim.fs.joinpath(root_dir, "node_modules", "typescript", "package.json"))
  if not package or type(package.version) ~= "string" then return nil end

  return tonumber(package.version:match("^(%d+)"))
end

function M.setup(capabilities, on_attach)
  -- TypeScript Language Server
  vim.lsp.config("ts_ls", {
    capabilities = capabilities,
    on_attach = on_attach,
    before_init = function(_, config)
      -- Vue Language Tools 3 需要 TypeScript 5+；旧项目仅在编辑器内使用 Mason 自带版本。
      local typescript_major = workspace_typescript_major(config.root_dir)
      if workspace_uses_vue(config.root_dir) and typescript_major and typescript_major < 5 then
        config.init_options.tsserver = config.init_options.tsserver or {}
        config.init_options.tsserver.path = bundled_tsserver_path
      end
    end,
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
    -- 每个子包独立启动 ts_ls，避免以 monorepo 根目录加载全部 TypeScript/Vue 项目。
    root_dir = function(bufnr, on_dir)
      local project_root = vim.fs.root(bufnr, { "tsconfig.json", "jsconfig.json", "package.json" })
      on_dir(project_root or vim.fn.getcwd())
    end,
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

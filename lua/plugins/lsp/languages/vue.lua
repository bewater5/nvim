-- Vue
-- Project DevDependencies: npm i -D vue-tsc
local M = {}

M.vue_language_server_path = vim.fn.stdpath("data") ..
    "/mason/packages/vue-language-server/node_modules/@vue/language-server"

M.setup = function(capabilities, on_attach)
  vim.lsp.config("vue_ls", {
    capabilities = capabilities,
    on_attach = function(client, bufnr)
      -- Vue 中的 TypeScript 跳转由 ts_ls + @vue/typescript-plugin 提供，避免重复请求阻塞多客户端结果聚合。
      client.server_capabilities.definitionProvider = false
      on_attach(client, bufnr)
    end,
    -- 优先匹配 tsconfig.json，解决 monorepo 子包切换问题
    root_markers = { "tsconfig.json", "package.json" },
    settings = {
      typescript = {
        inlayHints = {
          enumMemberValues = {
            enabled = true,
          },
          functionLikeReturnTypes = {
            enabled = true,
          },
          propertyDeclarationTypes = {
            enabled = true,
          },
          parameterTypes = {
            enabled = true,
            suppressWhenArgumentMatchesName = true,
          },
          variableTypes = {
            enabled = true,
          },
        },
      },
    },
  })
end

return M

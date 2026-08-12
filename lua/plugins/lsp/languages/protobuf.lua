-- Protobuf LSP 配置
local M = {}

function M.setup(capabilities, on_attach)
  vim.lsp.config("protols", {
    capabilities = capabilities,
    on_attach = on_attach,
    filetypes = { "proto" },
    root_markers = { ".git" },
  })
end

return M

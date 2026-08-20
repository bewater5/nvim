-- Rust LSP 配置
local M = {}

function M.setup(capabilities, on_attach)
  vim.lsp.config("rust_analyzer", {
    capabilities = capabilities,
    on_attach = on_attach,
    settings = {
      ["rust-analyzer"] = {
        -- 分析所有构建目标，并启用 build.rs 支持
        cargo = {
          allTargets = true,
          buildScripts = {
            enable = true,
          },
        },
        -- 保存时使用 Clippy 提供更完整的诊断
        check = {
          command = "clippy",
          allTargets = true,
        },
        -- 展开过程宏，改善宏生成代码的补全和跳转
        procMacro = {
          enable = true,
        },
        -- 行内提示默认仍由 <leader>uh 控制是否显示
        inlayHints = {
          chainingHints = { enable = true },
          closingBraceHints = { enable = true, minLines = 25 },
          parameterHints = { enable = true },
          typeHints = { enable = true },
        },
      },
    },
  })

  -- rust-analyzer 由 rustup 管理，不依赖 Mason 自动启用
  vim.lsp.enable("rust_analyzer")
end

-- Rust 文件使用 rustfmt 的默认四空格缩进
function M.setup_autocmds()
  vim.api.nvim_create_autocmd("FileType", {
    group = vim.api.nvim_create_augroup("RustSettings", { clear = true }),
    pattern = "rust",
    callback = function()
      vim.bo.tabstop = 4
      vim.bo.shiftwidth = 4
      vim.bo.softtabstop = 4
      vim.bo.expandtab = true

      vim.wo.foldmethod = "indent"
      vim.wo.foldlevel = 99
    end,
  })
end

return M

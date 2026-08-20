-- LSP 服务器配置 - 使用新的 vim.lsp.config API
local M = {}

function M.setup()
  local capabilities = require("blink.cmp").get_lsp_capabilities()
  local document_highlight_group = vim.api.nvim_create_augroup("LspDocumentHighlight", { clear = true })

  local function supports_document_highlight(bufnr)
    for _, client in ipairs(vim.lsp.get_clients({ bufnr = bufnr })) do
      if client:supports_method("textDocument/documentHighlight", bufnr) then
        return true
      end
    end
    return false
  end

  -- 使用精确位置标识当前单词，避免把另一个同名符号误判为原位置。
  local function current_keyword_range(bufnr)
    if vim.api.nvim_get_current_buf() ~= bufnr then
      return nil
    end

    local cursor = vim.api.nvim_win_get_cursor(0)
    local row = cursor[1]
    local col = cursor[2]
    local line = vim.api.nvim_buf_get_lines(bufnr, row - 1, row, false)[1] or ""
    local search_from = 0

    while search_from < #line do
      local match = vim.fn.matchstrpos(line, [[\k\+]], search_from)
      local start_col = match[2]
      local end_col = match[3]

      if start_col == -1 then
        return nil
      end

      if start_col <= col and col < end_col then
        return {
          row = row,
          start_col = start_col,
          end_col = end_col,
          text = match[1],
        }
      end

      search_from = end_col
    end

    return nil
  end

  local function is_same_keyword(left, right)
    return left ~= nil
      and right ~= nil
      and left.row == right.row
      and left.start_col == right.start_col
      and left.end_col == right.end_col
      and left.text == right.text
  end

  local function setup_document_highlight(bufnr)
    if vim.b[bufnr].lsp_document_highlight_enabled then
      return
    end

    vim.b[bufnr].lsp_document_highlight_enabled = true

    vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
      group = document_highlight_group,
      buffer = bufnr,
      callback = function()
        vim.b[bufnr].lsp_document_highlight_range = current_keyword_range(bufnr)
        vim.lsp.buf.document_highlight()
      end,
      desc = "高亮光标所在符号的引用",
    })

    vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
      group = document_highlight_group,
      buffer = bufnr,
      callback = function()
        local highlighted_range = vim.b[bufnr].lsp_document_highlight_range
        if is_same_keyword(highlighted_range, current_keyword_range(bufnr)) then
          return
        end

        vim.lsp.buf.clear_references()
        vim.b[bufnr].lsp_document_highlight_range = nil
      end,
      desc = "移出当前符号后清除引用高亮",
    })

    vim.api.nvim_create_autocmd("LspDetach", {
      group = document_highlight_group,
      buffer = bufnr,
      callback = function()
        vim.schedule(function()
          if not vim.api.nvim_buf_is_valid(bufnr) or supports_document_highlight(bufnr) then
            return
          end

          vim.lsp.util.buf_clear_references(bufnr)
          vim.api.nvim_clear_autocmds({ group = document_highlight_group, buffer = bufnr })
          vim.b[bufnr].lsp_document_highlight_enabled = nil
          vim.b[bufnr].lsp_document_highlight_range = nil
        end)
      end,
      desc = "LSP 断开后清除符号引用高亮",
    })
  end

  -- 设置按键映射函数 - 键映射已移至 lua/core/keymaps.lua 文件中统一管理
  local on_attach = function(client, bufnr)
    -- 禁用一些 LSP 的语义令牌，优先使用 Treesitter
    if client.name == "ts_ls" or client.name == "vue_ls" then
      client.server_capabilities.semanticTokensProvider = nil
    end
    -- 调用统一的LSP键映射设置函数
    if _G.setup_lsp_keymaps then
      _G.setup_lsp_keymaps(bufnr)
    end
  end

  -- 加载各语言模块
  local languages = {
    javascript = require("plugins.lsp.languages.javascript"),
    vue = require("plugins.lsp.languages.vue"),
    go = require("plugins.lsp.languages.go"),
    rust = require("plugins.lsp.languages.rust"),
    protobuf = require("plugins.lsp.languages.protobuf"),
    lua = require("plugins.lsp.languages.lua"),
    python = require("plugins.lsp.languages.python"),
    basic = require("plugins.lsp.languages.basic"),
  }

  -- 设置各语言的 LSP，并接通各语言的 FileType 设置（缩进/折叠等）
  for name, lang_module in pairs(languages) do
    if lang_module.setup then
      lang_module.setup(capabilities, on_attach)
    end
    if lang_module.setup_autocmds then
      lang_module.setup_autocmds()
    end
  end

  -- 设置语言特定的快捷键（如果需要）
  vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("LspLanguageKeymaps", { clear = true }),
    callback = function(event)
      local bufnr = event.buf
      local client = vim.lsp.get_client_by_id(event.data.client_id)

      if not client then return end

      if client:supports_method("textDocument/documentHighlight", bufnr) then
        setup_document_highlight(bufnr)
      end

      -- 延迟设置键映射，确保覆盖其他插件的键映射
      vim.schedule(function()
        -- 重新设置 LSP 键映射以确保优先级
        if _G.setup_lsp_keymaps then
          _G.setup_lsp_keymaps(bufnr)
        end

        -- 根据客户端名称设置特定的快捷键
        if client.name == "gopls" and languages.go.setup_keymaps then
          languages.go.setup_keymaps(bufnr)
        elseif client.name == "lua_ls" and languages.lua.setup_keymaps then
          languages.lua.setup_keymaps(bufnr)
        elseif client.name == "pyright" and languages.python.setup_keymaps then
          languages.python.setup_keymaps(bufnr)
        end
      end)
    end,
  })
end

return M

-- 设置Leader键为空格
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- 禁用空格默认行为
vim.keymap.set("n", "<Space>", "<Nop>", { noremap = true, silent = true })

-- 定义所有键盘映射
local M = {
  -- ========== 基础编辑操作 ==========
  -- 移动增强
  { "n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true, noremap = true } },
  { "n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true, noremap = true } },

  -- 快速退出插入模式
  { "i", "jk", "<ESC>", { desc = "ESC 替代品", noremap = true } },

  -- 视觉模式 - 保持缩进
  { "v", "<", "<gv", { desc = "保持选择的同时左缩进", noremap = true } },
  { "v", ">", ">gv", { desc = "保持选择的同时右缩进", noremap = true } },

  -- 移动选定的文本
  { "v", "J", ":m '>+1<CR>gv=gv", { desc = "向下移动选定的文本", noremap = true } },
  { "v", "K", ":m '<-2<CR>gv=gv", { desc = "向上移动选定的文本", noremap = true } },

  -- 粘贴不覆盖寄存器
  { "v", "p", '"_dP', { desc = "粘贴不覆盖寄存器", noremap = true } },

  -- 清除搜索高亮
  { "n", "<leader>nh", ":nohl<CR>", { desc = "清除搜索高亮", noremap = true, silent = true } },

  -- 窗口管理
  { "n", "<leader>x", ":close<CR>", { desc = "关闭当前窗口", noremap = true, silent = true } },
  { "n", "<leader>Q", ":qall<CR>", { desc = "关闭所有窗口", noremap = true, silent = true } },
  { "n", "<leader>W", ":wall<CR>", { desc = "保存所有文件", noremap = true, silent = true } },
  { "n", "<leader>sv", ":vsplit<CR>", { desc = "垂直分割窗口", noremap = true, silent = true } },
  { "n", "<leader>sh", ":split<CR>", { desc = "水平分割窗口", noremap = true, silent = true } },
  -- 等分窗口请用原生 <C-w>= （<leader>se 已用于编辑代码片段）

  -- 保存文件
  { "n", "<leader>w", ":w<CR>", { desc = "保存文件", noremap = true, silent = true } },
  { "n", "<C-s>", ":w<CR>", { desc = "保存文件", noremap = true, silent = true } },
  { "i", "<C-s>", "<Esc>:w<CR>a", { desc = "保存文件", noremap = true, silent = true } },

  -- ========== 缓冲区和标签页管理 ==========
  -- 缓冲区管理（使用 Snacks.bufdelete 保留窗口布局）
  { "n", "<leader>q", function()
    require("snacks").bufdelete()
  end, { desc = "删除 buffer", noremap = true, silent = true } },
  { "n", "<leader>qq", function()
    require("snacks").bufdelete({ force = true })
  end, { desc = "强制删除 buffer", noremap = true, silent = true } },
  { "n", "<leader>qa", function()
    vim.cmd('%bd|e#|bd#')
  end, { desc = "关闭其他所有 buffer", noremap = true, silent = true } },
  { "n", "<leader>qA", function()
    vim.cmd('bufdo bd')
  end, { desc = "关闭所有 buffer", noremap = true, silent = true } },
  { "n", "gt", "<cmd>bnext<cr>", { desc = "下一个缓冲区", noremap = true, silent = true } },
  { "n", "gT", "<cmd>bprevious<cr>", { desc = "上一个缓冲区", noremap = true, silent = true } },

  -- 标签页操作
  { "n", "<leader>tn", ":tabnew<CR>", { desc = "新建标签页", noremap = true, silent = true } },
  { "n", "<leader>tc", ":tabclose<CR>", { desc = "关闭标签页", noremap = true, silent = true } },
  { "n", "<leader>to", ":tabonly<CR>", { desc = "只保留当前标签页", noremap = true, silent = true } },
  { "n", "t[", ":tabp<CR>", { desc = "上一个标签页", noremap = true, silent = true } },
  { "n", "t]", ":tabn<CR>", { desc = "下一个标签页", noremap = true, silent = true } },

  -- ========== 文件浏览器 (Snacks.explorer) ==========
  { "n", "<leader>o", function()
    require("snacks").explorer()
  end, { desc = "切换文件浏览器", noremap = true, silent = true } },

  -- ========== 搜索和查找 (Snacks.picker) ==========
  -- 基础搜索
  { "n", "<leader><space>", function()
    require("snacks").picker.files()
  end, { desc = "查找文件", noremap = true, silent = true } },
  { "n", "<leader>fg", function()
    require("snacks").picker.grep()
  end, { desc = "通过Grep查找", noremap = true, silent = true } },
  { "n", "<leader>fb", function()
    require("snacks").picker.buffers()
  end, { desc = "查找缓冲区", noremap = true, silent = true } },
  { "n", "<leader>fh", function()
    require("snacks").picker.help()
  end, { desc = "查找帮助", noremap = true, silent = true } },

  -- 高级搜索
  { "n", "<leader>fa", function()
    require("snacks").picker.files({ hidden = true })
  end, { desc = "查找所有文件（包括隐藏文件）", noremap = true, silent = true } },
  { "n", "<leader>fw", function()
    require("snacks").picker.grep_word()
  end, { desc = "查找当前单词", noremap = true, silent = true } },
  { "n", "<leader>fr", function()
    require("snacks").picker.recent()
  end, { desc = "查找最近文件", noremap = true, silent = true } },

  -- 查看通知历史（snacks.notifier）
  { "n", "<leader>no", function()
    require("snacks").notifier.show_history()
  end, { desc = "查看通知历史", noremap = true, silent = true } },

  -- ========== Flash跳转导航 ==========
  -- 使用 flash.nvim 默认键位；S 不绑 visual 模式（让给 nvim-surround 的添加包围符）
  {
    { "n", "x", "o" },
    "s",
    function()
      require("flash").jump()
    end,
    { desc = "Flash跳转", noremap = true },
  },
  {
    { "n", "o" },
    "S",
    function()
      require("flash").treesitter()
    end,
    { desc = "Flash Treesitter选择", noremap = true },
  },
  {
    "o",
    "r",
    function()
      require("flash").remote()
    end,
    { desc = "Flash远程操作", noremap = true },
  },
  {
    { "o", "x" },
    "R",
    function()
      require("flash").treesitter_search()
    end,
    { desc = "Flash Treesitter搜索", noremap = true },
  },
  {
    "c",
    "<C-s>",
    function()
      require("flash").toggle()
    end,
    { desc = "切换Flash搜索", noremap = true },
  },

  -- ========== 会话管理 (Persistence) ==========
  {
    "n",
    "<leader>qs",
    function()
      require("persistence").load()
    end,
    { desc = "恢复上次会话", noremap = true, silent = true },
  },
  {
    "n",
    "<leader>ql",
    function()
      require("persistence").load({ last = true })
    end,
    { desc = "恢复最后一次会话", noremap = true, silent = true },
  },
  {
    "n",
    "<leader>qd",
    function()
      require("persistence").stop()
    end,
    { desc = "不要保存当前会话", noremap = true, silent = true },
  },

  -- ========== 终端管理 (Snacks.terminal) ==========
  {
    "n",
    "<leader>tt",
    function()
      require("snacks").terminal.toggle(nil, { win = { position = "float" } })
    end,
    { desc = "浮动终端", noremap = true, silent = true },
  },
  {
    "n",
    "<leader>th",
    function()
      require("snacks").terminal.toggle(nil, { win = { position = "bottom", height = 20 } })
    end,
    { desc = "水平终端", noremap = true, silent = true },
  },
  {
    "n",
    "<leader>tv",
    function()
      require("snacks").terminal.toggle(nil, { win = { position = "right" } })
    end,
    { desc = "垂直终端", noremap = true, silent = true },
  },
  -- t 模式也绑定，保持 toggleterm 在终端内按 <C-\> 关闭的习惯
  {
    { "n", "t" },
    "<c-\\>",
    function()
      require("snacks").terminal.toggle(nil, { win = { position = "float" } })
    end,
    { desc = "切换终端", noremap = true, silent = true },
  },

  -- ========== Git操作 ==========
  { "n", "<leader>gs", "<cmd>Git<cr>", { desc = "Git 状态", noremap = true, silent = true } },
  { "n", "<c-g>", function()
    vim.cmd("nohlsearch")
    require("snacks").lazygit()
  end, { desc = "LazyGit", noremap = true, silent = true } },

  -- ========== Copilot ==========
  -- 注意：<C-j>/<C-k> 已被 nvim-cmp 占用（补全/片段跳转），Copilot 循环建议改用 <M-]>/<M-[>
  { "i", "<M-]>", "copilot#Next()", { expr = true, silent = true, desc = "下一个Copilot建议" } },
  { "i", "<M-[>", "copilot#Previous()", { expr = true, silent = true, desc = "上一个Copilot建议" } },

  -- ========== 代码格式化 ==========
  {
    "n",
    "<c-l>",
    function()
      require("conform").format({ async = true, lsp_fallback = true })
    end,
    { desc = "格式化代码", noremap = true, silent = true },
  },
  { "n", "<leader>fl", "<cmd>EslintFixAll<cr>", { desc = "格式化 ESLint 代码", noremap = true, silent = true } },

  -- ========== UI 切换 ==========
  -- 切换 inlay hints（行内类型/参数提示），默认关闭
  {
    "n",
    "<leader>uh",
    function()
      local enabled = vim.lsp.inlay_hint.is_enabled({ bufnr = 0 })
      vim.lsp.inlay_hint.enable(not enabled, { bufnr = 0 })
    end,
    { desc = "切换 Inlay Hints", noremap = true, silent = true },
  },

  -- ========== 代码片段管理 ==========
  {
    "n",
    "<leader>se",
    function()
      local snippets_dir = vim.fn.stdpath("config") .. "/snippets"
      vim.cmd("edit " .. snippets_dir)
    end,
    { desc = "编辑代码片段", noremap = true, silent = true }
  },
}

-- LSP 专用键映射函数
local function setup_lsp_keymaps(bufnr)
  local opts = { noremap = true, silent = true, buffer = bufnr }

  -- LSP导航 - 确保覆盖任何全局映射
  vim.keymap.set("n", "gd", function()
    -- 检查是否有 LSP 客户端附加
    local clients = vim.lsp.get_clients({ bufnr = bufnr })
    if #clients > 0 then
      vim.lsp.buf.definition()
    end
  end, vim.tbl_extend("force", opts, { desc = "跳转到定义" }))
  vim.keymap.set("n", "gr", vim.lsp.buf.references, vim.tbl_extend("force", opts, { desc = "查找引用" }))
  vim.keymap.set("n", "gD", vim.lsp.buf.declaration, vim.tbl_extend("force", opts, { desc = "跳转到声明" }))
  vim.keymap.set("n", "gi", vim.lsp.buf.implementation, vim.tbl_extend("force", opts, { desc = "跳转到实现" }))
  vim.keymap.set("n", "K", vim.lsp.buf.hover, vim.tbl_extend("force", opts, { desc = "显示悬停文档" }))
  vim.keymap.set(
    "n",
    "<C-k>",
    vim.lsp.buf.signature_help,
    vim.tbl_extend("force", opts, { desc = "显示签名帮助" })
  )

  -- 诊断
  vim.keymap.set(
    "n",
    "<leader>e",
    vim.diagnostic.open_float,
    vim.tbl_extend("force", opts, { desc = "显示诊断信息" })
  )
  vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, vim.tbl_extend("force", opts, { desc = "上一个诊断" }))
  vim.keymap.set("n", "]d", vim.diagnostic.goto_next, vim.tbl_extend("force", opts, { desc = "下一个诊断" }))

  -- 重命名和代码操作
  vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, vim.tbl_extend("force", opts, { desc = "重命名符号" }))
  vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, vim.tbl_extend("force", opts, { desc = "代码操作" }))

  -- 打开诊断列表（Snacks.picker）
  vim.keymap.set("n", "<leader>de", function()
    require("snacks").picker.diagnostics_buffer()
  end, { desc = "当前文件诊断列表" })
  vim.keymap.set("n", "<leader>dw", function()
    require("snacks").picker.diagnostics()
  end, { desc = "工作区诊断列表" })

  -- 格式化
  vim.keymap.set("n", "<leader>F", function()
    vim.lsp.buf.format({ async = true })
  end, vim.tbl_extend("force", opts, { desc = "格式化代码" }))
end

-- GitSigns 专用键映射函数
local function setup_gitsigns_keymaps(bufnr)
  local gs = package.loaded.gitsigns

  local function map(mode, l, r, opts)
    opts = opts or {}
    opts.buffer = bufnr
    vim.keymap.set(mode, l, r, opts)
  end

  -- 导航
  map("n", "]c", function()
    if vim.wo.diff then
      return "]c"
    end
    vim.schedule(function()
      gs.next_hunk()
    end)
    return "<Ignore>"
  end, { expr = true, desc = "下一个 Git 变更" })

  map("n", "[c", function()
    if vim.wo.diff then
      return "[c"
    end
    vim.schedule(function()
      gs.prev_hunk()
    end)
    return "<Ignore>"
  end, { expr = true, desc = "上一个 Git 变更" })

  -- 动作
  map("n", "<leader>hs", gs.stage_hunk, { desc = "暂存变更" })
  map("n", "<leader>hr", gs.reset_hunk, { desc = "重置变更" })
  map("v", "<leader>hs", function()
    gs.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
  end, { desc = "暂存选定变更" })
  map("v", "<leader>hr", function()
    gs.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
  end, { desc = "重置选定变更" })
  -- map("n", "<leader>hS", gs.stage_buffer, { desc = "暂存所有变更" })
  map("n", "<leader>hu", gs.undo_stage_hunk, { desc = "撤销暂存变更" })
  -- map("n", "<leader>hR", gs.reset_buffer, { desc = "重置所有变更" })
  map("n", "<leader>hp", gs.preview_hunk, { desc = "预览变更" })
  map("n", "<leader>hb", function()
    gs.blame_line({ full = true })
  end, { desc = "显示 Git blame" })
  map("n", "<leader>hB", "<cmd>Git blame<CR>", { desc = "完整 Git blame" })
  map("n", "<leader>tb", gs.toggle_current_line_blame, { desc = "切换行 blame" })
  map("n", "<leader>hd", gs.diffthis, { desc = "显示 Git diff" })
  map("n", "<leader>hD", function()
    gs.diffthis("~")
  end, { desc = "显示与 HEAD 的 Git diff" })
  map("n", "<leader>td", gs.toggle_deleted, { desc = "切换删除显示" })
end

-- 应用基础键映射
for _, mapping in ipairs(M) do
  local mode = mapping[1]
  local key = mapping[2]
  local command = mapping[3]
  local opts = mapping[4]
  vim.keymap.set(mode, key, command, opts)
end

-- 导出函数供插件使用
_G.setup_lsp_keymaps = setup_lsp_keymaps
_G.setup_gitsigns_keymaps = setup_gitsigns_keymaps

-- ========== 搜索后自动取消高亮 ==========
local search_timer = nil -- 用于存储定时器
local cancel_highlight = function()
  -- 开启高亮
  vim.opt.hlsearch = true
  -- 如果已有定时器在运行，先取消它
  if search_timer then
    vim.fn.timer_stop(search_timer)
  end

  -- 创建新的定时器（1000ms 后清除高亮）
  search_timer = vim.fn.timer_start(1000, function()
    vim.cmd("nohlsearch")
    search_timer = nil -- 清空定时器引用
  end)
end

vim.api.nvim_create_autocmd("CmdlineLeave", {
  pattern = { "/", "?" },
  callback = cancel_highlight,
  desc = "搜索完成后自动取消高亮",
})

-- ========== 搜索跳转智能高亮 ==========
local function search_and_highlight(direction)
  return function()
    -- 执行跳转，捕获可能的 E486 错误
    local ok, err = pcall(function()
      if direction == "next" then
        vim.cmd("normal! n")
      else
        vim.cmd("normal! N")
      end
    end)
    if not ok then
      if err:match("E486") then
        vim.notify("Pattern not found", vim.log.levels.WARN)
      else
        vim.notify(err, vim.log.levels.ERROR)
      end
      return
    end
    cancel_highlight()
  end
end

vim.keymap.set("n", "n", search_and_highlight("next"), { desc = "下一个搜索结果", noremap = true, silent = true })
vim.keymap.set("n", "N", search_and_highlight("prev"), { desc = "上一个搜索结果", noremap = true, silent = true })

-- ========== 娱乐功能 ==========
vim.keymap.set("n", "<leader>Fr", "<cmd>CellularAutomaton make_it_rain<CR>")

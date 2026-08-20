# 🚀 Neovim 配置

[English](./README.md) | 简体中文

一个基于 Lua 构建的现代 Neovim 配置，具备 LSP 支持、自动补全、模糊查找和透明美观的 UI。此配置旨在提供强大的 IDE 般的体验，同时保持 Neovim 的简洁性和速度。

## ✨ 特性

- **LSP 集成**：完整的语言服务器协议支持，包含诊断、代码操作和符号引用高亮
- **自动补全**：基于 blink.cmp（Rust 模糊匹配），搭配 LuaSnip 代码片段
- **多功能工具集**：snacks.nvim 提供模糊查找、文件浏览器、终端、通知等
- **快速跳转**：通过 `s` 使用 flash.nvim 标签式跳转，同时保留原生字符移动
- **测试**：通过 neotest 运行 Go、Python 和 Vitest 测试，支持光标处、当前文件和整个项目
- **Git 集成**：Gitsigns、Fugitive 与 LazyGit
- **代码格式化**：Conform 快捷键格式化（无保存自动格式化）
- **语法高亮**：Treesitter 增强语法高亮
- **透明 UI**：编辑区/浮窗/标签栏背景透明，透出终端背景
- **会话管理**：Persistence 按目录保存会话，不同 Neovim 进程之间隔离跳转历史
- **GitHub Copilot**：AI 驱动的代码建议

## ⚡️ 依赖要求

- **Neovim** >= 0.11.0
- **Git** >= 2.19.0
- **Node.js** >= 18.0（用于 LSP 服务器）
- 一个 [Nerd Font](https://www.nerdfonts.com/) 字体（推荐：JetBrainsMono Nerd Font）
- **ripgrep**（用于 Snacks picker 实时搜索）
- **fd**（可选，用于更快的文件查找）
- **lazygit**（可选，用于 `<C-g>` Git 终端界面）

## 📦 安装

1. 备份现有的 Neovim 配置：
```bash
mv ~/.config/nvim ~/.config/nvim.backup
mv ~/.local/share/nvim ~/.local/share/nvim.backup
```

2. 克隆此仓库：
```bash
git clone https://github.com/bewater5/nvim.git ~/.config/nvim
```

3. 启动 Neovim：
```bash
nvim
```

插件管理器（lazy.nvim）将在首次启动时自动安装所有插件。

> 透明背景需要终端模拟器开启透明度（如 iTerm2 的 Transparency、Kitty 的
> `background_opacity`）。想恢复不透明背景，把 `lua/core/colors.lua` 中的
> `M.bg_color` 改回色值（如 `M.palette.bg_main`）即可一键还原。

## 📝 配置结构

```
~/.config/nvim/
├── init.lua                   # 入口点和插件管理器设置
├── lazy-lock.json             # 插件版本锁定文件
├── lua/
│   ├── core/                  # 核心配置
│   │   ├── options.lua        # Neovim 设置
│   │   ├── keymaps.lua        # 键位映射（统一管理）
│   │   └── colors.lua         # 统一颜色管理
│   └── plugins/               # 插件配置
│       ├── lsp/               # LSP 配置
│       │   ├── init.lua       # LSP 入口
│       │   ├── servers.lua    # LSP 服务器配置
│       │   ├── cmp.lua        # blink.cmp 自动补全
│       │   ├── mason.lua      # LSP 安装管理
│       │   └── languages/     # 特定语言配置
│       ├── ui/                # UI 插件
│       │   ├── statusline.lua # 状态栏 (lualine)
│       │   ├── bufferline.lua # 缓冲区标签页
│       │   └── notifications.lua # 通知系统 (noice)
│       ├── snacks.lua         # snacks.nvim 多功能工具集
│       ├── colorscheme.lua    # Ayu 主题与透明背景
│       ├── treesitter.lua     # 语法高亮
│       ├── git.lua            # Git 集成
│       ├── formatting.lua     # 代码格式化
│       ├── snippets.lua       # 代码片段引擎
│       ├── copilot.lua        # GitHub Copilot
│       ├── neotest.lua        # 测试运行器配置
│       └── utils.lua          # 编辑增强（autopairs、surround 等）
├── snippets/                  # 自定义代码片段
└── README.md
```

## 🔌 核心插件

| 插件 | 描述 |
|--------|-------------|
| [lazy.nvim](https://github.com/folke/lazy.nvim) | 现代插件管理器 |
| [snacks.nvim](https://github.com/folke/snacks.nvim) | 模糊查找、文件浏览器、终端、LazyGit、通知等 |
| [blink.cmp](https://github.com/saghen/blink.cmp) | 自动补全引擎 |
| [nvim-lspconfig](https://github.com/neovim/nvim-lspconfig) | LSP 配置 |
| [neotest](https://github.com/nvim-neotest/neotest) | Go、Python 和 Vitest 测试运行器 |
| [flash.nvim](https://github.com/folke/flash.nvim) | 快速跳转 |
| [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter) | 语法高亮 |
| [gitsigns.nvim](https://github.com/lewis6991/gitsigns.nvim) | Git 装饰 |
| [conform.nvim](https://github.com/stevearc/conform.nvim) | 代码格式化 |
| [lualine.nvim](https://github.com/nvim-lualine/lualine.nvim) | 状态栏 |
| [bufferline.nvim](https://github.com/akinsho/bufferline.nvim) | 缓冲区标签页 |
| [noice.nvim](https://github.com/folke/noice.nvim) | 命令行/消息 UI |
| [LuaSnip](https://github.com/L3MON4D3/LuaSnip) | 代码片段引擎 |
| [copilot.vim](https://github.com/github/copilot.vim) | AI 代码建议 |

## ⌨️ 键位映射

**Leader 键**：`<Space>`

### 基本操作

| 按键 | 模式 | 描述 |
|-----|------|-------------|
| `jk` | 插入 | 退出插入模式 |
| `<leader>w` / `<C-s>` | 普通 | 保存文件 |
| `<leader>W` | 普通 | 保存所有文件 |
| `<leader>x` | 普通 | 关闭当前窗口 |
| `<leader>Q` | 普通 | 关闭所有窗口 |
| `<leader>nh` | 普通 | 清除搜索高亮 |
| `<leader>sv` / `<leader>sh` | 普通 | 垂直 / 水平分割窗口 |

### 搜索和查找（Snacks picker）

| 按键 | 模式 | 描述 |
|-----|------|-------------|
| `<leader><space>` | 普通 | 查找文件 |
| `<leader>fg` | 普通 | 实时搜索（Grep） |
| `<leader>fb` | 普通 | 查找缓冲区 |
| `<leader>fa` | 普通 | 查找所有文件（包括隐藏文件） |
| `<leader>fr` | 普通 | 最近使用的文件 |
| `<leader>fw` | 普通 | 查找光标下的单词 |
| `<leader>fh` | 普通 | 查找帮助 |
| `<leader>no` | 普通 | 通知历史 |

picker 内：`<C-j>` / `<C-k>` 上下选择，`<C-q>` 发送到 quickfix，`<Esc>` 关闭。

### 文件浏览器（Snacks explorer）

`<leader>o` 打开/关闭，居中浮窗布局。树内常用键：

| 按键 | 描述 |
|-----|-------------|
| `l` / `h` | 展开目录或打开文件 / 折叠目录 |
| `a` / `d` / `r` | 创建 / 删除 / 重命名 |
| `c` / `m` / `y` / `p` | 复制 / 移动 / 复制（yank）/ 粘贴 |
| `H` / `I` | 切换隐藏文件 / gitignore 文件显示 |
| `<BS>` / `Z` | 根目录上移一级 / 折叠全部 |
| `q` | 关闭 |

### 自动补全（blink.cmp）

| 按键 | 模式 | 描述 |
|-----|------|-------------|
| `<CR>` | 插入 | 确认补全 |
| `<C-n>` / `<C-p>` | 插入 | 下一个 / 上一个补全项 |
| `<Tab>` / `<S-Tab>` | 插入 | 片段占位符跳转 |
| `<C-space>` | 插入 | 手动触发补全 |
| `<C-e>` | 插入 | 关闭补全窗口 |
| `<C-b>` / `<C-f>` | 插入 | 文档向上 / 向下滚动 |

### LSP（语言服务器）

| 按键 | 模式 | 描述 |
|-----|------|-------------|
| `gd` / `gD` | 普通 | 跳转到定义 / 声明 |
| `gr` / `gi` | 普通 | 查找引用 / 跳转到实现 |
| `K` | 普通 | 悬浮文档 |
| `<C-k>` | 普通 | 签名帮助 |
| `<leader>rn` | 普通 | 重命名符号 |
| `<leader>ca` | 普通 | 代码操作 |
| `<leader>e` | 普通 | 显示行诊断 |
| `[d` / `]d` | 普通 | 上一个 / 下一个诊断 |
| `<leader>de` / `<leader>dw` | 普通 | 当前文件 / 工作区诊断列表 |
| `<leader>uh` | 普通 | 切换 Inlay Hints |

光标停留在符号上时，同一符号的 LSP 引用会显示下划线；在同一处符号内移动会保留高亮，离开后清除。

### 格式化

| 按键 | 模式 | 描述 |
|-----|------|-------------|
| `<C-l>` | 普通 | 格式化代码（Conform） |
| `<leader>F` | 普通 | 格式化代码（LSP） |
| `<leader>fl` | 普通 | ESLint 修复 |

### 缓冲区和标签页

| 按键 | 模式 | 描述 |
|-----|------|-------------|
| `<leader>q` / `<leader>qq` | 普通 | 删除 / 强制删除 buffer（保留窗口） |
| `<leader>qa` / `<leader>qA` | 普通 | 关闭其他 / 所有 buffer |
| `gt` / `gT` | 普通 | 下一个 / 上一个缓冲区 |
| `<leader>tn` / `<leader>tc` | 普通 | 新建 / 关闭标签页 |
| `t]` / `t[` | 普通 | 下一个 / 上一个标签页 |

### 测试（Neotest）

| 按键 | 模式 | 描述 |
|-----|------|-------------|
| `<leader>tr` | 普通 | 运行光标处测试 |
| `<leader>tR` | 普通 | 运行当前文件测试 |
| `<leader>ta` | 普通 | 运行当前项目全部测试 |
| `<leader>ts` | 普通 | 切换测试摘要 |
| `<leader>te` | 普通 | 查看光标处测试的输出 |
| `<leader>tp` | 普通 | 切换测试输出面板 |
| `<leader>tx` | 普通 | 停止正在运行的测试 |

### Git

| 按键 | 模式 | 描述 |
|-----|------|-------------|
| `<C-g>` | 普通 | LazyGit |
| `<leader>gs` | 普通 | Git 状态（Fugitive） |
| `]c` / `[c` | 普通 | 下一个 / 上一个变更 |
| `<leader>hs` / `<leader>hr` | 普通/可视 | 暂存 / 重置变更 |
| `<leader>hu` | 普通 | 撤销暂存变更 |
| `<leader>hp` | 普通 | 预览变更 |
| `<leader>hb` / `<leader>hB` | 普通 | 行 blame / 完整 blame |
| `<leader>hd` / `<leader>hD` | 普通 | diff / 与 HEAD diff |
| `<leader>tb` | 普通 | 切换行 blame |

### 终端（Snacks terminal）

| 按键 | 模式 | 描述 |
|-----|------|-------------|
| `<C-\>` | 普通/终端 | 切换浮动终端 |

### 跳转和编辑（flash / surround / Comment）

| 按键 | 模式 | 描述 |
|-----|------|-------------|
| `s` | 普通/可视/操作符等待 | Flash 跳转（输入字符后按标签直达） |
| `gcc` / `gc{motion}` | 普通 | 切换注释 |
| `ys{motion}{char}` | 普通 | 添加包围符号 |
| `ds{char}` / `cs{old}{new}` | 普通 | 删除 / 更改包围符号 |

Flash 字符模式已关闭，`f`、`F`、`t`、`T`、`;` 和 `,` 均保留 Vim 原生行为。

### 会话和其他

| 按键 | 模式 | 描述 |
|-----|------|-------------|
| `<leader>qs` / `<leader>ql` | 普通 | 恢复会话 / 最后一次会话 |
| `<leader>qd` | 普通 | 不保存当前会话 |
| `<leader>se` | 普通 | 编辑代码片段 |
| `<M-]>` / `<M-[>` | 插入 | 下一个 / 上一个 Copilot 建议 |

启动时会清空一次 jumplist，因此 `<C-o>` 和 `<C-i>` 只会访问当前 Neovim 进程记录的位置。

## 🛠️ 自定义

### 添加 LSP 服务器

在 `lua/plugins/lsp/languages/` 中创建包含 `setup(capabilities, on_attach)`
函数的语言模块，并注册到 `lua/plugins/lsp/servers.lua` 的 `languages` 表。

### 调整颜色

所有颜色集中在 `lua/core/colors.lua`：`M.palette` 为基础调色板，
`M.bg_color` 为统一背景开关（`"NONE"` 透明），组件颜色见各组件表。

### 添加插件

在 `lua/plugins/` 中创建新文件或添加到现有插件文件中：

```lua
return {
  "用户名/插件名",
  config = function()
    -- 插件配置
  end,
}
```

## 📚 学习资源

- [Neovim 文档](https://neovim.io/doc/)
- [Lazy.nvim 插件管理器](https://github.com/folke/lazy.nvim)
- [LSP 配置指南](https://github.com/neovim/nvim-lspconfig)
- [snacks.nvim 文档](https://github.com/folke/snacks.nvim)

## 🤝 贡献

欢迎提交问题或拉取请求来改进！

## 📄 许可证

MIT 许可证 - 欢迎将此配置作为你自己配置的起点。

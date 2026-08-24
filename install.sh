#!/usr/bin/env bash
# Neovim 在 Ubuntu/Debian 上的系统级依赖。
# - build-essential: nvim-treesitter 编译语言解析器
# - python3-venv: Mason 为 Ruff 创建 Python 虚拟环境
# - fd-find: Snacks picker 快速查找文件（Ubuntu 命令名为 fdfind）

set -o pipefail

info() { printf '\033[1;34m==>\033[0m %s\n' "$*"; }
warn() { printf '\033[1;33m[!]\033[0m  %s\n' "$*"; }
ok()   { printf '\033[1;32m[ok]\033[0m %s\n' "$*"; }

if [[ "$(uname -s)" != "Linux" ]] || ! command -v apt-get >/dev/null 2>&1; then
  ok "No Ubuntu/Debian dependencies to install"
  exit 0
fi

packages=(
  build-essential
  fd-find
  python3-venv
)
missing=()

for pkg in "${packages[@]}"; do
  if ! dpkg-query -W -f='${Status}' "$pkg" 2>/dev/null | grep -q "ok installed"; then
    missing+=("$pkg")
  fi
done

if (( ${#missing[@]} == 0 )); then
  ok "Neovim system dependencies already installed"
else
  info "Installing Neovim system dependencies: ${missing[*]}"
  sudo apt-get update \
    && sudo apt-get install -y "${missing[@]}" \
    || {
      warn "APT dependency installation failed"
      exit 1
    }

  ok "Neovim system dependencies installed"
fi

# Debian/Ubuntu 将 fd 二进制命名为 fdfind，而 Neovim 插件通常查找 fd。
if ! command -v fd >/dev/null 2>&1; then
  fd_target="$(command -v fdfind 2>/dev/null || true)"
  fd_link_dir="${XDG_BIN_HOME:-$HOME/.local/bin}"
  fd_link="$fd_link_dir/fd"

  if [[ -z "$fd_target" ]]; then
    warn "fd-find is installed but fdfind is not available"
    exit 1
  elif [[ -e "$fd_link" || -L "$fd_link" ]]; then
    warn "$fd_link already exists; leaving it unchanged"
  else
    mkdir -p "$fd_link_dir"
    ln -s "$fd_target" "$fd_link"
    ok "Created $fd_link -> $fd_target"
  fi
fi

info "Open Neovim and run :TSUpdate, then :MasonInstall ruff"

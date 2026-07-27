#!/usr/bin/env bash
# Neovim 在 Ubuntu/Debian 上的系统级依赖。
# - build-essential: nvim-treesitter 编译语言解析器
# - python3-venv: Mason 为 Ruff 创建 Python 虚拟环境

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
  exit 0
fi

info "Installing Neovim system dependencies: ${missing[*]}"
sudo apt-get update \
  && sudo apt-get install -y "${missing[@]}" \
  || {
    warn "APT dependency installation failed"
    exit 1
  }

ok "Neovim system dependencies installed"
info "Open Neovim and run :TSUpdate, then :MasonInstall ruff"

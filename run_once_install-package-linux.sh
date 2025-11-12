#!/usr/bin/env bash
set -e
sudo apt update
sudo apt install -y git zsh curl neovim 

# 安装 WezTerm
if ! command -v wezterm >/dev/null; then
  sudo add-apt-repository ppa:wez/wezterm-nightly -y
  sudo apt update
  sudo apt install -y wezterm
fi

# 剪贴板支持
if [ "$(uname -r | grep -i wayland)" ]; then
  sudo apt install -y wl-clipboard
else
  sudo apt install -y xclip
fi

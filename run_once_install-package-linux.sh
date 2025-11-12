#!/usr/bin/env bash
set -e

echo "🚀 [chezmoi] Starting Ubuntu environment setup..."

sudo apt update
# neovim may version conflict, install it in your own hand 
sudo apt install -y git zsh curl neovim fzf software-properties-common 

# 安装 WezTerm
if ! command -v wezterm >/dev/null 2>&1; then
  echo "🚀 Installing WezTerm (stable release)..."

  sudo mkdir -p /usr/share/keyrings
  curl -fsSL https://apt.fury.io/wez/gpg.key | sudo gpg --dearmor -o /usr/share/keyrings/wezterm-archive-keyring.gpg

  echo "deb [signed-by=/usr/share/keyrings/wezterm-archive-keyring.gpg] https://apt.fury.io/wez/ /" \
    | sudo tee /etc/apt/sources.list.d/wezterm.list > /dev/null

  sudo apt update
  sudo apt install -y wezterm
else
  echo "✅ WezTerm already installed ($(wezterm --version))"
fi

# 将 WezTerm 设置为默认终端
if command -v gsettings >/dev/null 2>&1; then
  echo "🧩 Setting WezTerm as default terminal..."
  # 仅 GNOME 桌面有效
  if gsettings list-schemas | grep -q org.gnome.desktop.default-applications.terminal; then
    gsettings set org.gnome.desktop.default-applications.terminal exec 'wezterm'
    gsettings set org.gnome.desktop.default-applications.terminal exec-arg '-e'
    echo "✅ WezTerm set as default terminal (GNOME)"
  else
    echo "⚠️ 你的桌面环境似乎不是 GNOME，无法自动设置默认终端，请手动修改终端快捷方式。"
  fi
else
  echo "⚠️ gsettings 未安装，跳过默认终端设置。"
fi

# 安装 Oh My Zsh + Starship
echo "🌟 Installing Oh My Zsh and Starship prompt..."
if [ ! -d "$HOME/.oh-my-zsh" ]; then
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
else
  echo "✅ Oh My Zsh already installed."
fi

if ! command -v starship >/dev/null; then
  echo "💫 Installing Starship..."
  curl -fsSL https://starship.rs/install.sh | bash -s -- -y
else
  echo "✅ Starship already installed ($(starship --version))"
fi

# 配置 Starship 自动加载到 zsh
if ! grep -q 'eval "$(starship init zsh)"' ~/.zshrc; then
  echo 'eval "$(starship init zsh)"' >> ~/.zshrc
  echo "✨ Added Starship initialization to ~/.zshrc"
fi

# 更改默认 shell 为 zsh
if [ "$SHELL" != "$(which zsh)" ]; then
  echo "🔁 Changing default shell to zsh..."
  chsh -s "$(which zsh)"
fi

# 剪贴板支持
if [ "$(uname -r | grep -i wayland)" ]; then
  sudo apt install -y wl-clipboard
else
  sudo apt install -y xclip
fi

echo "🎉 [chezmoi] Environment setup complete!"

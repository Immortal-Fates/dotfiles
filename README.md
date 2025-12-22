# Dotfiles (WezTerm + Zsh)
My personal terminal setup built around WezTerm, zsh, and Chez Moi. It installs a themed WezTerm (Catppuccin, JetBrainsMono Nerd Font, custom background) and an Oh My Zsh shell with Starship plus navigation/productivity plugins.

I try to use the same operation method as vim in any way.

## Quick start (Chez Moi)
- Install Chez Moi: `sh -c "$(curl -fsLS get.chezmoi.io/lb)" -- -b /usr/local/bin`
- Apply everything: `chezmoi init --apply https://github.com/Immortal-Fates/dotfiles.git`
  - The first apply runs `run_once_install-package-linux.sh`, which installs WezTerm, Oh My Zsh, Starship (pastel-powerline preset), zsh plugins (autojump, autosuggestions, syntax highlighting, vi-mode), JetBrainsMono Nerd Font, clipboard tools, and switches the default shell to zsh.
- Pull updates: `chezmoi update`
- Edit tracked files: `chezmoi cd` then commit as usual.
- Track new dotfiles: `chezmoi add ~/.<file>` followed by `chezmoi diff` to review.

## Repo layout
- `dot_zshrc` — shell configuration (plugins, Starship, Conda hook).
- `private_dot_config/wezterm/wezterm.lua` — WezTerm appearance, keybinds, background.
- `run_once_install-package-linux.sh` — first-apply installer for dependencies and fonts.
- `assets/xuenai.png` — terminal background image.

## Zsh setup
- Takeaway: I use Oh My Zsh to manage my zsh plugins and starship as my topic.
- Plugins: Oh My Zsh with plugins:
  - `git` — Git shortcuts and tab completion.
  - `autojump` — jump to frequently used directories with fuzzy memory (`j <name>`).
  - `copypath` — copy current path to clipboard (`copypath`).
  - `zsh-vi-mode` — modal editing and movement (Esc to enter normal mode; `vv` to edit command in $EDITOR).
  - `zsh-autosuggestions` — ghost text suggestions from history; accept with → or `End`.
  - `zsh-syntax-highlighting` — colors for valid/invalid commands as you type.
- Prompt: Starship with the pastel-powerline preset (patched Nerd Font). Minimal segments + powerline glyph separators; shows git state, dir, time, and clean exit indicator. Reload/init with `eval "$(starship init zsh)"`.
- Aliases: `vim` -> `nvim`.
- Conda: initialized if installed at `$HOME/miniconda3`.
- Extra env: sourced from `~/.local/bin/env` for local secrets/paths.

## WezTerm setup
- Takeaway: written in Rust and GPU accelerated so I like it.
- Fonts/colors: JetBrainsMono Nerd Font + Noto Color Emoji, `Catppuccin Mocha`, 80% window opacity, custom background `assets/xuenai.png`.
- Defaults: launches login `zsh`, 120x32 window, small padding, resize-only decorations, no tab-close prompt.
- Keybinds:
  - `Ctrl+Shift+t/w` new/close tab
  - `Ctrl+Shift+e/o` split pane horizontal/vertical
  - `Ctrl+Tab` cycle panes, `Alt+h/j/k/l` move between panes

## Vscode

- Font: JetBrainsMono Nerd Font
- Color Topic: one dark pro
- Keybind: make the keybind just like your terminal. So that you can use both in the same way.

Todo



## Browser

No matter what browser are you using. Remember to load the vim extention.

- Extension list
  - CopyTex: double click to copy tex from AI chat

## Todo

- [ ] use all the config in lua
- [ ] add vscode config file

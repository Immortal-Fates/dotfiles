# Dotfiles (WezTerm + Zsh)
My personal terminal setup built around WezTerm, zsh, and Chez Moi. It installs a themed WezTerm (Catppuccin, Lyth Mono Term on macOS, Nerd Font symbols fallback, custom background) and an Oh My Zsh shell with Starship plus navigation/productivity plugins.

I try to use the same operation method as vim in any way.

## Quick start (Chez Moi)

- Install Chez Moi on Ubuntu: `sh -c "$(curl -fsLS get.chezmoi.io/lb)" -- -b /usr/local/bin`
- Install Chez Moi on macOS: `brew install chezmoi` or `sh -c "$(curl -fsLS get.chezmoi.io/lb)" -- -b /usr/local/bin`
- Preview first: `chezmoi init https://github.com/Immortal-Fates/dotfiles.git && chezmoi diff`
- Apply everything: `chezmoi apply`
- The first apply runs an OS-specific installer:
  - Ubuntu: `run_once_install-package-linux.sh.tmpl`
  - macOS: `run_once_install-package-darwin.sh.tmpl`
- The installer sets up WezTerm, Oh My Zsh, Starship (Tokyo Night preset), zsh plugins (autojump, autosuggestions, syntax highlighting, vi-mode), Yazi, JetBrainsMono Nerd Font, clipboard tools, and switches the default shell to zsh.
- Pull updates: `chezmoi update`
- Edit tracked files: `chezmoi cd` then commit as usual.
- Track new dotfiles: `chezmoi add ~/.<file>` followed by `chezmoi diff` to review.

## Repo layout

- `dot_zshrc.tmpl` — shell configuration (plugins, Starship, Conda hook).
- `private_dot_config/wezterm/wezterm.lua` — WezTerm appearance, keybinds, background.
- `run_once_install-package-linux.sh.tmpl` — first-apply Ubuntu installer for dependencies and fonts.
- `run_once_install-package-darwin.sh.tmpl` — first-apply macOS installer for dependencies and fonts.
- `assets/xuenai.png` — terminal background image.

## Fonts I use

- Lyth Mono Term — main terminal font on macOS.
- Symbols Nerd Font Mono — prompt icon fallback on macOS.
- JetBrainsMono Nerd Font — main terminal + editor font elsewhere.
  - Nerd Fonts repo: https://github.com/ryanoasis/nerd-fonts
  - JetBrains Mono repo: https://github.com/JetBrains/JetBrainsMono
- PingFang SC — CJK fallback on macOS.
- Sarasa Mono SC — CJK fallback elsewhere.
  - Sarasa Gothic repo: https://github.com/be5invis/Sarasa-Gothic
- Apple Color Emoji — emoji fallback on macOS.
- Noto Color Emoji — emoji fallback elsewhere.
  - Noto Emoji repo: https://github.com/googlefonts/noto-emoji

## Zsh setup

- Takeaway: I use Oh My Zsh to manage my zsh plugins and starship as my topic.
- Plugins: Oh My Zsh with plugins:
  - `git` — Git shortcuts and tab completion.
  - `autojump` — jump to frequently used directories with fuzzy memory (`j <name>`).
  - `copypath` — copy current path to clipboard (`copypath`).
  - `zsh-vi-mode` — modal editing and movement (Esc to enter normal mode; `vv` to edit command in $EDITOR).
  - `zsh-autosuggestions` — ghost text suggestions from history; accept with → or `End`.
  - `zsh-syntax-highlighting` — colors for valid/invalid commands as you type.
- Prompt: Starship with the Tokyo Night preset (patched Nerd Font). Minimal segments + powerline glyph separators; shows git state, dir, runtimes, and clean exit indicator. Reload/init with `eval "$(starship init zsh)"`.
- Extra env: sourced from `~/.local/bin/env` for local secrets/paths.

## WezTerm setup

- Takeaway: written in Rust and GPU accelerated so I like it.
- Fonts/colors: Lyth Mono Term on macOS; Nerd Font symbols + CJK and emoji fallbacks; `Catppuccin Mocha`, 100% window opacity, custom background `assets/xuenai.png`.
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

## Vim

- just load this vim config

## Video

- ubuntu: VLC
- Mac: TODO

## Browser

No matter what browser are you using. Remember to load the vim extention.

- Extension list
  - Copy LaTeX, I change the default ctrl+c to copy the math formula as markdown latex with $$, chec the https://github.com/Immortal-Fates/copy-latex-chrome-extension#

- ubuntu: I try microsoft-edge and chrome
- Mac: I want to try dia browser

## Launcher

- Mac: raycast

## Todo

- [ ] use all the config in lua
- [ ] add vscode config file
- [ ] add cc-switch config

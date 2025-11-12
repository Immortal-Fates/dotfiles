-- =============================================
-- 轻量版 WezTerm 配置
-- =============================================

local wezterm = require("wezterm")

local config = {}
if wezterm.config_builder then
  config = wezterm.config_builder()
end

-- =============================
-- 字体与外观
-- =============================

-- 主字体使用 JetBrainsMono Nerd Font
config.font = wezterm.font_with_fallback({
  "JetBrainsMono Nerd Font",  -- 主字体
  "Noto Color Emoji",         -- Emoji 备用
})

config.font_size = 13.0

-- 颜色主题
config.color_scheme = "Catppuccin Mocha"  -- 可用 wezterm ls-colors 查看全部主题

-- 背景透明度
config.window_background_opacity = 0.95
config.text_background_opacity = 1.0

-- 光标样式
config.default_cursor_style = "BlinkingBar"

-- 隐藏标题栏（仅保留可调整大小边框）
config.window_decorations = "RESIZE"

-- =============================
-- 启动行为与窗口参数
-- =============================

-- 默认使用 zsh 登录模式
config.default_prog = { "/usr/bin/zsh", "-l" }

-- 初始窗口尺寸
config.initial_cols = 120
config.initial_rows = 32

-- 内边距（让窗口更美观）
config.window_padding = {
  left = 5, right = 5, top = 5, bottom = 5,
}

-- 如果只开一个标签页则隐藏 tab 栏
config.hide_tab_bar_if_only_one_tab = false

-- 关闭标签页不再弹出确认提示
config.window_close_confirmation = "NeverPrompt"

-- =============================
-- ️ 快捷键（简洁实用）
-- =============================

config.keys = {
  -- 新建标签页
  { key = "t", mods = "CTRL|SHIFT", action = wezterm.action.SpawnTab("CurrentPaneDomain") },
  -- 关闭标签页
  { key = "w", mods = "CTRL|SHIFT", action = wezterm.action.CloseCurrentTab({ confirm = false }) },
  -- 水平分屏
  { key = "e", mods = "CTRL|SHIFT", action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }) },
  -- 垂直分屏
  { key = "o", mods = "CTRL|SHIFT", action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }) },
  -- 切换分屏
  { key = "Tab", mods = "CTRL", action = wezterm.action.ActivatePaneDirection("Next") },

  -- Pane navigation
  { key = "h", mods = "ALT", action = wezterm.action.ActivatePaneDirection("Left") },
  { key = "l", mods = "ALT", action = wezterm.action.ActivatePaneDirection("Right") },
  { key = "k", mods = "ALT", action = wezterm.action.ActivatePaneDirection("Up") },
  { key = "j", mods = "ALT", action = wezterm.action.ActivatePaneDirection("Down") },
}

return config

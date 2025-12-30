-- =============================================
-- Lightweight WezTerm Configuration (Compatible)
-- =============================================

local wezterm = require("wezterm")

local config = {}
if wezterm.config_builder then
  config = wezterm.config_builder()
end

-- =============================================
-- Font & Appearance
-- =============================================

config.font = wezterm.font_with_fallback({
  "JetBrainsMono Nerd Font",
  "Sarasa Mono SC",
  "Noto Color Emoji",
})

config.font_size = 14.0

config.color_scheme = "Catppuccin Mocha"

config.window_background_opacity = 0.8
config.text_background_opacity = 1.0

config.default_cursor_style = "BlinkingBar"

-- Background picture
config.window_background_image = wezterm.home_dir .. "/dotfiles/assets/xuenai.png"

config.window_background_image_hsb = {
  brightness = 0.2,
}


-- No title bar or window controls
config.window_decorations = "NONE"

-- Highlight active pane using dimming (works on all versions)
config.inactive_pane_hsb = {
  saturation = 0.7,
  brightness = 0.4,
}

-- =============================================
-- Startup & Window Settings
-- =============================================

config.default_prog = { "tmux", "new-session", "-A", "-s", "main" }

config.initial_cols = 210
config.initial_rows = 56

config.window_padding = {
  left = 5,
  right = 5,
  top = 5,
  bottom = 5,
}

config.enable_tab_bar = false
config.hide_tab_bar_if_only_one_tab = true
config.window_close_confirmation = "NeverPrompt"

-- =============================================
-- Key Bindings
-- =============================================

config.keys = {
  -- New tab
  {
    key = "t",
    mods = "CTRL|SHIFT",
    action = wezterm.action.SpawnTab("CurrentPaneDomain"),
  },

  -- Close tab
  {
    key = "w",
    mods = "CTRL|SHIFT",
    action = wezterm.action.CloseCurrentTab({ confirm = false }),
  },
  -- -- Horizontal split
  -- {
    -- key = "e",
    -- mods = "CTRL|SHIFT",
    -- action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }),
  -- },

  -- -- Vertical split
  -- {
    -- key = "o",
    -- mods = "CTRL|SHIFT",
    -- action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }),
  -- },

  -- Cycle panes
  {
    key = "Tab",
    mods = "CTRL",
    action = wezterm.action.ActivatePaneDirection("Next"),
  },

  -- Pane navigation (handled by tmux; keep Alt+h/j/k/l free)
}

return config

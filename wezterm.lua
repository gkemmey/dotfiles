local wezterm = require("wezterm")
local act = wezterm.action
local config = wezterm.config_builder()

-- ref: https://github.com/Defman21/base16-github-scheme/blob/master/github.yaml
-- ref: https://wezfurlong.org/wezterm/config/lua/wezterm.color/load_base16_scheme.html
-- base00: "#ffffff"
-- base01: "#f5f5f5"
-- base02: "#c8c8fa"
-- base03: "#969896"
-- base04: "#e8e8e8"
-- base05: "#333333"
-- base06: "#ffffff"
-- base07: "#ffffff"
-- base08: "#ed6a43"
-- base09: "#0086b3"
-- base0A: "#9a6700" -- i changes this was #795da3
-- base0B: "#116329" -- i changed this was #183691
-- base0C: "#183691"
-- base0D: "#795da3"
-- base0E: "#a71d5d"
-- base0F: "#333333"
config.colors = {
  foreground = "#333333", -- 05
  background = "#ffffff", -- 00
  cursor_bg = "#333333", -- 05
  cursor_border = "#333333", -- 05
  cursor_fg = "#333333", -- 05
  selection_bg = "#333333", -- 05
  selection_fg = "#ffffff", -- 00
  ansi = {
    "#ffffff", -- 00
    "#ed6a43", -- 08
    "#116329", -- 0B
    "#9a6700", -- 0A
    "#795da3", -- 0D
    "#a71d5d", -- 0E
    "#183691", -- 0C
    "#333333"  -- 05
  },
  brights = {
    "#969896", -- 03
    "#ed6a43", -- 08
    "#116329", -- 0B
    "#9a6700", -- 0A
    "#795da3", -- 0D
    "#a71d5d", -- 0E
    "#183691", -- 0C
    "#ffffff"  -- 07
  },
  tab_bar = {
    active_tab = { bg_color = "#ffffff", fg_color = "#183691" },
    inactive_tab = { bg_color = "#ffffff", fg_color = "#333333" },
    inactive_tab_edge = "#333333",
    inactive_tab_hover = { bg_color = "#ffffff", fg_color = "#969896" },
    new_tab = { bg_color = "#ffffff", fg_color = "#333333" },
    new_tab_hover = { bg_color = "#ffffff", fg_color = "#969896" },
  },
}

config.font = wezterm.font_with_fallback({
  { family = "Monego Nerd Font Fix", weight = "Regular", harfbuzz_features = { 'calt=0', 'clig=0', 'liga=0' } },
  { family = "Apple Color Emoji", weight = "Regular" }
})
config.cell_width = 0.95
config.font_size = 14
config.freetype_load_target = "Light" -- ref: https://github.com/wez/wezterm/issues/3774
config.freetype_load_flags = "NO_HINTING" -- ref: https://github.com/wez/wezterm/issues/3774
config.freetype_render_target = "HorizontalLcd" -- ref: https://github.com/wez/wezterm/issues/3774
config.line_height = 1.25

config.scrollback_lines = 10000

config.use_fancy_tab_bar = true
config.window_frame = {
  font = wezterm.font { family = "Monaco" },
  font_size = 14,
  active_titlebar_bg = "#ffffff",
  inactive_titlebar_bg = "#ffffff",
}

config.leader = { key = "Space", mods = "CTRL", timeout_milliseconds = 1000 }
config.keys = {
  { key = "d", mods = "LEADER", action = act.ShowDebugOverlay },
  { key = "s", mods = "LEADER", action = act.ActivateKeyTable { name = "split_mode", one_shot = true } },

  { key = "P", mods = "SUPER", action = act.ActivateCommandPalette },
  { key = "P", mods = "SHIFT|SUPER", action = act.ActivateCommandPalette },
  { key = "p", mods = "SHIFT|SUPER", action = act.ActivateCommandPalette },

  { key = "k", mods = "SUPER", action = act.ClearScrollback "ScrollbackAndViewport" },

  { key = "c", mods = "SUPER", action = act.CopyTo "Clipboard" },
  { key = "v", mods = "SUPER", action = act.PasteFrom "Clipboard" },

  { key = "{", mods = "SHIFT|SUPER", action = act.ActivateTabRelative(-1) },
  { key = "}", mods = "SHIFT|SUPER", action = act.ActivateTabRelative(1) },
  { key = "[", mods = "SHIFT|SUPER", action = act.ActivateTabRelative(-1) },
  { key = "]", mods = "SHIFT|SUPER", action = act.ActivateTabRelative(1) },

  { key = "{", mods = "SHIFT|OPT", action = act.ActivatePaneDirection("Prev") },
  { key = "}", mods = "SHIFT|OPT", action = act.ActivatePaneDirection("Next") },
  { key = "[", mods = "SHIFT|OPT", action = act.ActivatePaneDirection("Prev") },
  { key = "]", mods = "SHIFT|OPT", action = act.ActivatePaneDirection("Next") },

  { key = "{", mods = "SHIFT|CTRL", action = act.MoveTabRelative(-1) },
  { key = "}", mods = "SHIFT|CTRL", action = act.MoveTabRelative(1) },
  { key = "[", mods = "SHIFT|CTRL", action = act.MoveTabRelative(-1) },
  { key = "]", mods = "SHIFT|CTRL", action = act.MoveTabRelative(1) },

  { key = 'f', mods = 'SHIFT|CTRL', action = act.Search({ CaseInSensitiveString = '' }) },
  { key = 'f', mods = 'SUPER', action = act.Search({ CaseInSensitiveString = '' }) },

  { key = "LeftArrow", mods = "OPT", action = act.SendKey { key = "b", mods = "ALT" } },
  { key = "RightArrow", mods = "OPT", action = act.SendKey { key = "f", mods = "ALT" } },
  { key = "LeftArrow", mods = "SUPER", action = act.SendKey { key = "Home", mods = "NONE" } },
  { key = "RightArrow", mods = "SUPER", action = act.SendKey { key = "End", mods = "NONE" } },

  { key = "UpArrow", mods = "SUPER", action = act.ScrollToTop },
  { key = "DownArrow", mods = "SUPER", action = act.ScrollToBottom },
}

config.key_tables = {
  split_mode = {
    { key = "-", mods = "", action = wezterm.action.SplitVertical { domain = 'CurrentPaneDomain' }, },
    { key = "|", mods = "SHIFT", action = wezterm.action.SplitHorizontal { domain = 'CurrentPaneDomain' }, },
  },
}

return config

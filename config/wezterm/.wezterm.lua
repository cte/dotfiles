local wezterm = require 'wezterm'

-- start config

local config = {}

if wezterm.config_builder then
  config = wezterm.config_builder()
end

-- window

config.window_background_opacity = 0.5
config.macos_window_background_blur = 50
-- config.window_decorations = 'RESIZE'

-- cursor

config.default_cursor_style = 'BlinkingUnderline'
config.cursor_blink_rate = 400
config.cursor_blink_ease_in = 'Linear'
config.cursor_blink_ease_out = 'Linear'

-- font

-- local font_family = 'Operator Mono SSm Lig Medium'
-- local font_family = 'Berkeley Mono'
-- local font_family = 'Input'
local font_family = 'GeistMono Nerd Font'
-- local font_family = 'JetBrainsMono Nerd Font'
-- local font_family = 'SpaceMono Nerd Font'
-- local font_family = 'NotoSansM Nerd Font Mono'
-- local font_family = 'Monaspace Argon'
local font_size = 18
local font = wezterm.font({ family = font_family, weight = 'Medium' })

config.font = font
config.font_size = font_size

-- color scheme

config.color_scheme = 'Hardcore'

-- tab bar

local bar = wezterm.plugin.require("https://github.com/adriankarlen/bar.wezterm")
bar.apply_to_config(config)

-- key bindings

config.keys = {
  -- https://github.com/wez/wezterm/discussions/2426
  {
    key = 'c',
    mods = 'CTRL',
    action = wezterm.action_callback(function(window, pane)
      if pane:is_alt_screen_active() then
        window:perform_action(wezterm.action.SendKey{ key='c', mods='CTRL' }, pane)
      else
        window:perform_action(wezterm.action{ CopyTo = 'ClipboardAndPrimarySelection' }, pane)
      end
    end),
  },

  { key = 'v', mods = 'CTRL', action = wezterm.action{ PasteFrom = 'Clipboard' } },
  { key = 't', mods = 'CTRL', action = wezterm.action.SpawnTab 'CurrentPaneDomain' },
}

return config

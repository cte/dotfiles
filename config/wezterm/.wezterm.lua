local wezterm = require 'wezterm'

-- globals

-- local font_family = 'Operator Mono SSm Lig Medium'
-- local font_family = 'Berkeley Mono'
-- local font_family = 'Input'
-- local font_family = 'GeistMono Nerd Font'
-- local font_family = 'JetBrainsMono Nerd Font'
-- local font_family = 'SpaceMono Nerd Font'
local font_family = 'NotoSansM Nerd Font Mono'
-- local font_family = 'Monaspace Argon'
local font_size = 16
local font = wezterm.font({ family = font_family, weight = 'Medium' })

-- config

local config = {}

if wezterm.config_builder then
  config = wezterm.config_builder()
end

-- config.front_end = "WebGpu"
config.enable_wayland = false

config.initial_rows = 30
config.initial_cols = 120

config.window_background_opacity = 0.7
config.macos_window_background_blur = 50

config.default_cursor_style = 'BlinkingUnderline'
config.cursor_blink_rate = 400
config.cursor_blink_ease_in = 'Linear'
config.cursor_blink_ease_out = 'Linear'

config.color_scheme = 'Catppuccin Mocha'

config.font = font
config.font_size = font_size

-- tabs, title

config.use_fancy_tab_bar = true
config.hide_tab_bar_if_only_one_tab = true
config.tab_bar_at_bottom = false

config.window_frame = {
  font = font,
  font_size = font_size,
  active_titlebar_bg = '#222222',
  inactive_titlebar_bg = '#222222',
}

config.colors = {
  tab_bar = {
    inactive_tab_edge = '#222222',
    inactive_tab = {
      bg_color = '#222222',
      fg_color = '#666666',      
    },
    inactive_tab_hover = {
      bg_color = '#222222',
      fg_color = '#999999',
    },      
    active_tab = {
      bg_color = '#222222',
      fg_color = '#ffffff',      
    },
    new_tab = {
      bg_color = '#222222',
      fg_color = '#999999',
    },
    new_tab_hover = {
      bg_color = '#222222',
      fg_color = '#ffffff',
    },
  },
}

function tab_title(tab)
  local title = tab.tab_title

  if title and #title > 0 then
    return title
  end

  return tab.active_pane.title
end

wezterm.on('format-tab-title', function(tab, tabs, panes, config, hover, max_width)
  return {
    { Text = ' [ ' .. tab_title(tab) .. ' ] ' },
  }
end)

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

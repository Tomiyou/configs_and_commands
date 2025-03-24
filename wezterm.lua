local wezterm = require 'wezterm'
local mux = wezterm.mux
local act = wezterm.action

local config = {}

if wezterm.config_builder then
  config = wezterm.config_builder()
end

config.font = wezterm.font('CommitMono-Tomo')
config.font_size = 13
-- config.front_end = "WebGpu"
config.front_end = "OpenGL"

config.line_height = 1.0

config.enable_scroll_bar = true

config.window_padding = {
  left = 0,
  right = 4,
  top = 6,
  bottom = 0,
}

config.check_for_updates = false

-- config.initial_rows = 2
-- config.initial_cols = 130

-- config.window_decorations = "INTEGRATED_BUTTONS|RESIZE"
-- config.integrated_title_button_style = "Gnome"

config.colors = {
  -- The default text color: Almost white
  foreground = '#FFFFFF',
  -- The default background color: Black
  background = '#000000',

  split = '#F1F1F1',

  -- Terminator terminal Ambience color scheme
  ansi = {
    '#2E3436',
    '#CC0000',
    '#4E9A06',
    '#C4A000',
    '#3465A4',
    '#75507B',
    '#06989A',
    '#D3D7CF',
  },
  brights = {
    '#555753',
    '#EF2929',
    '#8AE234',
    '#FCE94F',
    '#729FCF',
    '#AD7FA8',
    '#34E2E2',
    '#EEEEEC',
  },

  -- The color of the scrollbar "thumb"; the portion that represents the current viewport
  scrollbar_thumb = '#FFFFFF',
}

config.bold_brightens_ansi_colors = false
config.force_reverse_video_cursor = true
-- config.force_reverse_video_selection = true

config.hide_tab_bar_if_only_one_tab = false
config.xcursor_theme = 'Yaru'
config.xcursor_size = 24

config.keys = {
  -- Turn off the default CMD-m Hide action, allowing CMD-m to
  -- be potentially recognized and handled by the tab
  {
    key = 'm',
    mods = 'CMD',
    action = wezterm.action.DisableDefaultAssignment,
  },
  -- Wezterm clear screen
  {
    key = 'K',
    mods = 'CTRL|SHIFT',
    action = act.Multiple {
      act.ClearScrollback 'ScrollbackAndViewport',
      act.SendKey { key = 'L', mods = 'CTRL' },
    },
  },
  -- Tmux clear screen
  {
    key = 'K',
    mods = 'CTRL|SHIFT|ALT',
    action = act.Multiple {
      act.ClearScrollback 'ScrollbackOnly',
      act.SendKey { key = 'L', mods = 'CTRL' },
    },
  },
  -- Wezterm horizontal split
  {
    key = 'o',
    mods = 'SHIFT|CTRL',
    action = act.SplitVertical{ domain =  'CurrentPaneDomain' }
  },
  -- Tmux horizontal split
  {
    key = 'o',
    mods = 'SHIFT|CTRL|ALT',
    action = act.Multiple {
      act.SendKey { key = 'b', mods = 'CTRL' },
      act.SendKey { key = '"' },
    },
  },
  -- Wezterm vertical split
  {
    key = 'l',
    mods = 'SHIFT|CTRL',
    action = act.SplitHorizontal{ domain =  'CurrentPaneDomain' }
  },
  -- Tmux vertical split
  {
    key = 'l',
    mods = 'SHIFT|CTRL|ALT',
    action = act.Multiple {
      act.SendKey { key = 'b', mods = 'CTRL' },
      act.SendKey { key = '%' },
    },
  },
  -- Wezterm pane zoom
  {
    key = 'X',
    mods = 'CTRL|SHIFT',
    action = wezterm.action.TogglePaneZoomState,
  },
  -- Tmux pane zoom
  {
    key = 'X',
    mods = 'CTRL|SHIFT|ALT',
    action = act.Multiple {
      act.SendKey { key = 'b', mods = 'CTRL' },
      act.SendKey { key = 'z' },
    },
  },
  -- Wezterm pane left
  {
    key = 'LeftArrow',
    mods = 'ALT',
    action = act.ActivatePaneDirection 'Left',
  },
  -- Wezterm pane right
  {
    key = 'RightArrow',
    mods = 'ALT',
    action = act.ActivatePaneDirection 'Right',
  },
  -- Wezterm pane up
  {
    key = 'UpArrow',
    mods = 'ALT',
    action = act.ActivatePaneDirection 'Up',
  },
  -- Wezterm pane down
  {
    key = 'DownArrow',
    mods = 'ALT',
    action = act.ActivatePaneDirection 'Down',
  },
  -- Tmux pane left
  {
    key = 'LeftArrow',
    mods = 'SHIFT|ALT',
    action = act.Multiple {
      act.SendKey { key = 'b', mods = 'CTRL' },
      act.SendKey { key = 'LeftArrow' },
    },
  },
  -- Tmux pane right
  {
    key = 'RightArrow',
    mods = 'SHIFT|ALT',
    action = act.Multiple {
      act.SendKey { key = 'b', mods = 'CTRL' },
      act.SendKey { key = 'RightArrow' },
    },
  },
  -- Tmux pane up
  {
    key = 'UpArrow',
    mods = 'SHIFT|ALT',
    action = act.Multiple {
      act.SendKey { key = 'b', mods = 'CTRL' },
      act.SendKey { key = 'UpArrow' },
    },
  },
  -- Tmux pane down
  {
    key = 'DownArrow',
    mods = 'SHIFT|ALT',
    action = act.Multiple {
      act.SendKey { key = 'b', mods = 'CTRL' },
      act.SendKey { key = 'DownArrow' },
    },
  },
  {
    key = 't',
    mods = 'CTRL',
    action = act.SpawnTab 'CurrentPaneDomain',
  },
  {
    key = 'R',
    mods = 'CTRL|SHIFT',
    action = act.PromptInputLine {
      description = 'Enter new name for tab',
      action = wezterm.action_callback(function(window, _, line)
        -- line will be `nil` if they hit escape without entering anything
        -- An empty string if they just hit enter
        -- Or the actual line of text they wrote
        if line then
          window:active_tab():set_title(line)
        end
      end),
    },
  },
  {
    key = 'Z',
    mods = 'CTRL|SHIFT',
    action = act.ShowTabNavigator,
  },
  {
    key = 'w',
    mods = 'CTRL',
    action = act.CloseCurrentTab{ confirm = true },
  },
  {
    key = 'J',
    mods = 'CTRL|SHIFT',
    action = act.PromptInputLine {
      description = 'Execute command in all panes',
      action = wezterm.action_callback(function(window, _, line)
        if line then
          pepes = window:active_tab():panes()
          for k,v in pairs(pepes) do
            v:send_text(line .. "\n")
          end
        end
      end),
    },
  },
}

return config

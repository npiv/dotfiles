local wezterm = require("wezterm")

local config = wezterm.config_builder()

config.color_scheme = "Catppuccin Macchiato"

--local font = "JetbrainsMono Nerd Font"
local font = "Maple Mono NF"
config.font = wezterm.font_with_fallback({
	font,
	"Hack",
	"DejaVu Sans Mono",
})

--config.default_prog = { "/opt/homebrew/bin/bash" }

config.font_size = 14.5
config.window_background_opacity = 0.94
config.macos_window_background_blur = 30
config.window_frame = {
	font = wezterm.font({ family = font, weight = "Bold" }),
	font_size = 14,
	-- Fancy tab bar
	active_titlebar_bg = "#574131",
	inactive_titlebar_bg = "#352a21",
}

config.window_decorations = "RESIZE"

config.hide_tab_bar_if_only_one_tab = true
config.tab_max_width = 60
config.use_fancy_tab_bar = false
config.window_padding = { left = 8, right = 0, top = 18, bottom = 10 }
config.scrollback_lines = 10000
config.cursor_thickness = 2
config.default_cursor_style = "SteadyBar"

wezterm.on("user-var-changed", function(window, pane, name, value)
	local overrides = window:get_config_overrides() or {}
	if name == "ZEN_MODE" then
		local incremental = value:find("+")
		local number_value = tonumber(value)
		if incremental ~= nil then
			while number_value > 0 do
				window:perform_action(wezterm.action.IncreaseFontSize, pane)
				number_value = number_value - 1
			end
			overrides.enable_tab_bar = false
		elseif number_value < 0 then
			window:perform_action(wezterm.action.ResetFontSize, pane)
			overrides.font_size = nil
			overrides.enable_tab_bar = true
		else
			overrides.font_size = number_value
			overrides.enable_tab_bar = false
		end
	end
	window:set_config_overrides(overrides)
end)

config.keys = {
	{ key = "Enter", mods = "SHIFT", action = wezterm.action.SendKey({ key = "J", mods = "CTRL" }) },
}

-- and finally, return the configuration to wezterm
return config

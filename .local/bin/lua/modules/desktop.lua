local desktop = {}

local command = require "modules/command"


local SWAY_DESKTOP = "sway"
local HYPRLAND_DESKTOP = "Hyprland"


function desktop.name()
	return os.getenv("XDG_CURRENT_DESKTOP")
end

function desktop.spawn(binary)
	local _, err
	if desktop.name() == HYPRLAND_DESKTOP then
		_, err = command.new("hyprctl")
			:arg("dispatch -- exec")
			:arg(binary)
			:spawn()
	elseif desktop.name() == SWAY_DESKTOP then
		_, err = command.new("swaymsg")
			:arg("exec --")
			:arg(binary)
			:spawn()
	end

	return err
end

return desktop

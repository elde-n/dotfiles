local M = {}

local watch_file = require "modules/watch-file"

local CONFIG_DIRECTORY = os.getenv("HOME") .. "/.config/"

function M.start()
	return {
		watch_file(CONFIG_DIRECTORY .. "waybar", true, function()
			os.execute("killall waybar")
		end, 0.1),

		watch_file(CONFIG_DIRECTORY .. "swaync", true, function()
			os.execute("swaync-client --reload-config")
		end, 0.1)
	}
end

return M

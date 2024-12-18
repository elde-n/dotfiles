local files = require "modules/files"
local notify = require "modules/notify"
local command = require "modules/command"


local LOW_CHARGE_VALUE = 16
local BRIGHTNESS_VALUE_ON_LOW_CHARGE = 8
local BATTERY_PATH = "/sys/class/power_supply/BAT1"


---@return boolean
local function is_low_charge()
	local status = files.read_file(BATTERY_PATH .. "/status")
	local capacity = files.read_file(BATTERY_PATH .. "/capacity")

	status = string.gsub(status, "%s", '')
	capacity = tonumber((string.gsub(capacity, "%s", '')))

	if status == "Discharging" and capacity <= LOW_CHARGE_VALUE then
		return true
	end

	return false
end

---@return number
local function alert()
	notify.new({
		title = "Battery low",
		body = string.format("<%d%% of charge remaining", LOW_CHARGE_VALUE)
	}):send()

	local brightness = command.new("brightnessctl")
		:arg("get")
		:run()
		.output

	command.new("brightnessctl")
		:arg("-q")
		:arg("set")
		:arg(string.format("%d%%", BRIGHTNESS_VALUE_ON_LOW_CHARGE))
		:run()

	return brightness
end

---@param brightness number
local function restore(brightness)
	command.new("brightnessctl")
		:arg("-q")
		:arg("set")
		:arg(brightness)
		:run()
end


local M = {}

local is_running = false

function M.start()
	if is_running then
		error("battery monitor is already running")
	end
	is_running = true

	local ran_alert = false
	local saved_brightness = 100

	local thread = coroutine.create(function()
		while true do
			if is_low_charge() and not ran_alert then
				ran_alert = true
				saved_brightness = alert()
			else
				if ran_alert then
					ran_alert = false
					restore(saved_brightness)
				end
			end

			coroutine.yield()
		end
	end)

	return {
		coroutine = thread,
		interval = 60
	}
end

return M
local clipboard = {}

local command = require "modules/command"

function clipboard.set(content)
	command.new("wl-copy"):arg(content):run()
end

function clipboard.get()
	local result = command.new("wl-paste"):run()
	return result.output
end

return clipboard

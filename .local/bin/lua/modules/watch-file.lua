local command = require "modules/command"

local WATCHER_TOOL = "watchexec"

--TODO: use json for stdio, so we can call callback with a json struct

---@param path string
---@param recursive boolean
---@param callback function
---@return table
return function(path, recursive, callback, interval)
	local interval = type(tonumber(interval)) == "number" and tonumber(interval) or 1
	local handle = command.new(WATCHER_TOOL)
		:arg("--quiet")
		:arg("--only-emit-events")
		:arg("--emit-events-to=stdio")
		:arg("--postpone") -- by default watchexec runs the command immediately
		:arg(recursive and "-w" or "-W", path)
		:spawn()

	local thread = coroutine.create(function()
		while handle.is_alive do
			local content = handle:read("*a")
			if content and content ~= '' then callback(content) end
			coroutine.yield()
		end
	end)

	return {
		coroutine = thread,
		interval = interval,

		close = function()
			return handle:close()
		end
	}
end

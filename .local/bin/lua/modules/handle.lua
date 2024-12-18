local handle = {}
handle.__index = handle

local helpers = require "modules/helpers"


function handle.new(process)
	local tmp_name = os.tmpname()
	local pipe = io.popen(process .. " > " .. helpers.wrap_quotes(tmp_name), 'w')

	if pipe == nil then
		error("failed to open process: " .. process)
	end

	pipe:setvbuf("no")

	return setmetatable({
		pipe = pipe,
		process = process,
		_tmp_name = tmp_name,
		is_alive = true
	}, handle)
end

---@param content string
---@return any
function handle:write(content)
	if not self.is_alive then
		return error("process is not alive")
	end

	return self.pipe:write(content), self.pipe:flush()
end

---@return string
function handle:read()
	if not self.is_alive then error("process is not alive") end

	local buffer = io.open(self._tmp_name)
	if buffer == nil then
		error("failed to open temporary file")
	end

	local content = buffer:read("*a"):sub(1, -2)
	buffer:close()

	if content ~= "" then
		local buffer = io.open(self._tmp_name, 'w')
		if buffer == nil then
			error("failed to open temporary file")
		end

		buffer:write()
		buffer:flush()
	end

	return content
end

---@return string, boolean, number
function handle:close()
	local status, code = self.pipe:close()
	local output = self:read()

	self.is_alive = false
	os.remove(self._tmp_name)

	return output, status, code
end

return handle

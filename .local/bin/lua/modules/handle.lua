local handle = {}
handle.__index = handle

local helpers = require "modules/helpers"


function handle.new(process)
	local tmp_name = os.tmpname()
	local pipe = io.popen(process .. " > " .. helpers.wrap_quotes(tmp_name), 'w')

	return setmetatable({
		pipe = pipe,
		process = process,
		_tmp_name = tmp_name
	}, handle)
end

function handle:write(content)
	return self.pipe:write(content), self.pipe:flush()
end

function handle:read()
	local buffer = io.open(self._tmp_name)
	return buffer:read("*a"):sub(1, -2), buffer:close()
end

function handle:close()
	local status, code = self.pipe:close()
	local output = self:read()

	os.remove(self._tmp_name)
	return output, status, code
end

return handle

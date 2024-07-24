local command = {}
command.__index = command

local handle = require "modules/handle"

function command.new(name)
	return setmetatable({
		binary = name,
		arguments = {}
	}, command)
end

function command:run()
	local output, status, code = self:spawn():close()
	if output == '' then output = nil end

	return {
		output = output,
		status = status,
		code = code
	}, code and true or false
end

function command:spawn()
	local run = string.format("(%s %s)", self.binary, table.concat(self.arguments, ' '))
	return handle.new(run)
end

function command:arg(...)
	for _, v in next, {...} do
		if type(v) ~= "string" and type(v) ~= "number" then
			error(string.format("Invalid argument was given, expected 'string' or 'number', got '%s'", type(v)))
		end

		table.insert(self.arguments, v)
	end

	return self
end

function command:pipe(c)
	return command.new(self.binary):arg(unpack(self.arguments))
		:arg('|'):arg(c.binary):arg(unpack(c.arguments))
end

return command

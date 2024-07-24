local json = {}

local context = {}
context.__index = context

local command = require "modules/command"
local helpers = require "modules/helpers"


function json.new(raw_json)
	return setmetatable({
		raw_json = raw_json
	}, context)
end

local function is_array(t)
	for k, v in next, t do
		if type(k) ~= "number" then
			return false
		end
	end

	return true
end

function json.encode(t)
	if is_array(t) then
		return json.new('[' .. table.concat(t, ", ") .. ']')
	end

	local j = {}
	for k, v in next, t do
		if type(k) ~= "string" then
			error(string.format("Invalid type for key, expected 'string', got %s", type(k)))
		end

		local value = tostring(v)
		if type(v) == "string" then
			value = '"' .. value .. '"'
		elseif type(v) == "table" then
			value = json.encode(v)
		end

		table.insert(j, string.format("\"%s\": %s", tostring(k), value))
	end

	return json.new('{' .. table.concat(j, ", ") .. '}')
end

function context:decode(compact)
	local c = command.new("jq")
	if compact then c:arg("-c") end

	local handle = c:spawn()
	handle:write(self.raw_json)

	local output = handle:read("*a")
	handle:close()

	return output
end

function context:retrieve(key)
	local handle = command.new("jq")
		:arg("-r", helpers.wrap_quotes(tostring(key)))
		:spawn()

	handle:write(self.raw_json)
	return handle:close()
end

return json

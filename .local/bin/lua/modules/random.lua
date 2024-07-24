local random = {}


local ASCII_BEGIN = 32
local ASCII_END = 126

local ASCII_LETTER_BEGIN = 65
local ASCII_LETTER_END = 90


function random.string(length)
	local value = {}
	for i = 1, length do
		value[i] = string.char(math.random(ASCII_BEGIN, ASCII_END))
	end

	return table.concat(value)
end

function random.alphanumeric(length)
	local alphanumeric = {}
	for i = 0, 9 do
		alphanumeric[i + 1] = i
	end

	for i = ASCII_LETTER_BEGIN, ASCII_LETTER_END do
		table.insert(alphanumeric, string.char(i))
		table.insert(alphanumeric, string.lower(string.char(i)))
	end

	local value = {}
	for i = 1, length do
		value[i] = alphanumeric[math.random(#alphanumeric)]
	end

	return table.concat(value)
end

return random

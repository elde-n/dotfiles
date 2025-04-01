local helpers = {}

function helpers.table_find(t, value)
	for i, v in next, t do
		if v == value then
			return i
		end
	end

	return nil
end

function helpers.table_flatten(t)
	local result = {}
	for _, v in next, t do
		if type(v) == "table" then
			for _, v2 in next, v do
				table.insert(result, helpers.table_flatten(v2))
			end
		else
			table.insert(result, v)
		end
	end

	return result
end

function helpers.string_split(content, seperator)
	local result = {}
	for v in string.gmatch(content, "([^" .. seperator .. "]+)") do
		table.insert(result, v)
	end

	return result
end

function helpers.wrap_quotes(s)
	return '"' .. s .. '"'
end

function helpers.format_number(n)
	local e = 1024
	local ex = { 'B', "KB", "MB", "GB", "TB" }

	if n < e then return tostring(n) .. ex[1] end

	local i = 1
	while n >= e and i < #ex do n, i = n / e, i + 1 end

	return string.format("%.2f%s", n, ex[i])
end

return helpers

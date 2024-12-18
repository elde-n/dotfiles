local files = {}

local command = require "modules/command"
local helpers = require "modules/helpers"


local IS_DIRECTORY_MESSAGE = "Is a directory"


---@param path string
local function remove_trailing_slash(path)
	if string.sub(path, -1, -1) == '/' then
		return string.sub(path, 1, -2)
	end
	return path
end

---@param path string
---@return string
function files.normalize_path(path)
	local normalized_path = {}

	local entries = string_split(path, '/')
	for _, entry in next, entries do
		if entry == '.' then
			error("unimplemented!")
		elseif entry == ".." then
			error("unimplemented!")
		elseif entry == "~" then
			error("unimplemented!")
		end
	end

	return table.concat(normalized_path, "/")
end

---@param file string
---@return string
function files.remove_extension(file)
	local extension = table.remove(helpers.string_split(file, '.'))
	return string.sub(file, 1, -(#extension + 2))
end

---@param path string
---@return boolean?
function files.is_directory(path)
	local handle = io.open(path, 'r')
	if not handle then return end

	local buffer = (select(2, handle:read("*a")))
	handle:close()

	return buffer == IS_DIRECTORY_MESSAGE
end

---@param path string
---@return boolean?
function files.is_file(path)
	local handle = io.open(path, 'r')
	if not handle then return end

	return not files.is_directory(path)
end

---@param path string
---@return string
function files.get_parent_directory(path)
	local list = helpers.string_split(remove_trailing_slash(path), '/')
	table.remove(list)
	if #list == 0 then return '/' end
	return table.concat(list, '/')
end

---@param path string
---@return string
function files.get_file_name(path)
	local list = helpers.string_split(remove_trailing_slash(path), '/')
	return list[#list]
end

---@param path string
---@return string
function files.read_file(path)
	local handle = assert(io.open(path, 'r'))
	local buffer = handle:read("*a")
	handle:close()

	return buffer
end

---@param path string
---@param content string
function files.write_file(path, content)
	local handle = assert(io.open(path, 'w'))

	handle:write(content)
	handle:close()
end

---@param path string
function files.remove_file(path)
	os.remove(path)
end

---@param path string
---@return table<string>
function files.read_directory(path)
	local result = command.new("ls"):arg("-a"):arg(path):run()
	local list = helpers.string_split(result.output, '\n')

	local index = helpers.table_find(list, '.')
	if index then table.remove(list, index) end

	index = helpers.table_find(list, "..")
	if index then table.remove(list, index) end

	local parent = remove_trailing_slash(path) .. '/'
	for i, child in next, list do
		list[i] = parent .. child
	end

	return list
end

---@param path string
function files.write_directory(path)
	os.execute("mkdir -p " .. path)
end

---@param file string
---@param path string
function files.move(file, path)
	if files.is_directory(path) then
		os.rename(file, remove_trailing_slash(path) .. '/' .. files.get_file_name(file))
	else
		os.rename(file, path)
	end
end

---@param file string
---@param path string
function files.copy(file, path)
	os.execute("cp -r " .. helpers.wrap_quotes(file) .. ' ' .. path)
end

return files

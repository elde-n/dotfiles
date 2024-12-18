-- returns true if 'id' is missing
local function is_running_as_user()
    local handle = io.popen("\\id -u")
	if handle then
		local result = handle:read("*a"):sub(1, -2)

		handle:close()
		return tonumber(result) == 1000
	end

	return true
end


if is_running_as_user() then
	require "elden"
else
	print("Not loading plugins.")
end

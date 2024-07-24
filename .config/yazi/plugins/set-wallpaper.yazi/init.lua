local M = {}

local get_hovered_file = ya.sync(function()
	return cx.active.current.hovered.url
end)

local function fail()
	ya.notify({
		title = "Set Wallpaper",
		content = "Failed to set wallpaper an error occured",
		timeout = 5,
		level = "warn"
	})
end


function M:entry()
	local url = get_hovered_file()
	local cha, err = fs.cha(url)
	if err then return fail() end

	if cha.is_dir then return end

	local child, err = Command("set-wallpaper")
		:arg(tostring(url))
		:spawn()
	if not child then return fail() end

	local status = child:wait()
	if not status or not status:success() then fail() end
end


return M

local M = {
	x = 20,
	y = 20
}

local get_urls = ya.sync(function()
	local urls = {}

	local file = cx.active.current.hovered
	table.insert(urls, file.url)

	for _, v in pairs(cx.active.selected) do
		if file.url ~= v then
			table.insert(urls, v)
		end
	end

	return urls
end)


local function fail()
	ya.notify({
		title = "Ripdrag",
		content = "Failed to launch ripdrag an error occured",
		timeout = 5,
		level = "warn"
	})
end


function M:entry()
	local files = {}
	for _, url in next, get_urls() do
		local cha, err = fs.cha(url)
		if err then fail() end

		if cha and not cha.is_dir then
			table.insert(files, tostring(url))
		end
	end

	ya.err(self.x, self.y)

	if #files == 0 then return end
	--local child, err = Command("hyprctl")
	--	:args({
	--		"dispatch", "--", "exec",
	--		string.format("[move %d, %d]", self.x, self.y),
	--		"ripdrag", "-b", "-x",
	--		'"' .. table.concat(files, '" "') .. '"'
	--	})
	--	:spawn()

	local child, err = Command("ripdrag")
		:args({"-b", "-x", '"' .. table.concat(files, '" "' .. '"')})
		:spawn()

	if not child then fail() end

	local status = child:wait()
	return status and status:success() and 1 or 2
end

function M:preload()
	return 1
end

return M

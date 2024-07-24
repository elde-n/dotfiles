local get_tabs = ya.sync(function(a, b)
	return cx.tabs
end)

return {
	setup = function()
		print(get_tabs())
	end
}

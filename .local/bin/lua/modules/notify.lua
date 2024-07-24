local notification = {}
notification.__index = notification

local command = require "modules/command"
local helpers = require "modules/helpers"


function notification.new(n)
	assert(n.title, "Title required for notification")
	return setmetatable({
		app_name = n.app_name,
		body = n.body or "",
		title = n.title,
		category = n.category,
		expire = n.expire,
		urgency = n.urgency,
		icon = n.icon,
		_command = command.new("notify-send")
	}, notification)
end

function notification:hint(t, name, value)
	self._command:arg("-h", string.format("%s:%s:%s", t, name, value))
	return self
end

function notification:action(name, text)
	self._command:arg("-A", name, text)
	return self
end

function notification:send()
	self._command:arg(helpers.wrap_quotes(self.title)):arg(helpers.wrap_quotes(self.body))

	if self.urgency then
		self._command:arg("-u", self.urgency)
	end
	if self.expire then
		self._command:arg("-t", self.expire)
	end
	if self.category then
		self._command:arg("-c", self.category)
	end
	if self.app_name then
		self._command:arg("-a", self.app_name)
	end
	if self.icon then
		self._command:arg("-i", self.icon)
	end

	self._command:run()
end


return notification

local command = require "modules/command"
local desktop = require "modules/desktop"

local HOME = os.getenv("HOME")

local M = {}

function M.start()
	command.new("tmux")
		:arg("new-session")
		:arg("-d -s 'home'")
		:run()

	command.new("tmux")
		:arg("new-session")
		:arg("-d -s 'code'")
		:run()

	command.new("tmux")
		:arg("new-window")
		:arg("-thome: -c")
		:arg(HOME)
		:arg(os.getenv("MAIL_CLIENT"))
		:run()

	command.new("tmux")
		:arg("new-window")
		:arg("-thome: -c")
		:arg(HOME .. "/Music")
		:arg(os.getenv("MUSIC_PLAYER"))
		:run()

	command.new("tmux")
		:arg("new-window")
		:arg("-tcode: -c")
		:arg(HOME .. "/Documents/code")
		:run()

	if desktop.name() == "sway" then
		-- TODO: move container to workspace won't work, cause it uses focused window.
		-- there's also no way to get the pid of the newly spawned process (lol)
		-- ALSO I would like this workspace to start as tabbed mode by default

		command.new("swaymsg")
			:arg("exec --")
			:arg(os.getenv("TERMINAL"), "-T homeland")
			:arg("-e tmux attach -thome")
			:run()
			:wait() -- lol

		-- TODO: add support for other terminals other than alacritty
		command.new("swaymsg")
			:arg("exec --")
			:arg(os.getenv("TERMINAL"), "msg create-window")
			:arg("-T code", "-e tmux attach -tcode")
			:spawn()
	end
end

return M

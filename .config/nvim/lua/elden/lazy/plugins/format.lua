---@param buffer_id integer
local function on_save(buffer_id)
	return { timeout_ms = 500, lsp_format = "fallback" }
end

---@param config table<any, any>
---@return string
local function rust_config_to_string(config)
	local config_string = {}
	for key, value in next, config do
		table.insert(
			config_string,
			string.format("%s=%s", key, tostring(value))
		)
	end

	return string.format("--config=%s", table.concat(config_string, ','))
end

return {
	"stevearc/conform.nvim",

	config = function()
		local conform = require "conform"

		conform.setup {
			format_on_save = on_save,
			formatters_by_ft = {
				go = { "gofmt" },
				rust = { "rustfmt" }
			}
		}

		if conform.formatters.rustfmt == nil then
			conform.formatters.rustfmt = { args = {} }
		end

		-- for anyone wondering why these options don't work,
		-- the rust team is a team of retards and make some formatting
		-- features "unstable" which requires you to use nightly on your toolchain.
		table.insert(conform.formatters.rustfmt.args, rust_config_to_string {
			trailing_comma = "Never",
			trailing_semicolon = false
		})
	end
}

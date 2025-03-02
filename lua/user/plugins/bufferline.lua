return {
	"akinsho/bufferline.nvim",
	version = "*",
	dependencies = "nvim-tree/nvim-web-devicons",
	config = function()
		local function diagnostics_indicator(_, _, diagnostics, _)
			local result = {}
			local symbols = {
				error = "",
				warning = "",
				info = "",
			}
			for name, count in pairs(diagnostics) do
				if symbols[name] and count > 0 then
					table.insert(result, symbols[name] .. " " .. count)
				end
			end
			result = table.concat(result, " ")
			return #result > 0 and result or ""
		end

		require("bufferline").setup({
			options = {
				highlights = {
					background = {
						italic = true,
					},
					buffer_selected = {
						bold = true,
					},
				},
				indicator = { style = "underline" },
				close_command = "Bdelete! %d",
				close_icon = "",
				themable = true,
				auto_toggle_bufferline = true,
				mode = "buffers", -- set to "tabs" to only show tabpages instead
				diagnostics = "nvim_lsp",
				diagnostics_update_in_insert = false,
				diagnostics_indicator = diagnostics_indicator,
				offsets = {
					{
						filetype = "neo-tree",
						text = "File Explorer",
						separator = true,
						highlight = "Directory",
					},
				},
				always_show_bufferline = true,
				sort_by = "id",
				debug = { logging = false },
			},
		})
	end,
}
